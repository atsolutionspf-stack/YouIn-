'use client';
// Canal de una comunidad (anuncios o chat de miembros).
//  * Historial persistente paginado (30 por página, "Cargar anteriores").
//  * Tiempo real con Supabase Realtime (postgres_changes respeta RLS: si a la
//    persona la expulsan, deja de recibir mensajes).
//  * Envío optimista con client_id: un reintento no duplica el mensaje.
//  * Marca como leído al ver el canal.
import { useCallback, useEffect, useLayoutEffect, useRef, useState, type FormEvent, type KeyboardEvent } from 'react';
import type { RealtimeChannel } from '@supabase/supabase-js';
import { useSession } from '@/components/providers/SessionProvider';
import { useToast } from '@/components/ui/Toast';
import { Icon } from '@/components/ui/Icon';
import { ErrorState, Loading } from '@/components/ui/States';
import { deleteMessage, fetchAuthorNames, fetchMessages, kickMember, markRead, sendMessage } from '@/lib/data/communities';
import { formatMessageTime, formatDateTime } from '@/lib/domain/time';
import type { MessageChannel, MessageRow } from '@/lib/types';

type LocalMessage = MessageRow & { pending?: boolean; failed?: string };

// Identificadores negativos temporales para mensajes aún no confirmados.
let localSeq = 0;

type Props = {
  communityId: string;
  channel: MessageChannel;
  canWrite: boolean;
  isAdmin: boolean;
  adminIds: string[];
  onRead?: () => void;
  onAccessLost?: () => void;
  emptyText: string;
};

export function ChatRoom({ communityId, channel, canWrite, isAdmin, adminIds, onRead, onAccessLost, emptyText }: Props) {
  const { db, user, profile } = useSession();
  const toast = useToast();
  const [messages, setMessages] = useState<LocalMessage[]>([]);
  const [names, setNames] = useState<Record<string, string>>({});
  const [hasMore, setHasMore] = useState(false);
  const [state, setState] = useState<'loading' | 'ready' | 'error'>('loading');
  const [error, setError] = useState('');
  const [live, setLive] = useState(false);
  const [text, setText] = useState('');
  const [loadingOlder, setLoadingOlder] = useState(false);
  const list = useRef<HTMLDivElement>(null);
  const stickToBottom = useRef(true);
  const restoreScroll = useRef<number | null>(null);
  const channelRef = useRef<RealtimeChannel | null>(null);
  const lastRead = useRef(0);

  const ensureNames = useCallback(async (rows: MessageRow[]) => {
    if (!db) return;
    const missing = [...new Set(rows.map((m) => m.author_id))].filter((id) => !(id in names));
    if (!missing.length) return;
    const found = await fetchAuthorNames(db, missing);
    setNames((n) => ({ ...n, ...found }));
  }, [db, names]);

  const markSeen = useCallback((rows: MessageRow[]) => {
    if (!db || !rows.length) return;
    const maxId = Math.max(...rows.filter((m) => m.id > 0).map((m) => m.id), 0);
    if (maxId > lastRead.current) {
      lastRead.current = maxId;
      void markRead(db, communityId, channel, maxId).then(() => onRead?.());
    }
  }, [db, communityId, channel, onRead]);

  const loadLatest = useCallback(async () => {
    if (!db) return;
    try {
      const page = await fetchMessages(db, communityId, channel);
      setMessages((current) => {
        const pending = current.filter((m) => m.pending || m.failed);
        return [...page.messages, ...pending.filter((p) => !page.messages.some((m) => m.client_id && m.client_id === p.client_id))];
      });
      setHasMore(page.hasMore);
      setState('ready');
      stickToBottom.current = true;
      void ensureNames(page.messages);
      markSeen(page.messages);
    } catch (e) {
      setError((e as Error).message);
      setState('error');
    }
  }, [db, communityId, channel, ensureNames, markSeen]);

  // Carga inicial + suscripción en tiempo real.
  useEffect(() => {
    if (!db) return;
    setState('loading');
    setMessages([]);
    lastRead.current = 0;
    void loadLatest();
    let wasSubscribed = false;
    const ch = db
      .channel(`community:${communityId}:${channel}:${Math.random().toString(36).slice(2)}`)
      .on('postgres_changes', { event: 'INSERT', schema: 'public', table: 'messages', filter: `community_id=eq.${communityId}` }, (payload) => {
        const m = payload.new as MessageRow;
        if (m.channel !== channel) return;
        setMessages((current) => {
          if (current.some((x) => x.id === m.id)) return current;
          const idx = m.client_id ? current.findIndex((x) => x.client_id === m.client_id) : -1;
          if (idx >= 0) { const copy = [...current]; copy[idx] = m; return copy; }
          return [...current, m];
        });
        void ensureNames([m]);
        if (document.visibilityState === 'visible') markSeen([m]);
      })
      .on('postgres_changes', { event: 'UPDATE', schema: 'public', table: 'messages', filter: `community_id=eq.${communityId}` }, (payload) => {
        const m = payload.new as MessageRow;
        setMessages((current) => current.map((x) => (x.id === m.id ? { ...x, ...m } : x)));
      })
      .subscribe((status) => {
        if (status === 'SUBSCRIBED') {
          setLive(true);
          // Tras una reconexión, recupera lo que llegó mientras tanto.
          if (wasSubscribed) void loadLatest();
          wasSubscribed = true;
        } else if (status === 'CHANNEL_ERROR' || status === 'TIMED_OUT' || status === 'CLOSED') {
          setLive(false);
        }
      });
    channelRef.current = ch;
    return () => { void db.removeChannel(ch); channelRef.current = null; };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [db, communityId, channel]);

  // Desplazamiento: al final para mensajes nuevos; se conserva al cargar anteriores.
  useLayoutEffect(() => {
    const el = list.current;
    if (!el) return;
    if (restoreScroll.current !== null) {
      el.scrollTop = el.scrollHeight - restoreScroll.current;
      restoreScroll.current = null;
    } else if (stickToBottom.current) {
      el.scrollTop = el.scrollHeight;
    }
  }, [messages]);

  async function loadOlder() {
    if (!db || !messages.length) return;
    const oldest = messages.find((m) => m.id > 0)?.id;
    if (!oldest) return;
    setLoadingOlder(true);
    try {
      const page = await fetchMessages(db, communityId, channel, oldest);
      restoreScroll.current = (list.current?.scrollHeight ?? 0) - (list.current?.scrollTop ?? 0);
      setMessages((current) => [...page.messages.filter((m) => !current.some((c) => c.id === m.id)), ...current]);
      setHasMore(page.hasMore);
      void ensureNames(page.messages);
    } catch (e) { toast((e as Error).message); } finally { setLoadingOlder(false); }
  }

  async function deliver(local: LocalMessage) {
    if (!db) return;
    try {
      const saved = await sendMessage(db, communityId, channel, local.body, local.client_id!);
      setMessages((current) => {
        const withoutDup = current.filter((m) => m.id !== saved.id || m.client_id === local.client_id);
        return withoutDup.map((m) => (m.client_id === local.client_id ? saved : m));
      });
      lastRead.current = Math.max(lastRead.current, saved.id);
      void markRead(db, communityId, channel, saved.id);
    } catch (e) {
      const message = (e as Error).message;
      setMessages((current) => current.map((m) => (m.client_id === local.client_id ? { ...m, pending: false, failed: message } : m)));
      if (/permisos/.test(message)) onAccessLost?.();
      else toast(message);
    }
  }

  function submit(e?: FormEvent) {
    e?.preventDefault();
    const body = text.trim();
    if (!body || !user) return;
    if (body.length > 1500) { toast('Máximo 1.500 caracteres.'); return; }
    const local: LocalMessage = {
      id: -(++localSeq), community_id: communityId, channel, author_id: user.id, body, created_at: new Date().toISOString(),
      deleted_at: null, client_id: crypto.randomUUID(), pending: true,
    };
    setNames((n) => ({ ...n, [user.id]: profile?.display_name ?? 'Tú' }));
    stickToBottom.current = true;
    setMessages((m) => [...m, local]);
    setText('');
    void deliver(local);
  }

  function onKey(e: KeyboardEvent<HTMLTextAreaElement>) {
    if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); submit(); }
  }

  async function remove(m: LocalMessage) {
    if (!db || !confirm(m.author_id === user?.id ? '¿Retirar tu mensaje?' : '¿Retirar este mensaje por moderación?')) return;
    try {
      await deleteMessage(db, m.id);
      setMessages((current) => current.map((x) => (x.id === m.id ? { ...x, body: '', deleted_at: new Date().toISOString() } : x)));
    } catch (e) { toast((e as Error).message); }
  }

  async function kick(m: LocalMessage) {
    if (!db) return;
    const reason = prompt(`¿Expulsar a ${names[m.author_id] ?? 'esta persona'}? No podrá leer ni escribir ni volver a unirse. Motivo (opcional):`);
    if (reason === null) return;
    try { await kickMember(db, communityId, m.author_id, reason); toast('Persona expulsada'); } catch (e) { toast((e as Error).message); }
  }

  if (state === 'loading') return <div className="chat-area"><Loading label="Cargando mensajes…" /></div>;
  if (state === 'error') return <ErrorState message={error} onRetry={loadLatest} />;

  return (
    <div className="chat-area">
      <div className="chat-top">
        <div style={{ flex: 1 }}>
          <h3>{channel === 'announcements' ? 'Anuncios' : channel === 'club' ? 'Club' : 'Chat de miembros'}</h3>
          <p>{channel === 'announcements' ? 'Solo la administración publica aquí.' : 'Mensajes con autor y fecha, visibles para los miembros.'}</p>
        </div>
        <span className={`realtime-status ${live ? 'on' : ''}`} title={live ? 'Conectado en tiempo real' : 'Reconectando…'}><i />{live ? 'En directo' : 'Reconectando…'}</span>
      </div>
      <div className="messages" ref={list} onScroll={(e) => {
        const el = e.currentTarget;
        stickToBottom.current = el.scrollHeight - el.scrollTop - el.clientHeight < 80;
      }} aria-live="polite" aria-label="Mensajes">
        {hasMore && <button className="secondary small load-older" onClick={loadOlder} disabled={loadingOlder}>{loadingOlder ? 'Cargando…' : 'Cargar mensajes anteriores'}</button>}
        {!messages.length && <div className="notice">{emptyText}</div>}
        {messages.map((m) => {
          const mine = m.author_id === user?.id;
          const authorIsAdmin = adminIds.includes(m.author_id);
          return (
            <div key={m.client_id ?? m.id} className={`bubble ${mine ? 'me' : ''} ${channel === 'announcements' ? 'announcement' : ''} ${m.deleted_at ? 'deleted' : ''} ${m.pending ? 'pending' : ''} ${m.failed ? 'failed' : ''}`}>
              <span className="author">{mine ? 'Tú' : names[m.author_id] ?? 'Miembro'}{authorIsAdmin && <span className="tag">Admin</span>}</span>
              {m.deleted_at ? 'Mensaje retirado' : <span style={{ whiteSpace: 'pre-wrap' }}>{m.body}</span>}
              <small title={formatDateTime(m.created_at)}>
                {m.pending ? 'Enviando…' : m.failed ? `No enviado: ${m.failed}` : <time dateTime={m.created_at}>{formatMessageTime(m.created_at)}</time>}
              </small>
              {!m.deleted_at && !m.pending && (m.failed || (m.id > 0 && (mine || isAdmin))) && (
                <span className="msg-actions">
                  {m.failed && <button onClick={() => { setMessages((c) => c.map((x) => x.client_id === m.client_id ? { ...x, failed: undefined, pending: true } : x)); void deliver(m); }}>Reintentar</button>}
                  {m.failed && <button onClick={() => setMessages((c) => c.filter((x) => x.client_id !== m.client_id))}>Descartar</button>}
                  {m.id > 0 && (mine || isAdmin) && <button onClick={() => remove(m)}>{mine ? 'Retirar' : 'Moderar'}</button>}
                  {m.id > 0 && isAdmin && !mine && !authorIsAdmin && <button onClick={() => kick(m)}>Expulsar</button>}
                </span>
              )}
            </div>
          );
        })}
      </div>
      {canWrite ? (
        <>
          <form className="composer" onSubmit={submit}>
            <textarea value={text} onChange={(e) => setText(e.target.value)} onKeyDown={onKey} rows={1} maxLength={1500}
              aria-label={channel === 'announcements' ? 'Escribe un anuncio' : 'Escribe un mensaje'}
              placeholder={channel === 'announcements' ? 'Escribe un anuncio para la comunidad…' : 'Escribe a la comunidad…'} />
            <button className="primary" aria-label="Enviar" disabled={!text.trim()}><Icon name="arrow" /></button>
          </form>
          <div className="composer-note">Intro para enviar · Mayús+Intro para salto de línea · máx. 1.500 caracteres. Se limitan ráfagas y mensajes repetidos.</div>
        </>
      ) : (
        <div className="composer-note" style={{ paddingTop: 12 }}>{channel === 'announcements' ? 'Solo la administración puede publicar anuncios.' : 'No puedes escribir en este canal.'}</div>
      )}
    </div>
  );
}

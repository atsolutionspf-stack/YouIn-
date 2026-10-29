'use client';
import Link from 'next/link';
import { useEffect, useMemo, useState } from 'react';
import { useSession } from '@/components/providers/SessionProvider';
import { Avatar } from '@/components/ui/Avatar';
import { Icon } from '@/components/ui/Icon';
import { Empty, ErrorState, Intro, Loading, NoBackend } from '@/components/ui/States';
import { fetchCommunities } from '@/lib/data/communities';
import { GENRES, normalize } from '@/lib/domain/events';

type Item = Awaited<ReturnType<typeof fetchCommunities>>[number];

export function CommunitiesPage() {
  const { configured, db, user, communities: mine, ready } = useSession();
  const [items, setItems] = useState<Item[] | null>(null);
  const [error, setError] = useState('');
  const [query, setQuery] = useState('');
  const [genre, setGenre] = useState('Todos');

  const load = () => {
    if (!db) return;
    setError('');
    fetchCommunities(db).then(setItems).catch((e) => setError((e as Error).message));
  };
  // eslint-disable-next-line react-hooks/exhaustive-deps
  useEffect(load, [db]);

  const found = useMemo(() => {
    const q = normalize(query);
    return (items ?? []).filter((c) => (genre === 'Todos' || c.genres.includes(genre)) &&
      (!q || normalize([c.name, c.description, c.entities?.name, ...c.genres].join(' ')).includes(q)));
  }, [items, query, genre]);

  if (!configured) return <NoBackend feature="Las comunidades" />;
  const myIds = new Set(mine.map((m) => m.community_id));

  return (
    <>
      <Intro kicker="Más allá de la pista" title={<>No es solo música.<br /><em>Es pertenecer.</em></>} sub="Un espacio para seguir conectados antes y después de la noche." />

      {ready && user && mine.length > 0 && (
        <>
          <div className="section-head" style={{ marginTop: 0 }}><h2>Mis comunidades</h2></div>
          <div className="my-communities">
            {mine.map((c) => {
              const unread = Number(c.unread_chat) + Number(c.unread_announcements);
              return (
                <Link key={c.community_id} className="my-community" href={`/comunidades/${c.slug}`}>
                  <span className="avatar lilac"><Icon name="people" size={18} /></span>
                  <span className="meta"><strong>{c.name}</strong><small>{c.is_admin ? 'Administras' : `De ${c.entity_name}`}{c.last_message_at ? ' · actividad reciente' : ''}</small></span>
                  {unread > 0 ? <span className="tab-count" aria-label={`${unread} sin leer`}>{unread}</span> : <Icon name="arrow" size={16} />}
                </Link>
              );
            })}
          </div>
        </>
      )}

      <div className="section-head"><h2>Encuentra tu comunidad</h2><span className="muted">Valencia</span></div>
      <div className="toolbar" style={{ marginTop: 0 }}>
        <div className="searchbox"><Icon name="search" size={18} /><input type="search" value={query} onChange={(e) => setQuery(e.target.value)} placeholder="Busca por nombre o estilo…" aria-label="Buscar comunidades" /></div>
      </div>
      <div className="chips" role="group" aria-label="Estilo musical">
        {['Todos', ...GENRES.filter((g) => g !== 'Sin clasificar')].map((g) => (
          <button key={g} className={`chip ${genre === g ? 'active' : ''}`} aria-pressed={genre === g} onClick={() => setGenre(g)}>{g}</button>
        ))}
      </div>
      {error ? <ErrorState message={error} onRetry={load} /> : !items ? <Loading /> : found.length ? (
        <div className="community-grid">
          {found.map((c) => (
            <article key={c.id} className="community-card">
              <header>{c.entities ? <Avatar p={c.entities} /> : <span className="avatar peach" />}<span className="tag">{c.genres.join(' · ') || 'Todos los estilos'}</span></header>
              <h3>{c.name}</h3>
              <p>Por {c.entities?.name}{c.is_demo ? ' · demostración' : ''}</p>
              <p>{c.description}</p>
              <div className="tags"><span className="tag">Comunidad gratuita</span><span className="tag">Club de pago separado</span></div>
              <Link className="primary" href={`/comunidades/${c.slug}`}>{myIds.has(c.id) ? 'Abrir comunidad' : 'Conocer la comunidad'} <Icon name="arrow" size={15} /></Link>
            </article>
          ))}
        </div>
      ) : (
        <Empty title="Ninguna comunidad coincide" icon="people">Prueba con otro nombre o estilo. Los DJs, salas y colectivos pueden crear la suya desde el panel.</Empty>
      )}
      <p className="help" style={{ marginTop: 18 }}>No hay mensajes privados entre usuarios en esta fase: la conversación ocurre en las comunidades.</p>
    </>
  );
}

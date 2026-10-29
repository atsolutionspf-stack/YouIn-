'use client';
import { createContext, useCallback, useContext, useEffect, useMemo, useState, type ReactNode } from 'react';
import { useRouter } from 'next/navigation';
import type { User } from '@supabase/supabase-js';
import { getBrowserClient } from '@/lib/supabase/client';
import { isSupabaseConfigured } from '@/lib/config';
import type { DB, MyCommunity, MyEntity } from '@/lib/types';
import {
  fetchMyEntities, fetchMyFavorites, fetchMyFollows, fetchMyProfile, setFavorite, setFollow, type MyProfile,
} from '@/lib/data/user';
import { fetchMyCommunities } from '@/lib/data/communities';
import { useToast } from '@/components/ui/Toast';

type SessionState = {
  configured: boolean;
  db: DB | null;
  ready: boolean;
  user: User | null;
  profile: MyProfile | null;
  favorites: Set<string>;
  follows: Set<string>;
  communities: MyCommunity[];
  entities: MyEntity[];
  djEntity: MyEntity | null;
  unreadTotal: number;
  toggleFavorite: (eventId: string) => Promise<void>;
  toggleFollow: (entityId: string) => Promise<void>;
  refreshCommunities: () => Promise<void>;
  refreshEntities: () => Promise<void>;
  refreshProfile: () => Promise<void>;
  signOut: () => Promise<void>;
  requireLogin: (reason?: string) => boolean;
};

const SessionContext = createContext<SessionState | null>(null);

export function SessionProvider({ children }: { children: ReactNode }) {
  const db = getBrowserClient();
  const router = useRouter();
  const toast = useToast();
  const [ready, setReady] = useState(!db);
  const [user, setUser] = useState<User | null>(null);
  const [profile, setProfile] = useState<MyProfile | null>(null);
  const [favorites, setFavorites] = useState<Set<string>>(new Set());
  const [follows, setFollows] = useState<Set<string>>(new Set());
  const [communities, setCommunities] = useState<MyCommunity[]>([]);
  const [entities, setEntities] = useState<MyEntity[]>([]);

  const loadUserData = useCallback(async (u: User | null) => {
    if (!db || !u) {
      setProfile(null); setFavorites(new Set()); setFollows(new Set()); setCommunities([]); setEntities([]);
      return;
    }
    const results = await Promise.allSettled([
      fetchMyProfile(db), fetchMyFavorites(db), fetchMyFollows(db), fetchMyCommunities(db), fetchMyEntities(db),
    ]);
    const [p, fav, fol, com, ent] = results;
    if (p.status === 'fulfilled') setProfile(p.value);
    if (fav.status === 'fulfilled') setFavorites(new Set(fav.value));
    if (fol.status === 'fulfilled') setFollows(new Set(fol.value));
    if (com.status === 'fulfilled') setCommunities(com.value);
    if (ent.status === 'fulfilled') setEntities(ent.value);
    if (results.some((r) => r.status === 'rejected')) toast('No se pudieron cargar todos tus datos. Recarga la página.');
  }, [db, toast]);

  useEffect(() => {
    if (!db) return;
    let active = true;
    db.auth.getUser().then(async ({ data }) => {
      if (!active) return;
      setUser(data.user);
      await loadUserData(data.user);
      if (active) setReady(true);
    });
    const { data: sub } = db.auth.onAuthStateChange((event, session) => {
      if (event === 'SIGNED_IN' || event === 'SIGNED_OUT' || event === 'USER_UPDATED') {
        const u = session?.user ?? null;
        setUser(u);
        void loadUserData(u);
      }
    });
    return () => { active = false; sub.subscription.unsubscribe(); };
  }, [db, loadUserData]);

  // Los no leídos se refrescan al volver a la pestaña y cada minuto.
  const refreshCommunities = useCallback(async () => {
    if (!db || !user) return;
    try { setCommunities(await fetchMyCommunities(db)); } catch { /* silencioso: se reintenta */ }
  }, [db, user]);
  useEffect(() => {
    if (!user) return;
    const onFocus = () => void refreshCommunities();
    window.addEventListener('focus', onFocus);
    const t = setInterval(onFocus, 60_000);
    return () => { window.removeEventListener('focus', onFocus); clearInterval(t); };
  }, [user, refreshCommunities]);

  const requireLogin = useCallback((reason?: string) => {
    if (user) return true;
    if (!isSupabaseConfigured) {
      toast('Modo demo sin servidor: las cuentas no están disponibles.');
      return false;
    }
    toast(reason ?? 'Entra para continuar.');
    router.push(`/entrar?next=${encodeURIComponent(window.location.pathname + window.location.search)}`);
    return false;
  }, [user, router, toast]);

  const toggleFavorite = useCallback(async (eventId: string) => {
    if (!db || !requireLogin('Entra para guardar eventos en tus favoritos.')) return;
    const on = !favorites.has(eventId);
    setFavorites((s) => { const n = new Set(s); if (on) n.add(eventId); else n.delete(eventId); return n; });
    try {
      await setFavorite(db, user!.id, eventId, on);
      toast(on ? 'Guardado en favoritos' : 'Quitado de favoritos');
    } catch (e) {
      setFavorites((s) => { const n = new Set(s); if (on) n.delete(eventId); else n.add(eventId); return n; });
      toast((e as Error).message);
    }
  }, [db, favorites, requireLogin, toast, user]);

  const toggleFollow = useCallback(async (entityId: string) => {
    if (!db || !requireLogin('Entra para seguir perfiles.')) return;
    const on = !follows.has(entityId);
    setFollows((s) => { const n = new Set(s); if (on) n.add(entityId); else n.delete(entityId); return n; });
    try {
      await setFollow(db, user!.id, entityId, on);
      toast(on ? 'Ahora lo sigues. Seguir no te une a su comunidad.' : 'Has dejado de seguirlo');
    } catch (e) {
      setFollows((s) => { const n = new Set(s); if (on) n.delete(entityId); else n.add(entityId); return n; });
      toast((e as Error).message);
    }
  }, [db, follows, requireLogin, toast, user]);

  const refreshEntities = useCallback(async () => {
    if (db && user) setEntities(await fetchMyEntities(db));
  }, [db, user]);
  const refreshProfile = useCallback(async () => {
    if (db && user) setProfile(await fetchMyProfile(db));
  }, [db, user]);

  const signOut = useCallback(async () => {
    if (!db) return;
    await db.auth.signOut();
    router.push('/');
    router.refresh();
  }, [db, router]);

  const value = useMemo<SessionState>(() => {
    const djEntity = entities.find((e) => e.kind === 'dj') ?? null;
    const unreadTotal = communities.reduce((n, c) => n + Number(c.unread_chat) + Number(c.unread_announcements), 0);
    return {
      configured: isSupabaseConfigured, db, ready, user, profile, favorites, follows, communities, entities, djEntity, unreadTotal,
      toggleFavorite, toggleFollow, refreshCommunities, refreshEntities, refreshProfile, signOut, requireLogin,
    };
  }, [db, ready, user, profile, favorites, follows, communities, entities, toggleFavorite, toggleFollow, refreshCommunities, refreshEntities, refreshProfile, signOut, requireLogin]);

  return <SessionContext.Provider value={value}>{children}</SessionContext.Provider>;
}

export function useSession() {
  const ctx = useContext(SessionContext);
  if (!ctx) throw new Error('useSession fuera de SessionProvider');
  return ctx;
}

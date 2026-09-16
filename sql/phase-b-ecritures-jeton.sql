-- =====================================================================
-- PHASE B SECURITE — NE PAS APPLIQUER AVANT LA FIN DE LA FINALE 2026
-- Prepare le 16 septembre 2026. A appliquer apres le 26 septembre, APRES
-- avoir deploye assets/js/lbma-jeton.js dans toutes les pages qui ecrivent.
--
-- Effet : les ecritures (INSERT/UPDATE/DELETE) depuis le web exigent l'en-tete
-- x-lbma-token d'une session valide (tout compte connecte). La lecture publique
-- ne change pas. Exceptions : visites (INSERT anonyme garde pour les statistiques
-- de visite).
-- =====================================================================

-- 1) Le jeton de la requete est-il valide ?
create or replace function public.lbma_jeton_valide()
returns boolean
language sql stable security definer set search_path = public
as $$
  select exists (
    select 1 from public.admin_sessions s join public.admin_users u on u.id = s.user_id
    where s.token = nullif(current_setting('request.headers', true)::json ->> 'x-lbma-token', '')
      and s.expires_at > now() and u.actif = true
  );
$$;
revoke all on function public.lbma_jeton_valide() from public;
grant execute on function public.lbma_jeton_valide() to anon, authenticated;

-- 2) Remplacer les policies d'ecriture ouvertes
do $$
declare
  r record;
  t text;
  tables_ecriture text[];
begin
  -- tables ayant au moins une policy ouverte d'ecriture pour anon/public
  select array_agg(distinct tablename) into tables_ecriture
  from pg_policies
  where schemaname = 'public'
    and cmd in ('INSERT', 'UPDATE', 'DELETE', 'ALL')
    and ('anon' = any(roles) or 'public' = any(roles))
    -- seulement les policies grandes ouvertes (true), jamais celles qui ont une vraie condition
    and coalesce(qual, 'true') = 'true' and coalesce(with_check, 'true') = 'true'
    and tablename not in ('admin_users', 'admin_sessions', 'fiche_tokens');

  -- supprimer ces policies d'ecriture (les policies SELECT restent)
  for r in
    select tablename, policyname, cmd from pg_policies
    where schemaname = 'public'
      and cmd in ('INSERT', 'UPDATE', 'DELETE', 'ALL')
      and ('anon' = any(roles) or 'public' = any(roles))
      and coalesce(qual, 'true') = 'true' and coalesce(with_check, 'true') = 'true'
      and tablename not in ('admin_users', 'admin_sessions', 'fiche_tokens')
  loop
    -- une policy ALL ouvrait aussi la lecture : garantir une policy SELECT
    if r.cmd = 'ALL' and not exists (select 1 from pg_policies p where p.schemaname='public'
         and p.tablename = r.tablename and p.cmd = 'SELECT') then
      execute format('create policy "lecture publique" on public.%I for select to anon, authenticated using (true)', r.tablename);
    end if;
    execute format('drop policy %I on public.%I', r.policyname, r.tablename);
  end loop;

  -- recreer l'ecriture pour les sessions valides
  foreach t in array coalesce(tables_ecriture, '{}') loop
    if t in ('birthday_emails_sent', 'fiche_tokens', 'admin_users', 'admin_sessions') then
      continue;  -- ecrites seulement par le serveur
    end if;
    if t = 'visites' then
      execute 'create policy "visite anonyme" on public.visites for insert to anon, authenticated with check (true)';
      continue;
    end if;
    execute format('create policy "ecriture connectee insert" on public.%I for insert to anon, authenticated with check ((select public.lbma_jeton_valide()))', t);
    execute format('create policy "ecriture connectee update" on public.%I for update to anon, authenticated using ((select public.lbma_jeton_valide())) with check ((select public.lbma_jeton_valide()))', t);
    execute format('create policy "ecriture connectee delete" on public.%I for delete to anon, authenticated using ((select public.lbma_jeton_valide()))', t);
  end loop;
end $$;

-- 3) Verification (a lancer ensuite) : aucune policy d'ecriture ouverte ne doit rester
-- select tablename, policyname, cmd, qual, with_check from pg_policies
-- where schemaname='public' and cmd in ('INSERT','UPDATE','DELETE','ALL')
--   and coalesce(qual,'') not like '%lbma_jeton_valide%' and coalesce(with_check,'') not like '%lbma_jeton_valide%';

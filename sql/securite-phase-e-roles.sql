-- Sécurité phase E — rôles (21 nov. 2026) — APPLIQUÉ
--
-- Avant : la base acceptait la session de N'IMPORTE QUEL compte actif (coach, marqueur,
-- admin, superadmin) pour écrire partout (règlements, joueurs, saison active, Temple…).
-- Décision de Serge : le marqueur saisit les matchs SEULEMENT.
--
-- lbma_jeton_valide() (tout compte actif) reste exigé sur les 9 tables de saisie de match :
--   matchs_regulier, matchs_series, pointage_frappeurs, pointage_lanceurs, pointage_manches,
--   frappeurs_saison, lanceurs_saison, frappeurs_series, lanceurs_series
-- Partout ailleurs (64 policies), et pour la vue joueurs_liste_admin (coordonnées),
-- c'est lbma_jeton_admin() : rôle admin ou superadmin seulement.
-- Testé (annulé) : marqueur → score et pointage oui, règlements non ; admin → tout ;
-- anonyme → rien.

create or replace function public.lbma_jeton_admin() returns boolean language sql stable security definer set search_path = public as $f$
  select exists (select 1 from public.admin_sessions s join public.admin_users u on u.id = s.user_id
    where s.token = nullif(current_setting('request.headers', true)::json ->> 'x-lbma-token', '')
      and s.expires_at > now() and u.actif = true and u.role in ('admin','superadmin'));
$f$;
grant execute on function public.lbma_jeton_admin() to anon, authenticated;

do $$
declare r record; stmt text;
begin
  for r in select policyname, tablename, qual, with_check from pg_policies
           where schemaname='public' and (coalesce(qual,'')||coalesce(with_check,'')) ilike '%lbma_jeton_valide%'
             and tablename not in ('matchs_regulier','matchs_series','pointage_frappeurs','pointage_lanceurs','pointage_manches',
                                   'frappeurs_saison','lanceurs_saison','frappeurs_series','lanceurs_series')
  loop
    stmt := format('alter policy %I on public.%I', r.policyname, r.tablename);
    if r.qual is not null then stmt := stmt || ' using (' || replace(r.qual,'lbma_jeton_valide','lbma_jeton_admin') || ')'; end if;
    if r.with_check is not null then stmt := stmt || ' with check (' || replace(r.with_check,'lbma_jeton_valide','lbma_jeton_admin') || ')'; end if;
    execute stmt;
  end loop;
end $$;

create or replace view public.joueurs_liste_admin with (security_invoker = false) as
  select id, nom, cote, role, telephone1, telephone2, courriel, naissance, saison, actif, created_at,
         adresse, ville, code_postal, telephone, province, photo_url, note_bio, numero_chandail, "position"
  from public.joueurs_liste
  where (select public.lbma_jeton_admin());

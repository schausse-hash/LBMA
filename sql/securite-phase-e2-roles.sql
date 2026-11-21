-- ============================================================================
-- Sécurité — phase E2 : rôles admin / superadmin (appliquée le 21 nov. 2026)
-- Migration Supabase : securite_phase_e2_roles_superadmin
--
-- Matrice des rôles :
--   marqueur / coach : pointage, scores et stats de la SAISON ACTIVE seulement
--                      (pas de déplacement de match : voir lbma_garde_horaire)
--   admin            : presque tout — déplacer un match, stats et pointage des
--                      saisons passées, carrière, records, classements,
--                      ajouter / modifier un joueur, règlements, Temple, médias,
--                      envois, photos, clés saison_info (sauf saison_active
--                      et repechage)
--   superadmin       : tout, et SEUL à pouvoir : gérer les comptes, changer
--                      saison_active, supprimer un joueur, tout le repêchage
--                      (repechage_picks, equipes_saison, saison_info
--                      'repechage'), ajouter / supprimer un match du
--                      calendrier, table historique « joueurs »
--
-- Note : la promotion d'un compte en superadmin a été faite directement dans
-- admin_users (non répétée ici — le dépôt est public).
-- ============================================================================

create or replace function public.lbma_jeton_superadmin() returns boolean language sql stable security definer set search_path = public as $f$
  select exists (select 1 from public.admin_sessions s join public.admin_users u on u.id = s.user_id
    where s.token = nullif(current_setting('request.headers', true)::json ->> 'x-lbma-token', '')
      and s.expires_at > now() and u.actif = true and u.role = 'superadmin');
$f$;

-- Saison « ouverte » = saison active ou future
create or replace function public.lbma_saison_ouverte(p_saison text) returns boolean language sql stable security definer set search_path = public as $f$
  select coalesce(p_saison ~ '^\d{4}$' and p_saison::int >= (select valeur::int from public.saison_info where cle = 'saison_active' and valeur ~ '^\d{4}$'), false);
$f$;

create or replace function public.lbma_match_ouvert(p_match bigint) returns boolean language sql stable security definer set search_path = public as $f$
  select exists (select 1 from public.matchs_regulier m where m.id = p_match and public.lbma_saison_ouverte(m.saison::text))
      or exists (select 1 from public.matchs_series m where m.id = p_match and public.lbma_saison_ouverte(m.saison::text));
$f$;

grant execute on function public.lbma_jeton_superadmin(), public.lbma_saison_ouverte(text), public.lbma_match_ouvert(bigint) to anon, authenticated;

do $$
declare t text;
  sa  constant text := '(select public.lbma_jeton_superadmin())';
  adm constant text := '(select public.lbma_jeton_admin())';
  val constant text := '(select public.lbma_jeton_valide())';
begin
  -- Repêchage, alignements, table historique : superadmin seulement
  foreach t in array array['repechage_picks','equipes_saison','joueurs'] loop
    execute format('alter policy "ecriture connectee insert" on public.%I with check (%s)', t, sa);
    execute format('alter policy "ecriture connectee update" on public.%I using (%s) with check (%s)', t, sa, sa);
    execute format('alter policy "ecriture connectee delete" on public.%I using (%s)', t, sa);
  end loop;
  execute format('alter policy "lecture connectee" on public.joueurs using (%s)', sa);

  -- Supprimer un joueur : superadmin (ajouter / modifier : admin, phase E1)
  execute format('alter policy "ecriture connectee delete" on public.joueurs_liste using (%s)', sa);

  -- saison_info : saison_active et repechage réservés au superadmin
  execute format('alter policy "ecriture connectee insert" on public.saison_info with check (%s or (%s and cle not in (''saison_active'',''repechage'')))', sa, adm);
  execute format('alter policy "ecriture connectee update" on public.saison_info using (%s or (%s and cle not in (''saison_active'',''repechage''))) with check (%s or (%s and cle not in (''saison_active'',''repechage'')))', sa, adm, sa, adm);
  execute format('alter policy "ecriture connectee delete" on public.saison_info using (%s or (%s and cle not in (''saison_active'',''repechage'')))', sa, adm);

  -- Calendrier : ajouter / supprimer = superadmin ; modifier = admin, ou
  -- marqueur pour un match de la saison ouverte (colonnes d'horaire bloquées
  -- par le déclencheur ci-dessous)
  foreach t in array array['matchs_regulier','matchs_series'] loop
    execute format('alter policy "ecriture connectee insert" on public.%I with check (%s)', t, sa);
    execute format('alter policy "ecriture connectee delete" on public.%I using (%s)', t, sa);
    execute format('alter policy "ecriture connectee update" on public.%I using (%s or (%s and public.lbma_saison_ouverte(saison::text))) with check (%s or (%s and public.lbma_saison_ouverte(saison::text)))', t, adm, val, adm, val);
  end loop;

  -- Stats de saison : admin partout, marqueur seulement la saison ouverte
  foreach t in array array['frappeurs_saison','lanceurs_saison','frappeurs_series','lanceurs_series'] loop
    execute format('alter policy "ecriture connectee insert" on public.%I with check (%s or (%s and public.lbma_saison_ouverte(saison::text)))', t, adm, val);
    execute format('alter policy "ecriture connectee update" on public.%I using (%s or (%s and public.lbma_saison_ouverte(saison::text))) with check (%s or (%s and public.lbma_saison_ouverte(saison::text)))', t, adm, val, adm, val);
    execute format('alter policy "ecriture connectee delete" on public.%I using (%s or (%s and public.lbma_saison_ouverte(saison::text)))', t, adm, val);
  end loop;

  -- Pointage : admin partout, marqueur seulement pour un match de la saison ouverte
  foreach t in array array['pointage_frappeurs','pointage_lanceurs','pointage_manches'] loop
    execute format('alter policy "ecriture connectee insert" on public.%I with check (%s or (%s and public.lbma_match_ouvert(match_id)))', t, adm, val);
    execute format('alter policy "ecriture connectee update" on public.%I using (%s or (%s and public.lbma_match_ouvert(match_id))) with check (%s or (%s and public.lbma_match_ouvert(match_id)))', t, adm, val, adm, val);
    execute format('alter policy "ecriture connectee delete" on public.%I using (%s or (%s and public.lbma_match_ouvert(match_id)))', t, adm, val);
  end loop;
end $$;

-- Garde d'horaire : un non-admin ne peut changer que le score, le statut et
-- les notes d'un match. SECURITY INVOKER obligatoire : en DEFINER,
-- current_user vaudrait le propriétaire et la garde ne bloquerait rien.
create or replace function public.lbma_garde_horaire() returns trigger language plpgsql security invoker set search_path = public as $f$
declare libres text[] := array['score_visiteur','score_local','status','source_saisie','notes','updated_at'];
begin
  if current_user not in ('anon','authenticated') or public.lbma_jeton_admin() then return new; end if;
  if (to_jsonb(new) - libres) is distinct from (to_jsonb(old) - libres) then
    raise exception 'Seul un admin peut modifier l''horaire (date, heure, équipes, terrain).' using errcode = '42501';
  end if;
  return new;
end $f$;

drop trigger if exists lbma_garde_horaire on public.matchs_regulier;
create trigger lbma_garde_horaire before update on public.matchs_regulier for each row execute function public.lbma_garde_horaire();
drop trigger if exists lbma_garde_horaire on public.matchs_series;
create trigger lbma_garde_horaire before update on public.matchs_series for each row execute function public.lbma_garde_horaire();

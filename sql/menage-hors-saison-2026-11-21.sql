-- Ménage hors saison (21 nov. 2026)
-- 1. Tables retirées : 20 copies de sécurité ponctuelles + 4 anciennes tables vides.
--    Export complet (493 lignes, un JSON par table) remis à Serge avant la suppression :
--    LBMA-tables-supprimees-2026-11-21.zip. Aucune page ne les lisait.
drop table if exists public.backup_belliveau_20260819, public.backup_cs_alignement_20260819, public.backup_cs_ecarts_20260819,
  public.backup_frappeurs_hits_20260627, public.backup_frappeurs_series_20260828, public.backup_lachapelle_jeremie_20261017,
  public.backup_lanceurs_series_20260828, public.backup_match334_20260821, public.backup_matchs_series_20260823,
  public.backup_matchs_series_20260824, public.backup_page_config_reglements_20260824, public.backup_page_config_reglements_20260914,
  public.backup_pc_impossibles_20260819, public.backup_test_126_pf_20260824, public.backup_test_126_pl_20260824,
  public.backup_test_series_20260824_frappeurs, public.backup_test_series_20260824_lanceurs,
  public.noms_backup_20260601, public.noms_backup_hetu_20260601, public.roster_backup_garcia_20260601,
  public.stats_match_frappeurs, public.stats_match_lanceurs, public.matchs, public.series_matches;

-- 2. Conseiller Supabase « search_path modifiable » : on fixe le chemin de recherche
--    des 3 fonctions signalées (empêche qu'un objet homonyme soit utilisé à leur place).
alter function public.update_modified_column() set search_path = public, pg_temp;
alter function public.calcul_moy_lanceur_series() set search_path = public, pg_temp;
alter function public.send_birthday_emails() set search_path = public, extensions, pg_temp;

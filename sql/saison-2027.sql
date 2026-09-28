-- =====================================================================
-- LBMA — PASSAGE À LA SAISON 2027
-- Préparé le 28 septembre 2026. À exécuter dans Supabase SQL Editor
-- (ou par Claude via execute_sql), UNE ÉTAPE À LA FOIS, dans l'ordre.
--
-- Repêchage 2027 : samedi 17 avril 2027 au Cerf Blanc.
-- Début de saison : samedi 8 mai 2027. Calendrier 2026 décalé de 364 jours
-- (les vendredis restent des vendredis), Fête nationale gardée au 24 juin.
--
--   ÉTAPE 1 — cet hiver, sans risque (n'affecte que le texte « repêchage »)
--   ÉTAPE 2 — le matin du repêchage, APRÈS avoir créé les joueurs 2027
--             dans l'admin (« Nouvelle Saison ») : calendrier + séries + saison active
--   ÉTAPE 3 — vérification
--   ÉTAPE 4 — retour arrière (seulement si problème)
-- =====================================================================


-- ---------------------------------------------------------------------
-- ÉTAPE 0 — État avant (à lire, ne modifie rien)
-- ---------------------------------------------------------------------
select cle, valeur from saison_info order by cle;
select saison, count(*) matchs from matchs_regulier where saison >= 2026 group by saison;
select saison, count(*) matchs from matchs_series   where saison >= 2026 group by saison;
select saison, count(*) joueurs from joueurs_liste  where saison::text >= '2026' group by saison;


-- ---------------------------------------------------------------------
-- ÉTAPE 1 — Cet hiver : date et lieu du repêchage (affiché sur le site)
-- ---------------------------------------------------------------------
update saison_info set valeur = '17 avril 2027 au Cerf Blanc' where cle = 'repechage';


-- ---------------------------------------------------------------------
-- ÉTAPE 2 — Le matin du repêchage 2027
-- Prérequis : admin → Joueurs (Liste) → « Nouvelle Saison » 2027 déjà fait
-- (la requête ci-dessous s'arrête sinon).
-- ---------------------------------------------------------------------
do $saison2027$
declare n_joueurs int; n_reg int; n_ser int;
begin
  select count(*) into n_joueurs from joueurs_liste where saison::text = '2027';
  if n_joueurs = 0 then
    raise exception 'STOP : aucun joueur 2027 dans joueurs_liste. Faire d''abord « Nouvelle Saison » dans l''admin.';
  end if;
  if exists (select 1 from matchs_regulier where saison = 2027) then
    raise exception 'STOP : le calendrier 2027 existe déjà (% matchs). Rien n''a été modifié.', (select count(*) from matchs_regulier where saison = 2027);
  end if;

  -- 2a) Calendrier régulier 2027 = calendrier 2026 décalé de 364 jours
  insert into matchs_regulier (saison, no_match, date, jour, heure, visiteur, local, score_visiteur, score_local, endroit, status, special, notes)
  select 2027, no_match,
    d.date2027,
    (array['DIMANCHE','LUNDI','MARDI','MERCREDI','JEUDI','VENDREDI','SAMEDI'])[extract(dow from d.date2027)::int + 1],
    case when m.id = 364 then '21H30' else m.heure end,           -- match reporté en 2026 : retour à sa case d'origine
    m.visiteur, m.local, null, null,
    case when m.id = 364 then 'JARRY 1' else m.endroit end,
    'avenir',
    case m.special when '9 mai' then '8 mai' when '8 août' then '7 août' else m.special end,
    ''
  from matchs_regulier m
  cross join lateral (select case when m.special = 'Fête Nationale' then date '2027-06-24'
                                  when m.id = 364 then date '2027-07-23'
                                  else m.date + 364 end as date2027) d
  where m.saison = 2026;
  get diagnostics n_reg = row_count;

  -- 2b) Gabarit des séries 2027 (équipes « À DÉTERMINER », seeds conservés), décalé de 364 jours.
  --     En août, le script de fin de saison remplit les équipes à partir des seeds (comme en 2026).
  insert into matchs_series (saison, ronde, no_match, date, jour, heure, visiteur, local, score_visiteur, score_local, endroit, status, notes, serie_id, serie_format, seed_visiteur, seed_local)
  select 2027, ronde, no_match, date + 364,
    (array['DIMANCHE','LUNDI','MARDI','MERCREDI','JEUDI','VENDREDI','SAMEDI'])[extract(dow from date + 364)::int + 1],
    heure, 'À DÉTERMINER', 'À DÉTERMINER', null, null, endroit, 'avenir', '', serie_id, serie_format, seed_visiteur, seed_local
  from matchs_series where saison = 2026;   -- visiteur/local sont obligatoires : « À DÉTERMINER » jusqu'au classement final
  -- match 12 (3e partie de la demi-finale B) n'a pas eu lieu en 2026 : on le remet dans le gabarit
  insert into matchs_series (saison, ronde, no_match, date, jour, heure, visiteur, local, endroit, status, notes, serie_id, serie_format, seed_visiteur, seed_local)
  select 2027, 'DEMI-FINALE', 12, date '2027-09-10', 'VENDREDI', '20H45', 'À DÉTERMINER', 'À DÉTERMINER', 'JARRY 1', 'avenir', 'Si nécessaire', 'R2-B', '2DE3', null, 2
  where not exists (select 1 from matchs_series where saison = 2027 and no_match = 12);
  select count(*) into n_ser from matchs_series where saison = 2027;

  -- 2c) Saison active → 2027 (à partir d'ici, tout le site affiche 2027)
  update saison_info set valeur = '2027' where cle = 'saison_active';

  raise notice 'OK : % matchs réguliers 2027, % matchs de séries 2027, saison_active = 2027, % joueurs 2027', n_reg, n_ser, n_joueurs;
end $saison2027$;


-- ---------------------------------------------------------------------
-- ÉTAPE 3 — Vérification (attendu : 75 matchs, 8 mai → 20 août, 17 séries,
-- saison_active 2027, aucun match un autre jour que VEN/SAM sauf le 24 juin)
-- ---------------------------------------------------------------------
select count(*) matchs, min(date) premier, max(date) dernier from matchs_regulier where saison = 2027;
select date, jour, count(*) from matchs_regulier where saison = 2027 and jour not in ('VENDREDI','SAMEDI') group by 1,2;
select no_match, ronde, serie_id, date, jour, heure, endroit from matchs_series where saison = 2027 order by no_match;
select cle, valeur from saison_info where cle in ('saison_active','repechage');


-- ---------------------------------------------------------------------
-- ÉTAPE 4 — Retour arrière (seulement si problème)
-- ---------------------------------------------------------------------
-- delete from matchs_series   where saison = 2027;
-- delete from matchs_regulier where saison = 2027;
-- update saison_info set valeur = '2026' where cle = 'saison_active';

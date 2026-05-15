-- =====================================================================
-- LBMA — DUMP COMPLET SÉCURITÉ (policies + fonctions + RPCs admin)
-- =====================================================================
-- Projet Supabase : xgyskiatppgaeaamjhxr (LBMA)
-- URL : https://xgyskiatppgaeaamjhxr.supabase.co
-- Généré le : 15 mai 2026
--
-- ⚠️ ARCHITECTURE LBMA (différente des 2 autres projets) :
--   - Pas d'auth utilisateur Supabase. L'auth admin se fait via
--     RPCs SECURITY DEFINER + bcrypt (login_user, save_user, etc.)
--   - La clé anon a accès à TOUT (lecture+écriture) sur la majorité
--     des tables — c'est le choix de design de LBMA (auth client-side
--     via localStorage.lbma_admin_session)
--   - Seule admin_users est protégée par auth.role() = 'service_role'
--     car elle contient les hashs bcrypt des mots de passe
--
-- Note : ce projet est volontairement plus ouvert car c'est une ligue
-- locale (ligue de balle molle amicale). Pas de données médicales ou
-- financières exposées.
-- =====================================================================


-- =====================================================================
-- SECTION 1 : FONCTIONS RPC SECURITY DEFINER
-- =====================================================================
--
-- Ces 5 fonctions gèrent l'authentification admin LBMA.
-- Elles s'exécutent avec les droits postgres (SECURITY DEFINER) pour
-- contourner la policy service_role_only de admin_users.


-- 1.1 — login_user(p_username, p_password)
--      Vérifie credentials via bcrypt, retourne user si valide
CREATE OR REPLACE FUNCTION public.login_user(p_username text, p_password text)
 RETURNS TABLE(id integer, username text, nom text, role text, equipe text)
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
    RETURN QUERY
    SELECT u.id, u.username, u.nom, u.role, u.equipe
    FROM admin_users u
    WHERE u.username = lower(trim(p_username))
      AND u.actif = true
      AND u.password_hash = crypt(p_password, u.password_hash);
END;
$function$;
GRANT EXECUTE ON FUNCTION public.login_user(text, text) TO anon, authenticated, service_role;


-- 1.2 — list_admin_users()
--      Liste les admins SANS le password_hash (sécurisé pour admin.html)
CREATE OR REPLACE FUNCTION public.list_admin_users()
 RETURNS TABLE(id integer, username text, nom text, role text, equipe text)
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
BEGIN
    RETURN QUERY
    SELECT au.id, au.username, au.nom, au.role, au.equipe
    FROM public.admin_users au
    WHERE au.actif = true
    ORDER BY au.nom ASC;
END;
$function$;
GRANT EXECUTE ON FUNCTION public.list_admin_users() TO anon, authenticated, service_role;


-- 1.3 — delete_admin_user(p_id)
--      Supprime un admin. Garde-fou : impossible de supprimer le dernier superadmin
CREATE OR REPLACE FUNCTION public.delete_admin_user(p_id integer)
 RETURNS boolean
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
    target_role TEXT;
BEGIN
    SELECT role INTO target_role FROM public.admin_users WHERE id = p_id;
    IF target_role = 'superadmin' THEN
        IF (SELECT COUNT(*) FROM public.admin_users
            WHERE role = 'superadmin' AND actif = true) <= 1 THEN
            RAISE EXCEPTION 'Impossible de supprimer le dernier superadmin';
        END IF;
    END IF;
    DELETE FROM public.admin_users WHERE id = p_id;
    RETURN FOUND;
END;
$function$;
GRANT EXECUTE ON FUNCTION public.delete_admin_user(integer) TO anon, authenticated, service_role;


-- 1.4 — save_user(p_id, p_username, p_password, p_nom, p_role, p_equipe)
--      Crée ou met à jour un admin, hash bcrypt du mot de passe si fourni
CREATE OR REPLACE FUNCTION public.save_user(
    p_id integer DEFAULT NULL,
    p_username text DEFAULT NULL,
    p_password text DEFAULT NULL,
    p_nom text DEFAULT NULL,
    p_role text DEFAULT 'coach',
    p_equipe text DEFAULT '')
 RETURNS boolean
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
    IF p_id IS NOT NULL AND p_id > 0 THEN
        UPDATE admin_users
        SET username = COALESCE(lower(trim(p_username)), username),
            nom = COALESCE(p_nom, nom),
            role = COALESCE(p_role, role),
            equipe = COALESCE(upper(trim(p_equipe)), equipe),
            password_hash = CASE
                WHEN p_password IS NOT NULL AND length(p_password) >= 6
                THEN crypt(p_password, gen_salt('bf', 10))
                ELSE password_hash
            END
        WHERE id = p_id;
    ELSE
        IF p_password IS NULL OR length(p_password) < 6 THEN
            RAISE EXCEPTION 'Mot de passe requis (6+ caractères)';
        END IF;
        INSERT INTO admin_users (username, password_hash, nom, role, equipe, actif)
        VALUES (lower(trim(p_username)), crypt(p_password, gen_salt('bf', 10)), p_nom, p_role, upper(trim(p_equipe)), true);
    END IF;
    RETURN true;
END;
$function$;
GRANT EXECUTE ON FUNCTION public.save_user(integer, text, text, text, text, text) TO anon, authenticated, service_role;


-- 1.5 — change_password(p_username, p_new_password)
--      Permet à un user de changer son mot de passe (mot de passe oublié)
CREATE OR REPLACE FUNCTION public.change_password(p_username text, p_new_password text)
 RETURNS boolean
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
    rows_updated INT;
BEGIN
    IF length(p_new_password) < 6 THEN
        RAISE EXCEPTION 'Mot de passe trop court (6+ caractères)';
    END IF;
    UPDATE admin_users
    SET password_hash = crypt(p_new_password, gen_salt('bf', 10))
    WHERE username = lower(trim(p_username))
      AND actif = true;
    GET DIAGNOSTICS rows_updated = ROW_COUNT;
    RETURN rows_updated > 0;
END;
$function$;
GRANT EXECUTE ON FUNCTION public.change_password(text, text) TO anon, authenticated, service_role;


-- =====================================================================
-- SECTION 2 : ENABLE RLS sur toutes les tables
-- =====================================================================

ALTER TABLE public.admin_users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.alertes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bandeau_config ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.birthday_emails_sent ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.champions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.classements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.contacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.direction_contacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.equipes_saison ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.fiche_tokens ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.frappeurs_carriere ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.frappeurs_saison ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.frappeurs_series ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.joueurs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.joueurs_equipe ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.joueurs_liste ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lanceurs_carriere ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lanceurs_saison ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lanceurs_series ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.matchs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.matchs_regulier ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.matchs_series ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.medias_articles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.medias_podcasts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.page_config ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pointage_frappeurs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pointage_lanceurs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pointage_manches ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.records_frappeurs_saison ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.records_lanceurs_saison ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.repechage_picks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.saison_info ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.series_matches ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.stats_match_frappeurs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.stats_match_lanceurs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.temple_batisseurs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.temple_membres ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.temple_trophees ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.visites ENABLE ROW LEVEL SECURITY;


-- =====================================================================
-- SECTION 3 : POLICIES RLS (état au 15 mai 2026)
-- =====================================================================

-- NOTE : LBMA conserve volontairement des policies USING(true) sur la
-- majorité des tables — c'est le pattern de design (auth client-side).
-- La SEULE table fermée est admin_users (service_role_only).


-- ===== Table : admin_users =====

DROP POLICY IF EXISTS "service_role_only_admin_users" ON public.admin_users;
CREATE POLICY "service_role_only_admin_users"
  ON public.admin_users
  FOR ALL
  TO public
  USING ((auth.role() = 'service_role'::text))
  WITH CHECK ((auth.role() = 'service_role'::text));


-- ===== Table : alertes =====

DROP POLICY IF EXISTS "alertes_delete" ON public.alertes;
CREATE POLICY "alertes_delete"
  ON public.alertes
  FOR DELETE
  TO public
  USING (true);

DROP POLICY IF EXISTS "alertes_insert" ON public.alertes;
CREATE POLICY "alertes_insert"
  ON public.alertes
  FOR INSERT
  TO public
  WITH CHECK (true);

DROP POLICY IF EXISTS "alertes_lecture_publique" ON public.alertes;
CREATE POLICY "alertes_lecture_publique"
  ON public.alertes
  FOR SELECT
  TO public
  USING (true);

DROP POLICY IF EXISTS "lecture publique alertes" ON public.alertes;
CREATE POLICY "lecture publique alertes"
  ON public.alertes
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "alertes_update" ON public.alertes;
CREATE POLICY "alertes_update"
  ON public.alertes
  FOR UPDATE
  TO public
  USING (true);


-- ===== Table : bandeau_config =====

DROP POLICY IF EXISTS "lecture publique" ON public.bandeau_config;
CREATE POLICY "lecture publique"
  ON public.bandeau_config
  FOR SELECT
  TO public
  USING (true);

DROP POLICY IF EXISTS "ecriture admin" ON public.bandeau_config;
CREATE POLICY "ecriture admin"
  ON public.bandeau_config
  FOR UPDATE
  TO public
  USING (true);


-- ===== Table : birthday_emails_sent =====

DROP POLICY IF EXISTS "Insert birthday logs" ON public.birthday_emails_sent;
CREATE POLICY "Insert birthday logs"
  ON public.birthday_emails_sent
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture birthday logs" ON public.birthday_emails_sent;
CREATE POLICY "Lecture birthday logs"
  ON public.birthday_emails_sent
  FOR SELECT
  TO anon
  USING (true);


-- ===== Table : champions =====

DROP POLICY IF EXISTS "Suppression anon" ON public.champions;
CREATE POLICY "Suppression anon"
  ON public.champions
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.champions;
CREATE POLICY "Insertion anon"
  ON public.champions
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.champions;
CREATE POLICY "Lecture publique"
  ON public.champions
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.champions;
CREATE POLICY "Modification anon"
  ON public.champions
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : classements =====

DROP POLICY IF EXISTS "Suppression anon" ON public.classements;
CREATE POLICY "Suppression anon"
  ON public.classements
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.classements;
CREATE POLICY "Insertion anon"
  ON public.classements
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.classements;
CREATE POLICY "Lecture publique"
  ON public.classements
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.classements;
CREATE POLICY "Modification anon"
  ON public.classements
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : contacts =====

DROP POLICY IF EXISTS "Suppression anon" ON public.contacts;
CREATE POLICY "Suppression anon"
  ON public.contacts
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.contacts;
CREATE POLICY "Insertion anon"
  ON public.contacts
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Admins seulement contacts" ON public.contacts;
CREATE POLICY "Admins seulement contacts"
  ON public.contacts
  FOR SELECT
  TO public
  USING ((auth.role() = 'authenticated'::text));

DROP POLICY IF EXISTS "Lecture publique" ON public.contacts;
CREATE POLICY "Lecture publique"
  ON public.contacts
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.contacts;
CREATE POLICY "Modification anon"
  ON public.contacts
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : direction_contacts =====

DROP POLICY IF EXISTS "Suppression anon" ON public.direction_contacts;
CREATE POLICY "Suppression anon"
  ON public.direction_contacts
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "direction_contacts_delete" ON public.direction_contacts;
CREATE POLICY "direction_contacts_delete"
  ON public.direction_contacts
  FOR DELETE
  TO public
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.direction_contacts;
CREATE POLICY "Insertion anon"
  ON public.direction_contacts
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "direction_contacts_insert" ON public.direction_contacts;
CREATE POLICY "direction_contacts_insert"
  ON public.direction_contacts
  FOR INSERT
  TO public
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.direction_contacts;
CREATE POLICY "Lecture publique"
  ON public.direction_contacts
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "direction_contacts_select" ON public.direction_contacts;
CREATE POLICY "direction_contacts_select"
  ON public.direction_contacts
  FOR SELECT
  TO public
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.direction_contacts;
CREATE POLICY "Modification anon"
  ON public.direction_contacts
  FOR UPDATE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "direction_contacts_update" ON public.direction_contacts;
CREATE POLICY "direction_contacts_update"
  ON public.direction_contacts
  FOR UPDATE
  TO public
  USING (true);


-- ===== Table : equipes_saison =====

DROP POLICY IF EXISTS "Allow anon delete" ON public.equipes_saison;
CREATE POLICY "Allow anon delete"
  ON public.equipes_saison
  FOR DELETE
  TO public
  USING (true);

DROP POLICY IF EXISTS "Suppression anon" ON public.equipes_saison;
CREATE POLICY "Suppression anon"
  ON public.equipes_saison
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Allow anon insert" ON public.equipes_saison;
CREATE POLICY "Allow anon insert"
  ON public.equipes_saison
  FOR INSERT
  TO public
  WITH CHECK (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.equipes_saison;
CREATE POLICY "Insertion anon"
  ON public.equipes_saison
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Allow anon read" ON public.equipes_saison;
CREATE POLICY "Allow anon read"
  ON public.equipes_saison
  FOR SELECT
  TO public
  USING (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.equipes_saison;
CREATE POLICY "Lecture publique"
  ON public.equipes_saison
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Allow anon update" ON public.equipes_saison;
CREATE POLICY "Allow anon update"
  ON public.equipes_saison
  FOR UPDATE
  TO public
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.equipes_saison;
CREATE POLICY "Modification anon"
  ON public.equipes_saison
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : fiche_tokens =====

DROP POLICY IF EXISTS "lecture token public" ON public.fiche_tokens;
CREATE POLICY "lecture token public"
  ON public.fiche_tokens
  FOR SELECT
  TO anon
  USING (true);


-- ===== Table : frappeurs_carriere =====

DROP POLICY IF EXISTS "Suppression anon" ON public.frappeurs_carriere;
CREATE POLICY "Suppression anon"
  ON public.frappeurs_carriere
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.frappeurs_carriere;
CREATE POLICY "Insertion anon"
  ON public.frappeurs_carriere
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.frappeurs_carriere;
CREATE POLICY "Lecture publique"
  ON public.frappeurs_carriere
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.frappeurs_carriere;
CREATE POLICY "Modification anon"
  ON public.frappeurs_carriere
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : frappeurs_saison =====

DROP POLICY IF EXISTS "Allow all frappeurs_saison" ON public.frappeurs_saison;
CREATE POLICY "Allow all frappeurs_saison"
  ON public.frappeurs_saison
  FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

DROP POLICY IF EXISTS "Suppression anon" ON public.frappeurs_saison;
CREATE POLICY "Suppression anon"
  ON public.frappeurs_saison
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.frappeurs_saison;
CREATE POLICY "Insertion anon"
  ON public.frappeurs_saison
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.frappeurs_saison;
CREATE POLICY "Lecture publique"
  ON public.frappeurs_saison
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.frappeurs_saison;
CREATE POLICY "Modification anon"
  ON public.frappeurs_saison
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : frappeurs_series =====

DROP POLICY IF EXISTS "Écriture admin frappeurs_series" ON public.frappeurs_series;
CREATE POLICY "Écriture admin frappeurs_series"
  ON public.frappeurs_series
  FOR ALL
  TO public
  USING ((auth.role() = 'service_role'::text));

DROP POLICY IF EXISTS "Suppression anon" ON public.frappeurs_series;
CREATE POLICY "Suppression anon"
  ON public.frappeurs_series
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.frappeurs_series;
CREATE POLICY "Insertion anon"
  ON public.frappeurs_series
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.frappeurs_series;
CREATE POLICY "Lecture publique"
  ON public.frappeurs_series
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Lecture publique frappeurs_series" ON public.frappeurs_series;
CREATE POLICY "Lecture publique frappeurs_series"
  ON public.frappeurs_series
  FOR SELECT
  TO public
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.frappeurs_series;
CREATE POLICY "Modification anon"
  ON public.frappeurs_series
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : joueurs =====

DROP POLICY IF EXISTS "Suppression anon" ON public.joueurs;
CREATE POLICY "Suppression anon"
  ON public.joueurs
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.joueurs;
CREATE POLICY "Insertion anon"
  ON public.joueurs
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Admins seulement joueurs" ON public.joueurs;
CREATE POLICY "Admins seulement joueurs"
  ON public.joueurs
  FOR SELECT
  TO public
  USING ((auth.role() = 'authenticated'::text));

DROP POLICY IF EXISTS "Lecture publique" ON public.joueurs;
CREATE POLICY "Lecture publique"
  ON public.joueurs
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.joueurs;
CREATE POLICY "Modification anon"
  ON public.joueurs
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : joueurs_equipe =====

DROP POLICY IF EXISTS "Suppression anon" ON public.joueurs_equipe;
CREATE POLICY "Suppression anon"
  ON public.joueurs_equipe
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.joueurs_equipe;
CREATE POLICY "Insertion anon"
  ON public.joueurs_equipe
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.joueurs_equipe;
CREATE POLICY "Lecture publique"
  ON public.joueurs_equipe
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.joueurs_equipe;
CREATE POLICY "Modification anon"
  ON public.joueurs_equipe
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : joueurs_liste =====

DROP POLICY IF EXISTS "Suppression anon" ON public.joueurs_liste;
CREATE POLICY "Suppression anon"
  ON public.joueurs_liste
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "joueurs_liste_delete" ON public.joueurs_liste;
CREATE POLICY "joueurs_liste_delete"
  ON public.joueurs_liste
  FOR DELETE
  TO public
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.joueurs_liste;
CREATE POLICY "Insertion anon"
  ON public.joueurs_liste
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "joueurs_liste_insert" ON public.joueurs_liste;
CREATE POLICY "joueurs_liste_insert"
  ON public.joueurs_liste
  FOR INSERT
  TO public
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.joueurs_liste;
CREATE POLICY "Lecture publique"
  ON public.joueurs_liste
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "joueurs_liste_select" ON public.joueurs_liste;
CREATE POLICY "joueurs_liste_select"
  ON public.joueurs_liste
  FOR SELECT
  TO public
  USING (true);

DROP POLICY IF EXISTS "lecture joueur par id" ON public.joueurs_liste;
CREATE POLICY "lecture joueur par id"
  ON public.joueurs_liste
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.joueurs_liste;
CREATE POLICY "Modification anon"
  ON public.joueurs_liste
  FOR UPDATE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "joueurs_liste_update" ON public.joueurs_liste;
CREATE POLICY "joueurs_liste_update"
  ON public.joueurs_liste
  FOR UPDATE
  TO public
  USING (true);


-- ===== Table : lanceurs_carriere =====

DROP POLICY IF EXISTS "Suppression anon" ON public.lanceurs_carriere;
CREATE POLICY "Suppression anon"
  ON public.lanceurs_carriere
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.lanceurs_carriere;
CREATE POLICY "Insertion anon"
  ON public.lanceurs_carriere
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.lanceurs_carriere;
CREATE POLICY "Lecture publique"
  ON public.lanceurs_carriere
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.lanceurs_carriere;
CREATE POLICY "Modification anon"
  ON public.lanceurs_carriere
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : lanceurs_saison =====

DROP POLICY IF EXISTS "Allow all lanceurs_saison" ON public.lanceurs_saison;
CREATE POLICY "Allow all lanceurs_saison"
  ON public.lanceurs_saison
  FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

DROP POLICY IF EXISTS "Suppression anon" ON public.lanceurs_saison;
CREATE POLICY "Suppression anon"
  ON public.lanceurs_saison
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.lanceurs_saison;
CREATE POLICY "Insertion anon"
  ON public.lanceurs_saison
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.lanceurs_saison;
CREATE POLICY "Lecture publique"
  ON public.lanceurs_saison
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.lanceurs_saison;
CREATE POLICY "Modification anon"
  ON public.lanceurs_saison
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : lanceurs_series =====

DROP POLICY IF EXISTS "Écriture admin lanceurs_series" ON public.lanceurs_series;
CREATE POLICY "Écriture admin lanceurs_series"
  ON public.lanceurs_series
  FOR ALL
  TO public
  USING ((auth.role() = 'service_role'::text));

DROP POLICY IF EXISTS "Suppression anon" ON public.lanceurs_series;
CREATE POLICY "Suppression anon"
  ON public.lanceurs_series
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.lanceurs_series;
CREATE POLICY "Insertion anon"
  ON public.lanceurs_series
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.lanceurs_series;
CREATE POLICY "Lecture publique"
  ON public.lanceurs_series
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Lecture publique lanceurs_series" ON public.lanceurs_series;
CREATE POLICY "Lecture publique lanceurs_series"
  ON public.lanceurs_series
  FOR SELECT
  TO public
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.lanceurs_series;
CREATE POLICY "Modification anon"
  ON public.lanceurs_series
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : matchs =====

DROP POLICY IF EXISTS "Suppression anon" ON public.matchs;
CREATE POLICY "Suppression anon"
  ON public.matchs
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.matchs;
CREATE POLICY "Insertion anon"
  ON public.matchs
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.matchs;
CREATE POLICY "Lecture publique"
  ON public.matchs
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.matchs;
CREATE POLICY "Modification anon"
  ON public.matchs
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : matchs_regulier =====

DROP POLICY IF EXISTS "Suppression anon" ON public.matchs_regulier;
CREATE POLICY "Suppression anon"
  ON public.matchs_regulier
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "matchs_regulier_delete" ON public.matchs_regulier;
CREATE POLICY "matchs_regulier_delete"
  ON public.matchs_regulier
  FOR DELETE
  TO public
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.matchs_regulier;
CREATE POLICY "Insertion anon"
  ON public.matchs_regulier
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "matchs_regulier_insert" ON public.matchs_regulier;
CREATE POLICY "matchs_regulier_insert"
  ON public.matchs_regulier
  FOR INSERT
  TO public
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.matchs_regulier;
CREATE POLICY "Lecture publique"
  ON public.matchs_regulier
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "matchs_regulier_select" ON public.matchs_regulier;
CREATE POLICY "matchs_regulier_select"
  ON public.matchs_regulier
  FOR SELECT
  TO public
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.matchs_regulier;
CREATE POLICY "Modification anon"
  ON public.matchs_regulier
  FOR UPDATE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "matchs_regulier_update" ON public.matchs_regulier;
CREATE POLICY "matchs_regulier_update"
  ON public.matchs_regulier
  FOR UPDATE
  TO public
  USING (true);


-- ===== Table : matchs_series =====

DROP POLICY IF EXISTS "Suppression anon" ON public.matchs_series;
CREATE POLICY "Suppression anon"
  ON public.matchs_series
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "matchs_series_delete" ON public.matchs_series;
CREATE POLICY "matchs_series_delete"
  ON public.matchs_series
  FOR DELETE
  TO public
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.matchs_series;
CREATE POLICY "Insertion anon"
  ON public.matchs_series
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "matchs_series_insert" ON public.matchs_series;
CREATE POLICY "matchs_series_insert"
  ON public.matchs_series
  FOR INSERT
  TO public
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.matchs_series;
CREATE POLICY "Lecture publique"
  ON public.matchs_series
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "matchs_series_select" ON public.matchs_series;
CREATE POLICY "matchs_series_select"
  ON public.matchs_series
  FOR SELECT
  TO public
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.matchs_series;
CREATE POLICY "Modification anon"
  ON public.matchs_series
  FOR UPDATE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "matchs_series_update" ON public.matchs_series;
CREATE POLICY "matchs_series_update"
  ON public.matchs_series
  FOR UPDATE
  TO public
  USING (true);


-- ===== Table : medias_articles =====

DROP POLICY IF EXISTS "Lecture publique medias_articles" ON public.medias_articles;
CREATE POLICY "Lecture publique medias_articles"
  ON public.medias_articles
  FOR SELECT
  TO public
  USING (true);


-- ===== Table : medias_podcasts =====

DROP POLICY IF EXISTS "Lecture publique medias_podcasts" ON public.medias_podcasts;
CREATE POLICY "Lecture publique medias_podcasts"
  ON public.medias_podcasts
  FOR SELECT
  TO public
  USING (true);


-- ===== Table : page_config =====

DROP POLICY IF EXISTS "Suppression anon" ON public.page_config;
CREATE POLICY "Suppression anon"
  ON public.page_config
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "page_config_delete" ON public.page_config;
CREATE POLICY "page_config_delete"
  ON public.page_config
  FOR DELETE
  TO public
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.page_config;
CREATE POLICY "Insertion anon"
  ON public.page_config
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "page_config_insert" ON public.page_config;
CREATE POLICY "page_config_insert"
  ON public.page_config
  FOR INSERT
  TO public
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.page_config;
CREATE POLICY "Lecture publique"
  ON public.page_config
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "page_config_select" ON public.page_config;
CREATE POLICY "page_config_select"
  ON public.page_config
  FOR SELECT
  TO public
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.page_config;
CREATE POLICY "Modification anon"
  ON public.page_config
  FOR UPDATE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "page_config_update" ON public.page_config;
CREATE POLICY "page_config_update"
  ON public.page_config
  FOR UPDATE
  TO public
  USING (true);


-- ===== Table : pointage_frappeurs =====

DROP POLICY IF EXISTS "Allow all for pointage_frappeurs" ON public.pointage_frappeurs;
CREATE POLICY "Allow all for pointage_frappeurs"
  ON public.pointage_frappeurs
  FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

DROP POLICY IF EXISTS "Suppression anon" ON public.pointage_frappeurs;
CREATE POLICY "Suppression anon"
  ON public.pointage_frappeurs
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.pointage_frappeurs;
CREATE POLICY "Insertion anon"
  ON public.pointage_frappeurs
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.pointage_frappeurs;
CREATE POLICY "Lecture publique"
  ON public.pointage_frappeurs
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "public_read_pointage_frappeurs" ON public.pointage_frappeurs;
CREATE POLICY "public_read_pointage_frappeurs"
  ON public.pointage_frappeurs
  FOR SELECT
  TO public
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.pointage_frappeurs;
CREATE POLICY "Modification anon"
  ON public.pointage_frappeurs
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : pointage_lanceurs =====

DROP POLICY IF EXISTS "Allow all for pointage_lanceurs" ON public.pointage_lanceurs;
CREATE POLICY "Allow all for pointage_lanceurs"
  ON public.pointage_lanceurs
  FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

DROP POLICY IF EXISTS "Suppression anon" ON public.pointage_lanceurs;
CREATE POLICY "Suppression anon"
  ON public.pointage_lanceurs
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.pointage_lanceurs;
CREATE POLICY "Insertion anon"
  ON public.pointage_lanceurs
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.pointage_lanceurs;
CREATE POLICY "Lecture publique"
  ON public.pointage_lanceurs
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "public_read_pointage_lanceurs" ON public.pointage_lanceurs;
CREATE POLICY "public_read_pointage_lanceurs"
  ON public.pointage_lanceurs
  FOR SELECT
  TO public
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.pointage_lanceurs;
CREATE POLICY "Modification anon"
  ON public.pointage_lanceurs
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : pointage_manches =====

DROP POLICY IF EXISTS "Allow all for pointage_manches" ON public.pointage_manches;
CREATE POLICY "Allow all for pointage_manches"
  ON public.pointage_manches
  FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

DROP POLICY IF EXISTS "Suppression anon" ON public.pointage_manches;
CREATE POLICY "Suppression anon"
  ON public.pointage_manches
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.pointage_manches;
CREATE POLICY "Insertion anon"
  ON public.pointage_manches
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.pointage_manches;
CREATE POLICY "Lecture publique"
  ON public.pointage_manches
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.pointage_manches;
CREATE POLICY "Modification anon"
  ON public.pointage_manches
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : records_frappeurs_saison =====

DROP POLICY IF EXISTS "Suppression anon" ON public.records_frappeurs_saison;
CREATE POLICY "Suppression anon"
  ON public.records_frappeurs_saison
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.records_frappeurs_saison;
CREATE POLICY "Insertion anon"
  ON public.records_frappeurs_saison
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.records_frappeurs_saison;
CREATE POLICY "Lecture publique"
  ON public.records_frappeurs_saison
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Lecture publique records frappeurs" ON public.records_frappeurs_saison;
CREATE POLICY "Lecture publique records frappeurs"
  ON public.records_frappeurs_saison
  FOR SELECT
  TO public
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.records_frappeurs_saison;
CREATE POLICY "Modification anon"
  ON public.records_frappeurs_saison
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : records_lanceurs_saison =====

DROP POLICY IF EXISTS "Suppression anon" ON public.records_lanceurs_saison;
CREATE POLICY "Suppression anon"
  ON public.records_lanceurs_saison
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.records_lanceurs_saison;
CREATE POLICY "Insertion anon"
  ON public.records_lanceurs_saison
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.records_lanceurs_saison;
CREATE POLICY "Lecture publique"
  ON public.records_lanceurs_saison
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Lecture publique records lanceurs" ON public.records_lanceurs_saison;
CREATE POLICY "Lecture publique records lanceurs"
  ON public.records_lanceurs_saison
  FOR SELECT
  TO public
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.records_lanceurs_saison;
CREATE POLICY "Modification anon"
  ON public.records_lanceurs_saison
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : repechage_picks =====

DROP POLICY IF EXISTS "Suppression anon" ON public.repechage_picks;
CREATE POLICY "Suppression anon"
  ON public.repechage_picks
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "repechage_picks_delete" ON public.repechage_picks;
CREATE POLICY "repechage_picks_delete"
  ON public.repechage_picks
  FOR DELETE
  TO public
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.repechage_picks;
CREATE POLICY "Insertion anon"
  ON public.repechage_picks
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "repechage_picks_insert" ON public.repechage_picks;
CREATE POLICY "repechage_picks_insert"
  ON public.repechage_picks
  FOR INSERT
  TO public
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.repechage_picks;
CREATE POLICY "Lecture publique"
  ON public.repechage_picks
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "repechage_picks_select" ON public.repechage_picks;
CREATE POLICY "repechage_picks_select"
  ON public.repechage_picks
  FOR SELECT
  TO public
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.repechage_picks;
CREATE POLICY "Modification anon"
  ON public.repechage_picks
  FOR UPDATE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "repechage_picks_update" ON public.repechage_picks;
CREATE POLICY "repechage_picks_update"
  ON public.repechage_picks
  FOR UPDATE
  TO public
  USING (true);


-- ===== Table : saison_info =====

DROP POLICY IF EXISTS "saison_info_insert" ON public.saison_info;
CREATE POLICY "saison_info_insert"
  ON public.saison_info
  FOR INSERT
  TO public
  WITH CHECK (true);

DROP POLICY IF EXISTS "lecture publique" ON public.saison_info;
CREATE POLICY "lecture publique"
  ON public.saison_info
  FOR SELECT
  TO public
  USING (true);

DROP POLICY IF EXISTS "lecture publique saison_info" ON public.saison_info;
CREATE POLICY "lecture publique saison_info"
  ON public.saison_info
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "saison_info_update" ON public.saison_info;
CREATE POLICY "saison_info_update"
  ON public.saison_info
  FOR UPDATE
  TO public
  USING (true)
  WITH CHECK (true);


-- ===== Table : series_matches =====

DROP POLICY IF EXISTS "Lecture publique series_matches" ON public.series_matches;
CREATE POLICY "Lecture publique series_matches"
  ON public.series_matches
  FOR SELECT
  TO public
  USING (true);


-- ===== Table : stats_match_frappeurs =====

DROP POLICY IF EXISTS "Suppression anon" ON public.stats_match_frappeurs;
CREATE POLICY "Suppression anon"
  ON public.stats_match_frappeurs
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.stats_match_frappeurs;
CREATE POLICY "Insertion anon"
  ON public.stats_match_frappeurs
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.stats_match_frappeurs;
CREATE POLICY "Lecture publique"
  ON public.stats_match_frappeurs
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.stats_match_frappeurs;
CREATE POLICY "Modification anon"
  ON public.stats_match_frappeurs
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : stats_match_lanceurs =====

DROP POLICY IF EXISTS "Suppression anon" ON public.stats_match_lanceurs;
CREATE POLICY "Suppression anon"
  ON public.stats_match_lanceurs
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.stats_match_lanceurs;
CREATE POLICY "Insertion anon"
  ON public.stats_match_lanceurs
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.stats_match_lanceurs;
CREATE POLICY "Lecture publique"
  ON public.stats_match_lanceurs
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.stats_match_lanceurs;
CREATE POLICY "Modification anon"
  ON public.stats_match_lanceurs
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : temple_batisseurs =====

DROP POLICY IF EXISTS "Suppression anon" ON public.temple_batisseurs;
CREATE POLICY "Suppression anon"
  ON public.temple_batisseurs
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.temple_batisseurs;
CREATE POLICY "Insertion anon"
  ON public.temple_batisseurs
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.temple_batisseurs;
CREATE POLICY "Lecture publique"
  ON public.temple_batisseurs
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.temple_batisseurs;
CREATE POLICY "Modification anon"
  ON public.temple_batisseurs
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : temple_membres =====

DROP POLICY IF EXISTS "Suppression anon" ON public.temple_membres;
CREATE POLICY "Suppression anon"
  ON public.temple_membres
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.temple_membres;
CREATE POLICY "Insertion anon"
  ON public.temple_membres
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.temple_membres;
CREATE POLICY "Lecture publique"
  ON public.temple_membres
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.temple_membres;
CREATE POLICY "Modification anon"
  ON public.temple_membres
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : temple_trophees =====

DROP POLICY IF EXISTS "Suppression anon" ON public.temple_trophees;
CREATE POLICY "Suppression anon"
  ON public.temple_trophees
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.temple_trophees;
CREATE POLICY "Insertion anon"
  ON public.temple_trophees
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.temple_trophees;
CREATE POLICY "Lecture publique"
  ON public.temple_trophees
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.temple_trophees;
CREATE POLICY "Modification anon"
  ON public.temple_trophees
  FOR UPDATE
  TO anon
  USING (true);


-- ===== Table : visites =====

DROP POLICY IF EXISTS "Suppression anon" ON public.visites;
CREATE POLICY "Suppression anon"
  ON public.visites
  FOR DELETE
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Insertion anon" ON public.visites;
CREATE POLICY "Insertion anon"
  ON public.visites
  FOR INSERT
  TO anon
  WITH CHECK (true);

DROP POLICY IF EXISTS "Lecture publique" ON public.visites;
CREATE POLICY "Lecture publique"
  ON public.visites
  FOR SELECT
  TO anon
  USING (true);

DROP POLICY IF EXISTS "Modification anon" ON public.visites;
CREATE POLICY "Modification anon"
  ON public.visites
  FOR UPDATE
  TO anon
  USING (true);


-- =====================================================================
-- SECTION 4 : VÉRIFICATION POST-EXÉCUTION
-- =====================================================================

-- Compter les policies (doit retourner 182)
SELECT COUNT(*) AS nb_policies FROM pg_policies WHERE schemaname = 'public';

-- Lister les fonctions admin LBMA
SELECT proname FROM pg_proc p
JOIN pg_namespace n ON n.oid = p.pronamespace
WHERE n.nspname = 'public'
  AND proname IN ('login_user', 'list_admin_users', 'delete_admin_user', 'save_user', 'change_password')
ORDER BY proname;

-- Vérifier que admin_users est bien protégée (doit montrer service_role uniquement)
SELECT policyname, cmd, qual FROM pg_policies
WHERE schemaname = 'public' AND tablename = 'admin_users';

-- Fin du dump
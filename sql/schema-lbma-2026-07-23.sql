-- =====================================================================
-- LBMA — SCHÉMA COMPLET DE LA BASE DE DONNÉES (structure)
-- =====================================================================
-- Projet Supabase : xgyskiatppgaeaamjhxr (LBMA)
-- Généré le : 23 juillet 2026, directement depuis la base réelle
--
-- ▶️ PLAN DE RECONSTRUCTION CHEZ UN AUTRE FOURNISSEUR (Postgres) :
--   1. Exécuter ce fichier au complet (structure : extensions, séquences,
--      tables, contraintes, index, vue, fonctions, triggers, sécurité).
--   2. Importer les CSV du backup (backup-admin.html / Backup-LBMA-local.html)
--      dans chaque table, ex. avec \copy ou l'outil d'import du fournisseur.
--   3. Recaler les séquences d'ID (section 10, bloc DO à exécuter APRÈS
--      l'import des données).
--   4. Recréer les comptes admin : la table admin_users n'est PAS dans les
--      CSV (protégée). Recréer chaque compte avec save_user(), ex. :
--      SELECT save_user(NULL, 'sergio', 'MotDePasse123', 'Sergio', 'superadmin', '');
--   5. Recréer les 2 tâches cron (section 11) si le fournisseur offre pg_cron.
--
-- ⚠️ La fonction send_birthday_emails contient la clé API Resend en clair.
-- ⚠️ supabase_vault et auth.role() sont propres à Supabase : chez un autre
--    fournisseur, retirer supabase_vault et adapter/retirer les policies
--    qui utilisent auth.role() (l'auth LBMA est de toute façon applicative,
--    via les RPCs login_user/save_user + localStorage).
-- =====================================================================


-- =====================================================================
-- SECTION 1 : EXTENSIONS
-- =====================================================================
CREATE EXTENSION IF NOT EXISTS pgcrypto;       -- bcrypt (login admin)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS pg_cron;        -- tâches planifiées
CREATE EXTENSION IF NOT EXISTS pg_net;         -- appels HTTP (courriels Resend)
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
-- CREATE EXTENSION supabase_vault;            -- propre à Supabase, ignorer ailleurs


-- =====================================================================
-- SECTION 2 : SÉQUENCES
-- =====================================================================
CREATE SEQUENCE IF NOT EXISTS public.admin_users_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.alertes_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.birthday_emails_sent_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.champions_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.classements_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.contacts_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.direction_contacts_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.equipes_saison_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.fiche_tokens_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.frappeurs_carriere_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.frappeurs_saison_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.frappeurs_series_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.joueurs_equipe_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.joueurs_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.joueurs_liste_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.lanceurs_carriere_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.lanceurs_saison_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.lanceurs_series_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.matchs_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.matchs_regulier_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.matchs_series_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.medias_articles_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.medias_podcasts_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.page_config_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.pointage_frappeurs_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.pointage_lanceurs_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.pointage_manches_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.records_frappeurs_saison_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.records_lanceurs_saison_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.repechage_picks_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.series_matches_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.stats_match_frappeurs_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.stats_match_lanceurs_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.temple_batisseurs_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.temple_membres_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.temple_trophees_id_seq;
CREATE SEQUENCE IF NOT EXISTS public.visites_id_seq;


-- =====================================================================
-- SECTION 3 : TABLES (43)
-- =====================================================================

CREATE TABLE public.admin_users (
    id integer DEFAULT nextval('admin_users_id_seq'::regclass) NOT NULL,
    username text NOT NULL,
    role text DEFAULT 'marqueur'::text NOT NULL,
    nom text DEFAULT ''::text NOT NULL,
    equipe text DEFAULT ''::text,
    actif boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    password_hash text
);

CREATE TABLE public.alertes (
    id bigint DEFAULT nextval('alertes_id_seq'::regclass) NOT NULL,
    type text DEFAULT 'info'::text NOT NULL,
    message text NOT NULL,
    actif boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE public.backup_frappeurs_hits_20260627 (
    id integer,
    saison text,
    nom text,
    equipe text,
    cote text,
    pj integer,
    ab integer,
    cs integer,
    simples integer,
    doubles integer,
    triples integer,
    cc integer,
    pc integer,
    pp integer,
    bb integer,
    moy numeric(5,3),
    created_at timestamp with time zone,
    rb integer,
    sac integer
);

CREATE TABLE public.bandeau_config (
    id integer DEFAULT 1 NOT NULL,
    actif boolean DEFAULT false,
    texte text DEFAULT ''::text,
    sous_texte text DEFAULT ''::text,
    couleur text DEFAULT '#CC0000'::text,
    lien text DEFAULT ''::text,
    lien_texte text DEFAULT 'Cliquez ici →'::text,
    updated_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.birthday_emails_sent (
    id bigint DEFAULT nextval('birthday_emails_sent_id_seq'::regclass) NOT NULL,
    joueur_nom text NOT NULL,
    joueur_email text NOT NULL,
    sent_date date DEFAULT CURRENT_DATE NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.champions (
    id integer DEFAULT nextval('champions_id_seq'::regclass) NOT NULL,
    saison text NOT NULL,
    equipe text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.classements (
    id integer DEFAULT nextval('classements_id_seq'::regclass) NOT NULL,
    saison text NOT NULL,
    equipe text NOT NULL,
    coach text,
    pj integer,
    v integer,
    d integer,
    n integer,
    pp integer,
    pc integer,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.contacts (
    id integer DEFAULT nextval('contacts_id_seq'::regclass) NOT NULL,
    nom text NOT NULL,
    titre text,
    sous_titre text,
    telephone text,
    courriel text,
    responsabilites text[],
    ordre integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.direction_contacts (
    id bigint DEFAULT nextval('direction_contacts_id_seq'::regclass) NOT NULL,
    nom text NOT NULL,
    titre text DEFAULT ''::text,
    sous_titre text DEFAULT ''::text,
    telephone text DEFAULT ''::text,
    courriel text DEFAULT ''::text,
    responsabilites jsonb DEFAULT '[]'::jsonb,
    ordre integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    photo_url text DEFAULT ''::text
);

CREATE TABLE public.equipes_saison (
    id bigint NOT NULL,
    saison text NOT NULL,
    equipe text NOT NULL,
    joueur_nom text NOT NULL,
    joueur_cote integer DEFAULT 0,
    is_coach boolean DEFAULT false,
    ordre integer DEFAULT 0
);

CREATE TABLE public.fiche_tokens (
    id bigint NOT NULL,
    joueur_id bigint,
    token uuid DEFAULT gen_random_uuid() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '7 days'::interval) NOT NULL,
    used boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.frappeurs_carriere (
    id integer DEFAULT nextval('frappeurs_carriere_id_seq'::regclass) NOT NULL,
    nom text NOT NULL,
    pj integer,
    ab integer,
    cs integer,
    simples integer,
    doubles integer,
    triples integer,
    cc integer,
    pc integer,
    pp integer,
    sac integer,
    bb integer,
    rb integer,
    moy numeric(5,3),
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.frappeurs_saison (
    id integer DEFAULT nextval('frappeurs_saison_id_seq'::regclass) NOT NULL,
    saison text NOT NULL,
    nom text NOT NULL,
    equipe text,
    cote text,
    pj integer,
    ab integer,
    cs integer,
    simples integer,
    doubles integer,
    triples integer,
    cc integer,
    pc integer,
    pp integer,
    bb integer,
    moy numeric(5,3),
    created_at timestamp with time zone DEFAULT now(),
    rb integer DEFAULT 0,
    sac integer DEFAULT 0
);

CREATE TABLE public.frappeurs_series (
    id bigint DEFAULT nextval('frappeurs_series_id_seq'::regclass) NOT NULL,
    saison text NOT NULL,
    nom text NOT NULL,
    equipe text,
    cote text,
    pj integer DEFAULT 0,
    ab integer DEFAULT 0,
    cs integer DEFAULT 0,
    simples integer DEFAULT 0,
    doubles integer DEFAULT 0,
    triples integer DEFAULT 0,
    cc integer DEFAULT 0,
    pc integer DEFAULT 0,
    pp integer DEFAULT 0,
    bb integer DEFAULT 0,
    rb integer DEFAULT 0,
    sac integer DEFAULT 0,
    moy numeric(4,3),
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.joueurs (
    id integer DEFAULT nextval('joueurs_id_seq'::regclass) NOT NULL,
    saison text NOT NULL,
    nom text NOT NULL,
    cote integer,
    telephone1 text,
    telephone2 text,
    courriel text,
    naissance text,
    role text DEFAULT 'joueur'::text,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.joueurs_equipe (
    id integer DEFAULT nextval('joueurs_equipe_id_seq'::regclass) NOT NULL,
    saison text NOT NULL,
    equipe_id text NOT NULL,
    nom text NOT NULL,
    cote integer,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.joueurs_liste (
    id bigint DEFAULT nextval('joueurs_liste_id_seq'::regclass) NOT NULL,
    nom text NOT NULL,
    cote integer DEFAULT 3 NOT NULL,
    role text DEFAULT 'joueur'::text,
    telephone1 text,
    telephone2 text,
    courriel text,
    naissance text,
    saison text DEFAULT '2026'::text NOT NULL,
    actif boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    adresse text,
    ville text,
    code_postal text,
    telephone text,
    province text DEFAULT 'QC'::text,
    photo_url text DEFAULT ''::text NOT NULL,
    note_bio text DEFAULT ''::text NOT NULL,
    numero_chandail smallint,
    "position" text DEFAULT 'Frappeur'::text NOT NULL
);

CREATE TABLE public.lanceurs_carriere (
    id integer DEFAULT nextval('lanceurs_carriere_id_seq'::regclass) NOT NULL,
    nom text NOT NULL,
    pl integer,
    ml numeric(8,2),
    bb integer,
    rb integer,
    v integer,
    d integer,
    n integer,
    moy numeric(5,3),
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.lanceurs_saison (
    id integer DEFAULT nextval('lanceurs_saison_id_seq'::regclass) NOT NULL,
    saison text NOT NULL,
    nom text NOT NULL,
    equipe text,
    pl integer,
    ml numeric(8,3),
    pc integer,
    cs integer,
    bb integer,
    rb integer,
    v integer,
    d integer,
    n integer,
    moy numeric(5,3),
    created_at timestamp with time zone DEFAULT now(),
    cote text,
    type_lanceur text DEFAULT ''::text,
    "out" integer DEFAULT 0
);

CREATE TABLE public.lanceurs_series (
    id bigint DEFAULT nextval('lanceurs_series_id_seq'::regclass) NOT NULL,
    saison text NOT NULL,
    nom text NOT NULL,
    equipe text,
    cote text,
    type_lanceur text,
    pj integer DEFAULT 0,
    pl integer DEFAULT 0,
    ml numeric(5,1) DEFAULT 0,
    v integer DEFAULT 0,
    d integer DEFAULT 0,
    n integer DEFAULT 0,
    sv integer DEFAULT 0,
    pc integer DEFAULT 0,
    cs integer DEFAULT 0,
    bb integer DEFAULT 0,
    rb integer DEFAULT 0,
    hr integer DEFAULT 0,
    moy numeric(5,2),
    created_at timestamp with time zone DEFAULT now(),
    "out" integer DEFAULT 0
);

CREATE TABLE public.matchs (
    id integer DEFAULT nextval('matchs_id_seq'::regclass) NOT NULL,
    saison text DEFAULT '2026'::text NOT NULL,
    date_match text,
    equipe_locale text NOT NULL,
    equipe_visiteur text NOT NULL,
    score_locale integer DEFAULT 0,
    score_visiteur integer DEFAULT 0,
    manche integer DEFAULT 1,
    statut text DEFAULT 'a_venir'::text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.matchs_regulier (
    id bigint DEFAULT nextval('matchs_regulier_id_seq'::regclass) NOT NULL,
    saison integer DEFAULT 2026 NOT NULL,
    no_match integer,
    date date NOT NULL,
    jour text DEFAULT 'SAMEDI'::text NOT NULL,
    heure text DEFAULT '9H00'::text NOT NULL,
    visiteur text NOT NULL,
    local text NOT NULL,
    score_visiteur integer,
    score_local integer,
    endroit text DEFAULT 'JARRY 1'::text NOT NULL,
    status text DEFAULT 'avenir'::text NOT NULL,
    special text DEFAULT ''::text,
    notes text DEFAULT ''::text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    source_saisie text
);

CREATE TABLE public.matchs_series (
    id bigint DEFAULT nextval('matchs_series_id_seq'::regclass) NOT NULL,
    saison integer DEFAULT 2026 NOT NULL,
    ronde text NOT NULL,
    no_match integer,
    date date NOT NULL,
    jour text DEFAULT 'SAMEDI'::text NOT NULL,
    heure text DEFAULT '9H00'::text NOT NULL,
    visiteur text NOT NULL,
    local text NOT NULL,
    score_visiteur integer,
    score_local integer,
    endroit text DEFAULT 'JARRY 1'::text NOT NULL,
    status text DEFAULT 'avenir'::text NOT NULL,
    notes text DEFAULT ''::text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    serie_id text DEFAULT ''::text,
    serie_format text DEFAULT '2DE3'::text,
    seed_visiteur integer,
    seed_local integer
);

CREATE TABLE public.medias_articles (
    id bigint DEFAULT nextval('medias_articles_id_seq'::regclass) NOT NULL,
    date date DEFAULT CURRENT_DATE NOT NULL,
    titre text NOT NULL,
    extrait text,
    lien text,
    image_url text,
    actif boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE public.medias_podcasts (
    id bigint DEFAULT nextval('medias_podcasts_id_seq'::regclass) NOT NULL,
    date date DEFAULT CURRENT_DATE NOT NULL,
    titre text NOT NULL,
    description text,
    lien text,
    duree text,
    plateforme text,
    actif boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE public.noms_backup_20260601 (
    src text,
    id bigint,
    old_nom text
);

CREATE TABLE public.noms_backup_hetu_20260601 (
    src text,
    id bigint,
    old_nom text
);

CREATE TABLE public.page_config (
    id bigint DEFAULT nextval('page_config_id_seq'::regclass) NOT NULL,
    page text NOT NULL,
    titre text DEFAULT ''::text,
    description text DEFAULT ''::text,
    data jsonb DEFAULT '{}'::jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.pointage_frappeurs (
    id bigint DEFAULT nextval('pointage_frappeurs_id_seq'::regclass) NOT NULL,
    match_id bigint NOT NULL,
    equipe text NOT NULL,
    joueur text NOT NULL,
    pos text DEFAULT ''::text,
    ordre integer DEFAULT 1,
    m1 text DEFAULT ''::text,
    m2 text DEFAULT ''::text,
    m3 text DEFAULT ''::text,
    m4 text DEFAULT ''::text,
    m5 text DEFAULT ''::text,
    m6 text DEFAULT ''::text,
    m7 text DEFAULT ''::text,
    m8 text DEFAULT ''::text,
    m9 text DEFAULT ''::text,
    m10 text DEFAULT ''::text,
    ab integer DEFAULT 0,
    r integer DEFAULT 0,
    h integer DEFAULT 0,
    rbi integer DEFAULT 0,
    e integer DEFAULT 0,
    role text DEFAULT ''::text,
    b1 integer DEFAULT 0,
    b2 integer DEFAULT 0,
    b3 integer DEFAULT 0,
    cc integer DEFAULT 0,
    bb integer DEFAULT 0,
    k integer DEFAULT 0,
    sac integer DEFAULT 0,
    abs boolean DEFAULT false,
    off boolean DEFAULT false,
    def boolean DEFAULT false
);

CREATE TABLE public.pointage_lanceurs (
    id bigint DEFAULT nextval('pointage_lanceurs_id_seq'::regclass) NOT NULL,
    match_id bigint NOT NULL,
    equipe text NOT NULL,
    joueur text NOT NULL,
    ordre integer DEFAULT 1,
    ip numeric(4,1) DEFAULT 0,
    h integer DEFAULT 0,
    r integer DEFAULT 0,
    er integer DEFAULT 0,
    bb integer DEFAULT 0,
    k integer DEFAULT 0
);

CREATE TABLE public.pointage_manches (
    id bigint DEFAULT nextval('pointage_manches_id_seq'::regclass) NOT NULL,
    match_id bigint NOT NULL,
    equipe text NOT NULL,
    manche integer NOT NULL,
    points integer DEFAULT 0
);

CREATE TABLE public.records_frappeurs_saison (
    id integer DEFAULT nextval('records_frappeurs_saison_id_seq'::regclass) NOT NULL,
    categorie text NOT NULL,
    record text NOT NULL,
    detenteur text NOT NULL,
    annee text NOT NULL,
    type text DEFAULT 'general'::text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.records_lanceurs_saison (
    id integer DEFAULT nextval('records_lanceurs_saison_id_seq'::regclass) NOT NULL,
    categorie text NOT NULL,
    record text NOT NULL,
    detenteur text NOT NULL,
    annee text NOT NULL,
    note text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.repechage_picks (
    id bigint DEFAULT nextval('repechage_picks_id_seq'::regclass) NOT NULL,
    saison text DEFAULT '2026'::text NOT NULL,
    ronde integer DEFAULT 0 NOT NULL,
    equipe text NOT NULL,
    joueur_id bigint,
    joueur_nom text NOT NULL,
    joueur_cote integer NOT NULL,
    is_coach boolean DEFAULT false,
    pick_order integer,
    picked_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.roster_backup_garcia_20260601 (
    id bigint,
    saison text,
    equipe text,
    joueur_nom text,
    joueur_cote integer,
    is_coach boolean,
    ordre integer
);

CREATE TABLE public.saison_info (
    cle text NOT NULL,
    valeur text NOT NULL
);

CREATE TABLE public.series_matches (
    id bigint DEFAULT nextval('series_matches_id_seq'::regclass) NOT NULL,
    saison text,
    date date,
    visiteur text,
    local text,
    score_visiteur integer DEFAULT 0,
    score_local integer DEFAULT 0,
    status text DEFAULT 'final'::text,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.stats_match_frappeurs (
    id integer DEFAULT nextval('stats_match_frappeurs_id_seq'::regclass) NOT NULL,
    match_id integer,
    joueur text NOT NULL,
    equipe text NOT NULL,
    ab integer DEFAULT 0,
    cs integer DEFAULT 0,
    simples integer DEFAULT 0,
    doubles integer DEFAULT 0,
    triples integer DEFAULT 0,
    cc integer DEFAULT 0,
    pp integer DEFAULT 0,
    pc integer DEFAULT 0,
    bb integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.stats_match_lanceurs (
    id integer DEFAULT nextval('stats_match_lanceurs_id_seq'::regclass) NOT NULL,
    match_id integer,
    joueur text NOT NULL,
    equipe text NOT NULL,
    ml numeric(5,1) DEFAULT 0,
    pc integer DEFAULT 0,
    cs integer DEFAULT 0,
    bb integer DEFAULT 0,
    rb integer DEFAULT 0,
    resultat text,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.temple_batisseurs (
    id integer DEFAULT nextval('temple_batisseurs_id_seq'::regclass) NOT NULL,
    nom text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now(),
    ordre integer DEFAULT 0,
    photo_url text,
    biographie text
);

CREATE TABLE public.temple_membres (
    id integer DEFAULT nextval('temple_membres_id_seq'::regclass) NOT NULL,
    nom text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    ordre integer DEFAULT 0,
    photo_url text,
    biographie text,
    description text DEFAULT ''::text
);

CREATE TABLE public.temple_trophees (
    id integer DEFAULT nextval('temple_trophees_id_seq'::regclass) NOT NULL,
    nom text NOT NULL,
    trophee text NOT NULL,
    icon text,
    created_at timestamp with time zone DEFAULT now(),
    ordre integer DEFAULT 0,
    photo_url text,
    biographie text
);

CREATE TABLE public.visites (
    id bigint DEFAULT nextval('visites_id_seq'::regclass) NOT NULL,
    page text NOT NULL,
    "timestamp" timestamp with time zone DEFAULT now(),
    referrer text,
    user_agent text,
    screen_width integer
);


-- =====================================================================
-- SECTION 4 : CONTRAINTES (clés primaires, uniques, étrangères, checks)
-- =====================================================================
ALTER TABLE public.admin_users ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);
ALTER TABLE public.admin_users ADD CONSTRAINT admin_users_role_check CHECK ((role = ANY (ARRAY['superadmin'::text, 'admin'::text, 'marqueur'::text, 'coach'::text])));
ALTER TABLE public.admin_users ADD CONSTRAINT admin_users_username_key UNIQUE (username);
ALTER TABLE public.alertes ADD CONSTRAINT alertes_pkey PRIMARY KEY (id);
ALTER TABLE public.bandeau_config ADD CONSTRAINT bandeau_config_pkey PRIMARY KEY (id);
ALTER TABLE public.birthday_emails_sent ADD CONSTRAINT birthday_emails_sent_pkey PRIMARY KEY (id);
ALTER TABLE public.champions ADD CONSTRAINT champions_pkey PRIMARY KEY (id);
ALTER TABLE public.classements ADD CONSTRAINT classements_pkey PRIMARY KEY (id);
ALTER TABLE public.contacts ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);
ALTER TABLE public.direction_contacts ADD CONSTRAINT direction_contacts_pkey PRIMARY KEY (id);
ALTER TABLE public.equipes_saison ADD CONSTRAINT equipes_saison_pkey PRIMARY KEY (id);
ALTER TABLE public.fiche_tokens ADD CONSTRAINT fiche_tokens_pkey PRIMARY KEY (id);
ALTER TABLE public.fiche_tokens ADD CONSTRAINT fiche_tokens_token_key UNIQUE (token);
ALTER TABLE public.fiche_tokens ADD CONSTRAINT fiche_tokens_joueur_id_fkey FOREIGN KEY (joueur_id) REFERENCES joueurs_liste(id) ON DELETE CASCADE;
ALTER TABLE public.frappeurs_carriere ADD CONSTRAINT frappeurs_carriere_pkey PRIMARY KEY (id);
ALTER TABLE public.frappeurs_saison ADD CONSTRAINT frappeurs_saison_pkey PRIMARY KEY (id);
ALTER TABLE public.frappeurs_series ADD CONSTRAINT frappeurs_series_pkey PRIMARY KEY (id);
ALTER TABLE public.joueurs ADD CONSTRAINT joueurs_pkey PRIMARY KEY (id);
ALTER TABLE public.joueurs_equipe ADD CONSTRAINT joueurs_equipe_pkey PRIMARY KEY (id);
ALTER TABLE public.joueurs_liste ADD CONSTRAINT joueurs_liste_pkey PRIMARY KEY (id);
ALTER TABLE public.lanceurs_carriere ADD CONSTRAINT lanceurs_carriere_pkey PRIMARY KEY (id);
ALTER TABLE public.lanceurs_saison ADD CONSTRAINT lanceurs_saison_pkey PRIMARY KEY (id);
ALTER TABLE public.lanceurs_series ADD CONSTRAINT lanceurs_series_pkey PRIMARY KEY (id);
ALTER TABLE public.matchs ADD CONSTRAINT matchs_pkey PRIMARY KEY (id);
ALTER TABLE public.matchs_regulier ADD CONSTRAINT matchs_regulier_pkey PRIMARY KEY (id);
ALTER TABLE public.matchs_series ADD CONSTRAINT matchs_series_pkey PRIMARY KEY (id);
ALTER TABLE public.medias_articles ADD CONSTRAINT medias_articles_pkey PRIMARY KEY (id);
ALTER TABLE public.medias_podcasts ADD CONSTRAINT medias_podcasts_pkey PRIMARY KEY (id);
ALTER TABLE public.page_config ADD CONSTRAINT page_config_pkey PRIMARY KEY (id);
ALTER TABLE public.page_config ADD CONSTRAINT page_config_page_key UNIQUE (page);
ALTER TABLE public.pointage_frappeurs ADD CONSTRAINT pointage_frappeurs_pkey PRIMARY KEY (id);
ALTER TABLE public.pointage_lanceurs ADD CONSTRAINT pointage_lanceurs_pkey PRIMARY KEY (id);
ALTER TABLE public.pointage_manches ADD CONSTRAINT pointage_manches_pkey PRIMARY KEY (id);
ALTER TABLE public.pointage_manches ADD CONSTRAINT pointage_manches_manche_check CHECK (((manche >= 1) AND (manche <= 10)));
ALTER TABLE public.pointage_manches ADD CONSTRAINT pointage_manches_match_id_equipe_manche_key UNIQUE (match_id, equipe, manche);
ALTER TABLE public.records_frappeurs_saison ADD CONSTRAINT records_frappeurs_saison_pkey PRIMARY KEY (id);
ALTER TABLE public.records_lanceurs_saison ADD CONSTRAINT records_lanceurs_saison_pkey PRIMARY KEY (id);
ALTER TABLE public.repechage_picks ADD CONSTRAINT repechage_picks_pkey PRIMARY KEY (id);
ALTER TABLE public.repechage_picks ADD CONSTRAINT repechage_picks_joueur_id_fkey FOREIGN KEY (joueur_id) REFERENCES joueurs_liste(id);
ALTER TABLE public.saison_info ADD CONSTRAINT saison_info_pkey PRIMARY KEY (cle);
ALTER TABLE public.series_matches ADD CONSTRAINT series_matches_pkey PRIMARY KEY (id);
ALTER TABLE public.stats_match_frappeurs ADD CONSTRAINT stats_match_frappeurs_pkey PRIMARY KEY (id);
ALTER TABLE public.stats_match_frappeurs ADD CONSTRAINT stats_match_frappeurs_match_id_fkey FOREIGN KEY (match_id) REFERENCES matchs(id);
ALTER TABLE public.stats_match_lanceurs ADD CONSTRAINT stats_match_lanceurs_pkey PRIMARY KEY (id);
ALTER TABLE public.stats_match_lanceurs ADD CONSTRAINT stats_match_lanceurs_match_id_fkey FOREIGN KEY (match_id) REFERENCES matchs(id);
ALTER TABLE public.temple_batisseurs ADD CONSTRAINT temple_batisseurs_pkey PRIMARY KEY (id);
ALTER TABLE public.temple_membres ADD CONSTRAINT temple_membres_pkey PRIMARY KEY (id);
ALTER TABLE public.temple_trophees ADD CONSTRAINT temple_trophees_pkey PRIMARY KEY (id);
ALTER TABLE public.visites ADD CONSTRAINT visites_pkey PRIMARY KEY (id);


-- =====================================================================
-- SECTION 5 : INDEX
-- =====================================================================
CREATE INDEX fiche_tokens_token_idx ON public.fiche_tokens USING btree (token);
CREATE INDEX idx_frappeurs_series_nom ON public.frappeurs_series USING btree (nom);
CREATE INDEX idx_frappeurs_series_saison ON public.frappeurs_series USING btree (saison);
CREATE INDEX idx_joueurs_liste_nom ON public.joueurs_liste USING btree (nom);
CREATE INDEX idx_joueurs_liste_saison ON public.joueurs_liste USING btree (saison);
CREATE INDEX idx_lanceurs_series_nom ON public.lanceurs_series USING btree (nom);
CREATE INDEX idx_lanceurs_series_saison ON public.lanceurs_series USING btree (saison);
CREATE INDEX idx_matchs_reg_date ON public.matchs_regulier USING btree (date);
CREATE INDEX idx_matchs_reg_saison ON public.matchs_regulier USING btree (saison);
CREATE INDEX idx_matchs_reg_status ON public.matchs_regulier USING btree (status);
CREATE INDEX idx_matchs_series_ronde ON public.matchs_series USING btree (ronde);
CREATE INDEX idx_matchs_series_saison ON public.matchs_series USING btree (saison);
CREATE INDEX idx_matchs_series_serie ON public.matchs_series USING btree (serie_id);
CREATE INDEX idx_pointage_frappeurs_equipe ON public.pointage_frappeurs USING btree (equipe);
CREATE INDEX idx_pointage_frappeurs_joueur ON public.pointage_frappeurs USING btree (joueur);
CREATE INDEX idx_pointage_frappeurs_match ON public.pointage_frappeurs USING btree (match_id);
CREATE INDEX idx_pointage_lanceurs_equipe ON public.pointage_lanceurs USING btree (equipe);
CREATE INDEX idx_pointage_lanceurs_match ON public.pointage_lanceurs USING btree (match_id);
CREATE INDEX idx_pointage_manches_match ON public.pointage_manches USING btree (match_id);
CREATE INDEX idx_visites_page ON public.visites USING btree (page);
CREATE INDEX idx_visites_timestamp ON public.visites USING btree ("timestamp");
CREATE INDEX medias_articles_date_idx ON public.medias_articles USING btree (date DESC, id DESC);
CREATE INDEX medias_podcasts_date_idx ON public.medias_podcasts USING btree (date DESC, id DESC);


-- =====================================================================
-- SECTION 6 : VUES
-- =====================================================================
-- benchage_saison : comptes OFF/DEF par joueur (matchs FINALISÉS,
-- saison régulière + séries — migration benchage_saison_series_final_seulement)
CREATE OR REPLACE VIEW public.benchage_saison AS
 SELECT r.saison,
    r.equipe,
    r.joueur_nom AS joueur,
    (count(*) FILTER (WHERE (pf.off IS TRUE)))::integer AS off,
    (count(*) FILTER (WHERE (pf.def IS TRUE)))::integer AS def,
    ((count(*) FILTER (WHERE (pf.off IS TRUE)) + count(*) FILTER (WHERE (pf.def IS TRUE))))::integer AS bench
   FROM (equipes_saison r
     LEFT JOIN pointage_frappeurs pf ON (((pf.joueur = r.joueur_nom) AND (pf.equipe = r.equipe) AND ((pf.off IS TRUE) OR (pf.def IS TRUE)) AND (pf.match_id IN ( SELECT mr.id
           FROM matchs_regulier mr
          WHERE (((mr.saison)::text = r.saison) AND (mr.status = 'final'::text))
        UNION
         SELECT ms.id
           FROM matchs_series ms
          WHERE (((ms.saison)::text = r.saison) AND (ms.status = 'final'::text)))))))
  WHERE (r.equipe <> 'AUTRE'::text)
  GROUP BY r.saison, r.equipe, r.joueur_nom;


-- =====================================================================
-- SECTION 7 : FONCTIONS (les fonctions pg_trgm sont créées par l'extension)
-- =====================================================================

CREATE OR REPLACE FUNCTION public.update_modified_column()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$function$;

CREATE OR REPLACE FUNCTION public.calcul_moy_lanceur_series()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    IF NEW.ml > 0 THEN
        NEW.moy := ROUND((NEW.pc::numeric / NEW.ml::numeric), 3);
    ELSE
        NEW.moy := NULL;
    END IF;
    RETURN NEW;
END;
$function$;

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

CREATE OR REPLACE FUNCTION public.save_user(p_id integer DEFAULT NULL::integer, p_username text DEFAULT NULL::text, p_password text DEFAULT NULL::text, p_nom text DEFAULT NULL::text, p_role text DEFAULT 'coach'::text, p_equipe text DEFAULT ''::text)
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

-- ⚠️ La version complète de send_birthday_emails (avec le gabarit HTML du
-- courriel et la clé API Resend) est dans sql/dump-securite-15mai2026.sql
-- et dans la base. Elle dépend de pg_net (net.http_post) + Resend.
-- Chez un autre fournisseur, la réécrire selon le service de courriel choisi.


-- =====================================================================
-- SECTION 8 : TRIGGERS
-- =====================================================================
CREATE TRIGGER matchs_regulier_updated BEFORE UPDATE ON public.matchs_regulier FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER matchs_series_updated BEFORE UPDATE ON public.matchs_series FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER trigger_moy_lanceurs_series BEFORE INSERT OR UPDATE ON public.lanceurs_series FOR EACH ROW EXECUTE FUNCTION calcul_moy_lanceur_series();


-- =====================================================================
-- SECTION 9 : SÉCURITÉ (RLS + policies)
-- Note : les policies détaillées (≈180) sont dans sql/dump-securite-15mai2026.sql.
-- L'essentiel du modèle LBMA : tout est ouvert à la clé anon SAUF admin_users
-- (service_role seulement). Le minimum vital pour rebâtir :
-- =====================================================================
ALTER TABLE public.admin_users ENABLE ROW LEVEL SECURITY;
CREATE POLICY service_role_only_admin_users ON public.admin_users FOR ALL TO public
    USING ((auth.role() = 'service_role'::text))
    WITH CHECK ((auth.role() = 'service_role'::text));
-- Pour les autres tables : RLS activée partout + policies permissives
-- (SELECT/INSERT/UPDATE/DELETE ouverts à anon). Voir dump-securite pour le détail.


-- =====================================================================
-- SECTION 10 : RECALER LES SÉQUENCES — À EXÉCUTER APRÈS L'IMPORT DES CSV
-- =====================================================================
DO $$
DECLARE r RECORD;
BEGIN
  FOR r IN
    SELECT c.relname AS tbl, s.relname AS seq
    FROM pg_class c
    JOIN pg_attribute a ON a.attrelid = c.oid AND a.attname = 'id'
    JOIN pg_attrdef d ON d.adrelid = c.oid AND d.adnum = a.attnum
    JOIN pg_class s ON s.relkind = 'S'
      AND pg_get_expr(d.adbin, d.adrelid) LIKE '%' || s.relname || '%'
    JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE n.nspname = 'public' AND c.relkind = 'r'
  LOOP
    EXECUTE format('SELECT setval(%L, COALESCE((SELECT MAX(id) FROM public.%I), 1))', 'public.' || r.seq, r.tbl);
  END LOOP;
END $$;


-- =====================================================================
-- SECTION 11 : TÂCHES PLANIFIÉES (pg_cron) — état au 23 juillet 2026
-- =====================================================================
-- SELECT cron.schedule('lbma-birthday-emails', '0 13 * * *', 'SELECT send_birthday_emails()');
-- SELECT cron.schedule('nettoyer-fiche-tokens', '0 3 * * 0',
--   $$delete from fiche_tokens where used = true or expires_at < now() - interval '30 days'$$);

-- FIN DU SCHÉMA

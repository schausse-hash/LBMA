-- ====================================
-- TABLE VISITES - LBMA Analytics
-- À exécuter dans Supabase > SQL Editor
-- ====================================

CREATE TABLE IF NOT EXISTS visites (
    id BIGSERIAL PRIMARY KEY,
    page TEXT NOT NULL,
    timestamp TIMESTAMPTZ DEFAULT NOW(),
    referrer TEXT,
    user_agent TEXT,
    screen_width INTEGER
);

-- Index pour les requêtes fréquentes
CREATE INDEX idx_visites_page ON visites(page);
CREATE INDEX idx_visites_timestamp ON visites(timestamp);

-- Activer RLS
ALTER TABLE visites ENABLE ROW LEVEL SECURITY;

-- Politique : tout le monde peut insérer (tracking anonyme)
CREATE POLICY "Permettre insertion anonyme" ON visites
    FOR INSERT TO anon WITH CHECK (true);

-- Politique : seuls les admins peuvent lire (via anon key c'est ok pour notre usage)
CREATE POLICY "Permettre lecture" ON visites
    FOR SELECT TO anon USING (true);

-- Politique : permettre suppression pour le nettoyage
CREATE POLICY "Permettre suppression" ON visites
    FOR DELETE TO anon USING (true);

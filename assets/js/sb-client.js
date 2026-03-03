// === SUPABASE CLIENT CENTRALISÉ ===

// ⚠️ Mets ici TES vraies valeurs
const SUPABASE_URL = "https://xgyskiatppgaeaamjhxr.supabase.co";
const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhneXNraWF0cHBnYWVhYW1qaHhyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA0OTgxNTQsImV4cCI6MjA4NjA3NDE1NH0.67KCcUWlJij-scDoCUvZpkiCle5-mHVmy-inRk96Tac";

// Création du client
window.sb = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

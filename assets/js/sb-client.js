// === SUPABASE REST CLIENT CENTRALISÉ (sbFetch) ===
const SB_URL = "https://xgyskiatppgaeaamjhxr.supabase.co";
const SB_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhneXNraWF0cHBnYWVhYW1qaHhyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA0OTgxNTQsImV4cCI6MjA4NjA3NDE1NH0.67KCcUWlJij-scDoCUvZpkiCle5-mHVmy-inRk96Tac"; // (oui la anon est OK en public si RLS est bon)

async function sbFetch(path, opts = {}) {
  return fetch(`${SB_URL}/rest/v1/${path}`, {
    ...opts,
    headers: {
      apikey: SB_KEY,
      Authorization: `Bearer ${SB_KEY}`,
      "Content-Type": "application/json",
      Prefer: opts.method === "PATCH" ? "return=representation" : "return=minimal",
      ...(opts.headers || {}),
    },
  });
}

// rendre accessible partout
window.SB_URL = SB_URL;
window.sbFetch = sbFetch;

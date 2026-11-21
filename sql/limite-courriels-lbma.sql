-- Limite quotidienne de courriels LBMA (21 nov. 2026)
--
-- Pourquoi : Resend repasse au plan gratuit le 10 déc. 2026 : 100 courriels
-- par jour, PARTAGÉS entre liguelbma.org, facehub.ca et dentiste.com.
-- LBMA se limite donc à 70 par jour (envoi de masse + fiches + anniversaires
-- + réponses SMS transférées), ce qui laisse ~30 aux deux autres sites.
-- Au-delà, api/send-email.js et api/send-fiche.js répondent 429
-- (limite_jour) et admin.html propose « Reprendre » le lendemain.

-- 1. Nombre de courriels LBMA envoyés aujourd'hui (heure de Montréal).
--    p_simulation = true : compte seulement les envois simulés des aperçus
--    Vercel (pour tester l'arrêt sans rien envoyer) ; les anniversaires
--    (vrais envois) ne comptent alors pas.
create or replace function public.lbma_courriels_aujourdhui(p_simulation boolean default false)
returns integer
language sql
stable
security definer
set search_path = public
as $$
  select (
    coalesce((
      select sum(nb_reussis) from journal_envois
      where canal = 'courriel'
        and simulation = p_simulation
        and (created_at at time zone 'America/Toronto')::date = (now() at time zone 'America/Toronto')::date
    ), 0)
    + case when p_simulation then 0 else (
      select count(*) from birthday_emails_sent
      where sent_date = (now() at time zone 'America/Toronto')::date
    ) end
  )::integer;
$$;

revoke all on function public.lbma_courriels_aujourdhui(boolean) from public, anon, authenticated;
grant execute on function public.lbma_courriels_aujourdhui(boolean) to service_role;

-- 2. La limite, modifiable dans Super Admin → Coûts du site → Paramètres.
insert into couts_parametres (cle, valeur, description)
values ('lbma_courriels_jour', 70, 'Courriels LBMA permis par jour (le reste attend « Reprendre » le lendemain)')
on conflict (cle) do nothing;

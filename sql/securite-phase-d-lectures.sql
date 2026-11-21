-- Sécurité phase D (21 nov. 2026) — audit hors saison
--
-- 1. L'ancienne table `joueurs` (2020-2026, plus utilisée par aucune page publique)
--    était lisible par tout le monde : 461 courriels, 461 téléphones, 439 naissances.
-- 2. `birthday_emails_sent` : 48 noms + courriels lisibles par tout le monde.
-- 3. `visites` : journal des visites lisible par tout le monde.
--    → lecture réservée aux admins connectés (jeton x-lbma-token), comme joueurs_liste_admin.
--    Rien n'est supprimé. La tâche des anniversaires (pg_cron, postgres) n'est pas touchée.
-- 4. Vue `joueurs_liste_admin` (security definer) : un visiteur anonyme pouvait y INSÉRER
--    des joueurs (la condition du jeton ne s'applique pas aux insertions). Aucune page
--    n'écrit par cette vue → on retire l'écriture.
-- 5. Bonus : la purge des visites de plus de 90 jours (admin) n'avait aucune policy DELETE.

drop policy if exists "Lecture publique" on public.joueurs;
drop policy if exists "Admins seulement joueurs" on public.joueurs;
create policy "lecture connectee" on public.joueurs
  for select to anon, authenticated using ((select public.lbma_jeton_valide()));

drop policy if exists "Lecture birthday logs" on public.birthday_emails_sent;
create policy "lecture connectee" on public.birthday_emails_sent
  for select to anon, authenticated using ((select public.lbma_jeton_valide()));

drop policy if exists "Lecture publique" on public.visites;
create policy "lecture connectee" on public.visites
  for select to anon, authenticated using ((select public.lbma_jeton_valide()));
create policy "suppression connectee" on public.visites
  for delete to anon, authenticated using ((select public.lbma_jeton_valide()));

revoke insert, update, delete on public.joueurs_liste_admin from anon, authenticated;

-- RETOUR ARRIÈRE (au besoin) :
-- drop policy "lecture connectee" on public.joueurs;
-- create policy "Lecture publique" on public.joueurs for select to anon using (true);
-- drop policy "lecture connectee" on public.birthday_emails_sent;
-- create policy "Lecture birthday logs" on public.birthday_emails_sent for select to anon using (true);
-- drop policy "lecture connectee" on public.visites; drop policy "suppression connectee" on public.visites;
-- create policy "Lecture publique" on public.visites for select to anon using (true);
-- grant insert, update, delete on public.joueurs_liste_admin to anon, authenticated;

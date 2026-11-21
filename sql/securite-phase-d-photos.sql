-- Sécurité phase D — photos (21 nov. 2026)
-- À appliquer APRÈS la fusion de la PR qui ajoute api/photo.js : dès lors, les pages admin
-- téléversent par une adresse de dépôt signée (admin connecté seulement) et n'ont plus
-- besoin d'écrire avec la clé publique.
--
-- Avant : n'importe qui avec la clé publique pouvait ajouter, remplacer ou SUPPRIMER les
-- photos de joueurs et d'équipes (bucket joueurs-photos), et déposer n'importe quel fichier,
-- sans limite de taille ni de type, dans le bucket temple.
-- La lecture publique des photos (affichage sur le site) est conservée.

drop policy if exists "joueurs-photos-anon-upload" on storage.objects;
drop policy if exists "joueurs-photos-anon-update" on storage.objects;
drop policy if exists "joueurs-photos-anon-delete" on storage.objects;
drop policy if exists "temple_insert" on storage.objects;
drop policy if exists "temple_update" on storage.objects;

-- Même garde-fou que joueurs-photos : 5 Mo, images seulement.
update storage.buckets
   set file_size_limit = 5242880,
       allowed_mime_types = array['image/jpeg','image/png','image/webp','image/gif']
 where id = 'temple';

-- RETOUR ARRIÈRE (au besoin) :
-- create policy "joueurs-photos-anon-upload" on storage.objects for insert with check (bucket_id = 'joueurs-photos');
-- create policy "joueurs-photos-anon-update" on storage.objects for update using (bucket_id = 'joueurs-photos');
-- create policy "joueurs-photos-anon-delete" on storage.objects for delete using (bucket_id = 'joueurs-photos');
-- create policy "temple_insert" on storage.objects for insert with check (bucket_id = 'temple');
-- create policy "temple_update" on storage.objects for update using (bucket_id = 'temple');
-- update storage.buckets set file_size_limit = null, allowed_mime_types = null where id = 'temple';

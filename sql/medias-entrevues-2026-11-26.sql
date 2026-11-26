-- =====================================================================
-- LBMA — Entrevues de Jean-Christian Dionne modifiables dans l'admin
-- Fichier : sql/medias-entrevues-2026-11-26.sql   (ÉTAPE 1 sur 2)
-- =====================================================================
-- Ce que ça fait :
--   Crée la table public.medias_entrevues (une ligne par entrevue) :
--     nom, catégorie (joueur actuel ou légende), sous-titre, texte de
--     l'entrevue (HTML simple), visible oui/non.
--   Lecture publique des entrevues visibles ; un admin connecté (jeton
--   x-lbma-token, rôle admin ou superadmin) voit tout et peut ajouter ou
--   modifier. Aucune suppression depuis le site : on masque (visible = false).
--   Suit docs/template_sql_apres30octobre.txt (RLS activée, GRANT,
--   politiques explicites) et la matrice de sql/securite-phase-e2-roles.sql
--   (médias = admin).
--
-- Ce que ça ne fait PAS :
--   Ne touche pas medias_articles ni medias_podcasts (elles restent, vides).
--   N'importe pas les entrevues : c'est l'étape 2,
--   sql/medias-entrevues-import-2026-11-26.sql.
--
-- Retour en arrière (table neuve, rien d'autre ne dépend d'elle) :
--   drop table if exists public.medias_entrevues;
--   (opération destructive : seulement avec le « go » de Sergio)
-- =====================================================================

create table if not exists public.medias_entrevues (
    id          bigserial primary key,
    slug        text not null unique,                 -- identifiant dans l'adresse : entrevue.html?e=<slug>
    nom         text not null,                        -- nom affiché, ex. « Michel Plante »
    categorie   text not null default 'actuel'
                check (categorie in ('actuel', 'legende')),
    sous_titre  text,                                 -- ex. « Joueur actuel de la LBMA »
    contenu     text not null default '',             -- texte de l'entrevue, HTML simple (p, h3, strong…)
    visible     boolean not null default true,
    created_at  timestamptz not null default now(),
    updated_at  timestamptz not null default now()
);

alter table public.medias_entrevues enable row level security;

-- Le site écrit avec la clé anon + le jeton de session (x-lbma-token) :
-- anon reçoit donc select / insert / update, et les politiques filtrent.
grant select, insert, update on public.medias_entrevues to anon, authenticated;
grant select, insert, update, delete on public.medias_entrevues to service_role;
grant usage, select on sequence public.medias_entrevues_id_seq to anon, authenticated, service_role;

-- Lecture : tout le monde voit les entrevues visibles ; un admin voit aussi les masquées.
create policy "lecture publique"
    on public.medias_entrevues for select
    to anon, authenticated
    using (visible or (select public.lbma_jeton_admin()));

-- Écriture : admin ou superadmin connecté (même règle que les autres tables médias).
create policy "ecriture connectee insert"
    on public.medias_entrevues for insert
    to anon, authenticated
    with check ((select public.lbma_jeton_admin()));

create policy "ecriture connectee update"
    on public.medias_entrevues for update
    to anon, authenticated
    using ((select public.lbma_jeton_admin()))
    with check ((select public.lbma_jeton_admin()));

-- Pas de politique DELETE : personne ne supprime une entrevue depuis le site.

-- Date de modification tenue à jour automatiquement.
create or replace function public.medias_entrevues_maj() returns trigger
language plpgsql set search_path = public as $f$
begin
  new.updated_at := now();
  return new;
end;
$f$;

drop trigger if exists medias_entrevues_maj on public.medias_entrevues;
create trigger medias_entrevues_maj before update on public.medias_entrevues
    for each row execute function public.medias_entrevues_maj();

-- Vérification (lancer à part) :
--   select count(*) from public.medias_entrevues;          -- 0 avant l'étape 2
--   select policyname, cmd from pg_policies where tablename = 'medias_entrevues';

-- Réponses des joueurs aux SMS de la ligue (api/sms-entrant.js) — migration « sms_recus », déjà appliquée.
-- Gardées pour ne rien perdre si le courriel échoue ; RLS sans policy = service_role seulement.
create table if not exists public.sms_recus (
  id            bigint generated always as identity primary key,
  recu_le       timestamptz not null default now(),
  message_sid   text unique,
  de            text not null,
  nom_joueur    text,
  texte         text,
  nb_medias     integer not null default 0,
  segments      integer not null default 1,
  transfere     boolean not null default false,
  transfere_le  timestamptz,
  tentatives    integer not null default 0,
  erreur        text
);
create index if not exists sms_recus_a_transferer_idx on public.sms_recus (recu_le) where not transfere;
alter table public.sms_recus enable row level security;

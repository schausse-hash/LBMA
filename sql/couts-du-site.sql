-- =====================================================================
-- COÛTS DU SITE — page Super Admin « 💰 Coûts du site » (nov. 2026)
-- Migration Supabase : couts_du_site
--
-- Trois tables, toutes en RLS SANS policy : seul le service_role (les
-- fonctions /api de Vercel) peut lire ou écrire. Le navigateur n'y a
-- jamais accès directement — il passe par /api/couts, réservé au superadmin.
-- =====================================================================

-- 1) Journal de chaque envoi (SMS Twilio, courriels Resend)
create table if not exists public.journal_envois (
  id                bigint generated always as identity primary key,
  created_at        timestamptz not null default now(),
  canal             text not null check (canal in ('sms', 'courriel')),
  type_envoi        text not null,          -- sms_alerte | courriel_masse | fiche
  nb_destinataires  integer not null default 0,
  nb_reussis        integer not null default 0,
  nb_echecs         integer not null default 0,
  segments          integer,                -- SMS : segments facturés par Twilio
  cout_estime_usd   numeric(10,4),
  simulation        boolean not null default false,  -- envoi fait depuis un aperçu Vercel (rien n'est parti)
  demande_par       text,
  sujet             text
);
create index if not exists journal_envois_created_at_idx on public.journal_envois (created_at);
alter table public.journal_envois enable row level security;

-- 2) Abonnements et frais fixes (modifiables depuis la page)
create table if not exists public.couts_fixes (
  id           bigint generated always as identity primary key,
  service      text not null,
  description  text,
  categorie    text not null default 'hebergement',
  montant      numeric(10,2) not null default 0 check (montant >= 0),
  devise       text not null default 'USD' check (devise in ('USD', 'CAD')),
  frequence    text not null default 'mois' check (frequence in ('mois', 'an')),
  part_lbma    numeric(5,4) not null default 1 check (part_lbma >= 0 and part_lbma <= 1),
  a_confirmer  boolean not null default false,
  actif        boolean not null default true,
  ordre        integer not null default 0,
  maj_le       timestamptz not null default now()
);
alter table public.couts_fixes enable row level security;

-- 3) Paramètres de calcul
create table if not exists public.couts_parametres (
  cle          text primary key,
  valeur       numeric not null,
  description  text
);
alter table public.couts_parametres enable row level security;

-- 4) Taille de la base (pour la jauge Supabase) — service_role seulement
create or replace function public.lbma_taille_bd()
returns bigint
language sql stable security definer set search_path = public
as $$ select pg_database_size(current_database()); $$;
revoke all on function public.lbma_taille_bd() from public, anon, authenticated;
grant execute on function public.lbma_taille_bd() to service_role;

-- 5) Valeurs de départ (à ajuster dans la page)
insert into public.couts_fixes (service, description, categorie, montant, devise, frequence, part_lbma, a_confirmer, ordre)
select * from (values
  ('Supabase', 'Forfait Pro de l''organisation (25 $) + calcul Micro des 3 projets (3 × 10 $) − crédit de 10 $ = 45 $/mois. LBMA = 1 projet sur 3.', 'hebergement', 45.00, 'USD', 'mois', 0.3333, false, 10),
  ('Vercel', 'Forfait Pro de l''équipe (20 $/mois) partagé entre 5 projets (lbma, dentiste.com, FaceHub, générateur de notes, test). Confirmer le forfait dans Vercel → Settings → Billing.', 'hebergement', 20.00, 'USD', 'mois', 0.2000, true, 20),
  ('Resend', 'Courriels — plan gratuit : 3 000/mois, maximum 100 par jour.', 'courriel', 0.00, 'USD', 'mois', 1.0000, false, 30),
  ('Domaine liguelbma.org', 'Network Solutions — inscrire le montant de la facture annuelle.', 'domaine', 0.00, 'CAD', 'an', 1.0000, true, 40)
) as v(service, description, categorie, montant, devise, frequence, part_lbma, a_confirmer, ordre)
where not exists (select 1 from public.couts_fixes);

insert into public.couts_parametres (cle, valeur, description) values
  ('taux_usd_cad', 1.40, 'Taux de secours si la Banque du Canada ne répond pas'),
  ('sms_prix_segment_usd', 0.0079, 'Prix Twilio par segment SMS au Canada (sans frais des transporteurs) — sert aux estimations'),
  ('resend_quota_jour', 100, 'Limite quotidienne de courriels du plan Resend'),
  ('resend_quota_mois', 3000, 'Limite mensuelle de courriels du plan Resend')
on conflict (cle) do nothing;

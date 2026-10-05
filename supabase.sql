-- =====================================================================
--  SMARTWORLD — À coller dans Supabase > SQL Editor > New query > Run
--  ⚠️ AVANT de lancer : remplacez VOTRE_EMAIL_ADMIN@exemple.com (4 fois)
--     par l'e-mail que vous utiliserez pour vous connecter à la page admin.
-- =====================================================================

create table if not exists public.products (
  id          uuid primary key default gen_random_uuid(),
  slug        text unique not null,
  name        text not null,
  category    text not null default 'pc',        -- pc | telephone | accessoire
  specs       text not null default '',          -- une caractéristique par ligne
  condition   text not null default '',          -- ex : Neuf, Importé – Très bon état
  price       integer,                           -- en F CFA (vide = prix sur demande)
  image_url   text,
  active      boolean not null default true,     -- false = caché du site
  position    integer not null default 0,        -- ordre d'affichage
  created_at  timestamptz not null default now()
);

alter table public.products enable row level security;

-- Tout le monde peut VOIR les produits actifs (les visiteurs du site)
drop policy if exists "public lit produits actifs" on public.products;
create policy "public lit produits actifs" on public.products
  for select using (active = true);

-- Seul l'admin (votre e-mail) peut tout voir / ajouter / modifier / supprimer
drop policy if exists "admin gere produits" on public.products;
create policy "admin gere produits" on public.products
  for all to authenticated
  using ((auth.jwt() ->> 'email') = 'VOTRE_EMAIL_ADMIN@exemple.com')
  with check ((auth.jwt() ->> 'email') = 'VOTRE_EMAIL_ADMIN@exemple.com');

-- Dossier photos (public en lecture)
insert into storage.buckets (id, name, public)
values ('products', 'products', true)
on conflict (id) do update set public = true;

-- Seul l'admin peut envoyer / remplacer / supprimer des photos
drop policy if exists "admin photos" on storage.objects;
create policy "admin photos" on storage.objects
  for all to authenticated
  using (bucket_id = 'products' and (auth.jwt() ->> 'email') = 'VOTRE_EMAIL_ADMIN@exemple.com')
  with check (bucket_id = 'products' and (auth.jwt() ->> 'email') = 'VOTRE_EMAIL_ADMIN@exemple.com');

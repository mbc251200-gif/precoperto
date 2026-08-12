create extension if not exists pgcrypto;

create table if not exists profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  name text,
  phone text,
  user_type text not null default 'consumer'
    check (user_type in ('consumer','seller','admin')),
  city text,
  created_at timestamptz not null default now()
);

create table if not exists sellers (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references profiles(id) on delete cascade,
  business_name text not null,
  document text,
  description text,
  phone text,
  address text,
  latitude double precision,
  longitude double precision,
  verified boolean not null default false,
  rating numeric(3,2) not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists categories (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  type text not null check (type in ('product','service','both')),
  parent_id uuid references categories(id),
  created_at timestamptz not null default now()
);

create table if not exists products (
  id uuid primary key default gen_random_uuid(),
  seller_id uuid not null references sellers(id) on delete cascade,
  category_id uuid references categories(id),
  name text not null,
  description text,
  brand text,
  model text,
  created_at timestamptz not null default now()
);

create table if not exists services (
  id uuid primary key default gen_random_uuid(),
  seller_id uuid not null references sellers(id) on delete cascade,
  category_id uuid references categories(id),
  name text not null,
  description text,
  starting_price numeric(12,2),
  service_radius_km numeric(8,2),
  created_at timestamptz not null default now()
);

create table if not exists offers (
  id uuid primary key default gen_random_uuid(),
  seller_id uuid not null references sellers(id) on delete cascade,
  product_id uuid references products(id) on delete cascade,
  service_id uuid references services(id) on delete cascade,
  price numeric(12,2) not null,
  promotional_price numeric(12,2),
  stock integer,
  delivery_price numeric(12,2),
  status text not null default 'active'
    check (status in ('active','paused','sold_out')),
  created_at timestamptz not null default now(),
  check (
    (product_id is not null and service_id is null)
    or
    (product_id is null and service_id is not null)
  )
);

create table if not exists reviews (
  id uuid primary key default gen_random_uuid(),
  reviewer_id uuid not null references profiles(id) on delete cascade,
  seller_id uuid not null references sellers(id) on delete cascade,
  product_id uuid references products(id),
  service_id uuid references services(id),
  rating integer not null check (rating between 1 and 5),
  comment text,
  created_at timestamptz not null default now()
);

create table if not exists favorites (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references profiles(id) on delete cascade,
  product_id uuid references products(id),
  service_id uuid references services(id),
  created_at timestamptz not null default now()
);

create table if not exists conversations (
  id uuid primary key default gen_random_uuid(),
  buyer_id uuid not null references profiles(id) on delete cascade,
  seller_id uuid not null references sellers(id) on delete cascade,
  created_at timestamptz not null default now()
);

create table if not exists messages (
  id uuid primary key default gen_random_uuid(),
  conversation_id uuid not null references conversations(id) on delete cascade,
  sender_id uuid not null references profiles(id) on delete cascade,
  body text not null,
  created_at timestamptz not null default now()
);

create table if not exists quote_requests (
  id uuid primary key default gen_random_uuid(),
  buyer_id uuid not null references profiles(id) on delete cascade,
  category_id uuid references categories(id),
  description text not null,
  budget numeric(12,2),
  latitude double precision,
  longitude double precision,
  status text not null default 'open'
    check (status in ('open','closed','cancelled')),
  created_at timestamptz not null default now()
);

create table if not exists sponsored_campaigns (
  id uuid primary key default gen_random_uuid(),
  seller_id uuid not null references sellers(id) on delete cascade,
  budget numeric(12,2) not null,
  daily_budget numeric(12,2),
  target_category uuid references categories(id),
  target_city text,
  start_date date not null,
  end_date date not null,
  status text not null default 'draft'
    check (status in ('draft','active','paused','finished')),
  created_at timestamptz not null default now()
);

create table if not exists ad_events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references profiles(id) on delete set null,
  ad_network text,
  placement text,
  event_type text not null check (event_type in ('impression','click','reward')),
  session_id text,
  created_at timestamptz not null default now()
);

create index if not exists idx_offers_price on offers(price);
create index if not exists idx_offers_seller on offers(seller_id);
create index if not exists idx_products_name on products using gin(to_tsvector('simple', name));
create index if not exists idx_services_name on services using gin(to_tsvector('simple', name));
create index if not exists idx_sellers_location on sellers(latitude, longitude);

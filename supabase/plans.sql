
create table if not exists seller_plans (
  id uuid primary key default gen_random_uuid(),
  seller_id uuid not null references sellers(id) on delete cascade,
  plan text not null check (plan in ('free','pro','business')),
  status text not null default 'active',
  started_at timestamptz not null default now(),
  expires_at timestamptz
);

create index if not exists idx_seller_plans_seller on seller_plans(seller_id);

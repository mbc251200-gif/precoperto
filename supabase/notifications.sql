
create table if not exists device_tokens (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references profiles(id) on delete cascade,
  token text not null,
  platform text,
  created_at timestamptz not null default now(),
  unique(user_id, token)
);

alter table device_tokens enable row level security;

create policy "users manage own device tokens"
on device_tokens for all
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

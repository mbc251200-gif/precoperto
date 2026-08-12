
-- Execute depois do schema.sql.
alter table profiles enable row level security;
alter table sellers enable row level security;
alter table categories enable row level security;
alter table products enable row level security;
alter table services enable row level security;
alter table offers enable row level security;
alter table reviews enable row level security;
alter table favorites enable row level security;
alter table conversations enable row level security;
alter table messages enable row level security;
alter table quote_requests enable row level security;
alter table sponsored_campaigns enable row level security;
alter table ad_events enable row level security;

create policy "public read categories" on categories for select using (true);
create policy "public read sellers" on sellers for select using (true);
create policy "public read products" on products for select using (true);
create policy "public read services" on services for select using (true);
create policy "public read active offers" on offers for select using (status = 'active');
create policy "user reads own profile" on profiles for select using (auth.uid() = id);
create policy "user updates own profile" on profiles for update using (auth.uid() = id);
create policy "user inserts own profile" on profiles for insert with check (auth.uid() = id);

create policy "seller creates own seller profile" on sellers for insert with check (auth.uid() = owner_id);
create policy "seller updates own seller profile" on sellers for update using (auth.uid() = owner_id);

create policy "seller inserts own products" on products for insert with check (
  exists (select 1 from sellers s where s.id = seller_id and s.owner_id = auth.uid())
);
create policy "seller inserts own services" on services for insert with check (
  exists (select 1 from sellers s where s.id = seller_id and s.owner_id = auth.uid())
);
create policy "seller inserts own offers" on offers for insert with check (
  exists (select 1 from sellers s where s.id = seller_id and s.owner_id = auth.uid())
);
create policy "seller updates own offers" on offers for update using (
  exists (select 1 from sellers s where s.id = seller_id and s.owner_id = auth.uid())
);

create policy "user manages own favorites" on favorites for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "user creates reviews" on reviews for insert with check (auth.uid() = reviewer_id);
create policy "user reads reviews" on reviews for select using (true);

create policy "user creates quote requests" on quote_requests for insert with check (auth.uid() = buyer_id);
create policy "user reads own quote requests" on quote_requests for select using (auth.uid() = buyer_id);

create policy "participants read conversations" on conversations for select using (
  auth.uid() = buyer_id
  or exists (select 1 from sellers s where s.id = seller_id and s.owner_id = auth.uid())
);

create policy "buyer creates conversations" on conversations for insert with check (auth.uid() = buyer_id);

create policy "participants read messages" on messages for select using (
  exists (
    select 1 from conversations c
    where c.id = conversation_id
      and (
        c.buyer_id = auth.uid()
        or exists (select 1 from sellers s where s.id = c.seller_id and s.owner_id = auth.uid())
      )
  )
);

create policy "participants send messages" on messages for insert with check (auth.uid() = sender_id);

create policy "seller manages own campaigns" on sponsored_campaigns for all using (
  exists (select 1 from sellers s where s.id = seller_id and s.owner_id = auth.uid())
) with check (
  exists (select 1 from sellers s where s.id = seller_id and s.owner_id = auth.uid())
);

create policy "authenticated records ad events" on ad_events for insert with check (
  auth.uid() = user_id or user_id is null
);

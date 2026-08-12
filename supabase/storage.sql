
-- Crie o bucket no Storage antes de usar upload de imagens.
insert into storage.buckets (id, name, public)
values ('offer-images','offer-images',true)
on conflict (id) do nothing;

create policy "public read offer images"
on storage.objects for select
using (bucket_id = 'offer-images');

create policy "authenticated upload offer images"
on storage.objects for insert
with check (bucket_id = 'offer-images' and auth.role() = 'authenticated');

create policy "owner updates offer images"
on storage.objects for update
using (bucket_id = 'offer-images' and owner_id = auth.uid()::text);

create policy "owner deletes offer images"
on storage.objects for delete
using (bucket_id = 'offer-images' and owner_id = auth.uid()::text);

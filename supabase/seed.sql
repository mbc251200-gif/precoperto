insert into categories (name, type) values
('Eletrônicos','product'),
('Casa','both'),
('Automóveis','both'),
('Tecnologia','both'),
('Beleza','service'),
('Eletricista','service'),
('Instalação de ar-condicionado','service')
on conflict do nothing;

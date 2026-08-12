# Arquitetura

## Cliente
Flutter para Android/iOS.

## Backend
Supabase:
- Auth
- PostgreSQL
- Storage
- APIs REST/Realtime

## Serviços externos
- AdMob para publicidade
- Firebase Cloud Messaging para notificações
- Google Maps/Mapbox para localização
- Gateway de pagamento na fase transacional

## Regra de ranking
MVP:
1. preço
2. avaliação
3. distância
4. disponibilidade

Fase 2: índice de custo-benefício com pesos configuráveis.

## Segurança
- RLS no Supabase
- validação de entrada
- rate limiting no backend
- moderação de anúncios
- antifraude para eventos publicitários


# Configuração do MVP funcional

## 1. Supabase
1. Crie um projeto Supabase.
2. Abra SQL Editor.
3. Execute `supabase/schema.sql`.
4. Execute `supabase/rls.sql`.
5. Execute `supabase/seed.sql`.
6. Em Authentication, configure e-mail/senha.

## 2. Flutter
No diretório do app:

```bash
flutter pub get
flutter run --dart-define=SUPABASE_URL=https://SEU-PROJETO.supabase.co --dart-define=SUPABASE_ANON_KEY=SUA_ANON_KEY
```

## 3. Fluxos já implementados
- busca local/demonstração
- busca via Supabase quando configurado
- cadastro/login
- criação de perfil
- cadastro de serviço por vendedor
- criação automática da oferta
- leitura de ofertas ativas
- RLS básico

## 4. Antes de produção
- configurar Storage para imagens
- implementar localização real
- implementar chat Realtime
- adicionar notificações
- integrar AdMob
- implementar moderação
- implementar rate limiting/antifraude
- validar regras de privacidade e LGPD
- adicionar testes automatizados

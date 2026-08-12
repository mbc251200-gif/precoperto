
import '../services/supabase_service.dart';

class AuthRepository {
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String type,
  }) async {
    final client = SupabaseService.client;
    if (client == null) throw Exception('Configure o Supabase primeiro.');

    final result = await client.auth.signUp(email: email, password: password);
    final user = result.user;
    if (user == null) throw Exception('Não foi possível criar a conta.');

    await client.from('profiles').upsert({
      'id': user.id,
      'name': name,
      'user_type': type,
    });
  }

  Future<void> signIn(String email, String password) async {
    final client = SupabaseService.client;
    if (client == null) throw Exception('Configure o Supabase primeiro.');
    await client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    final client = SupabaseService.client;
    if (client != null) await client.auth.signOut();
  }
}

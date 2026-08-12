
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config.dart';

class SupabaseService {
  static Future<void> initialize() async {
    if (!AppConfig.isConfigured) return;
    await Supabase.initialize(
      url: AppConfig.supabaseUrl,
      publishableKey: AppConfig.supabaseAnonKey,
    );
  }

  static SupabaseClient? get client =>
      AppConfig.isConfigured ? Supabase.instance.client : null;
}

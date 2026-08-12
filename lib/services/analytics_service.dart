
import 'package:supabase_flutter/supabase_flutter.dart';

class AnalyticsService {
  final client = Supabase.instance.client;

  Future<void> adEvent(String type, String placement) async {
    await client.from('ad_events').insert({
      'user_id': client.auth.currentUser?.id,
      'event_type': type,
      'placement': placement,
      'ad_network': 'admob',
      'session_id': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }
}

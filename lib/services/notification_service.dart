
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final plugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await plugin.initialize(settings);
  }

  Future<void> show(String title, String body) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'precoperto',
        'PreçoPerto',
        channelDescription: 'Alertas e mensagens do PreçoPerto',
        importance: Importance.high,
        priority: Priority.high,
      ),
    );
    await plugin.show(DateTime.now().millisecondsSinceEpoch ~/ 1000, title, body, details);
  }
}

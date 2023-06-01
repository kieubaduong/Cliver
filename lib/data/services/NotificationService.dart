import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService instance =
      NotificationService._initInstance();

  late FlutterLocalNotificationsPlugin _notifications;

  NotificationService._initInstance() {
    _notifications = FlutterLocalNotificationsPlugin();
    _notifications.initialize(const InitializationSettings(
      android: AndroidInitializationSettings("chat"),
    ));
  }

  Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
      );
}

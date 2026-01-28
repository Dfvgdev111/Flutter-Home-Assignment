import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MemoryNotifcations {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettingsAndroid =
        InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        );

    _notificationsPlugin.initialize(
      settings: initializationSettingsAndroid,

      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {}
      },
    );
  }

  static Future<void> notficationAlert(String heading, String? body) async {
    NotificationDetails Details = NotificationDetails(
      android: AndroidNotificationDetails("96", "SumbitNotfication"),
    );

    final id = DateTime.now().millisecondsSinceEpoch % 2147483647;

    await _notificationsPlugin.show(
      id: id,
      title: heading,
      notificationDetails: Details,
      body: body,
    );
  }
}

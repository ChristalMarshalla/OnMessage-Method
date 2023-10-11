import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Create an instance of the FlutterLocalNotificationsPlugin.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Local Notifications Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await _initializeNotifications();
              await _scheduleNotification();
            },
            child: Text('Schedule Notification'),
          ),
        ),
      ),
    );
  }

  Future<void> _initializeNotifications() async {
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('app_icon');
    // final IOSInitializationSettings iosInitializationSettings =
    //     IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      // iOS: iosInitializationSettings,
    );

    // await flutterLocalNotificationsPlugin.initialize(
    //   initializationSettings,
    //   onSelectNotification: _onSelectNotification,
    // );
  }

  Future<void> _scheduleNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'Local Notification Title',
      // 'Local Notification Body',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    // const IOSNotificationDetails iosPlatformChannelSpecifics =
    //     IOSNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOS: iosPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Scheduled Notification Title',
      'Scheduled Notification Body',
      // DateTime.now().add(Duration(seconds: 5)),
      // platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> _onSelectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('Notification clicked with payload: $payload');
    }
  }
}

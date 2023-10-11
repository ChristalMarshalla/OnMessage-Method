import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  MyApp() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        // Handle the notification when the app is in the foreground
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        // Handle the notification when the app is launched from a terminated state
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        // Handle the notification when the app is resumed from the background
        print("onResume: $message");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Push Notification Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Push Notification Example'),
        ),
        body: Center(
          child: Text('Your app content goes here.'),
        ),
      ),
    );
  }
}

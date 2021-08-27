import 'package:call_notification/call_notification.dart';
import 'package:call_notification_example/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  CallNotification().initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }
}

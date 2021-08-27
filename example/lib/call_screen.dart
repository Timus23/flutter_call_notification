import 'package:call_notification/call_notification.dart';
import 'package:call_notification_example/calling_screen.dart';
import 'package:flutter/material.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                CallNotification().cancelCallNotification();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CallingScreen(),
                  ),
                );
              },
              child: Text("Accept"),
            ),
            TextButton(
              onPressed: () {
                CallNotification().cancelCallNotification();
                Navigator.pop(context);
              },
              child: Text("Rejects"),
            ),
          ],
        ),
      ),
    );
  }
}

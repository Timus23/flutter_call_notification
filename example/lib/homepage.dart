import 'package:call_notification/call_notification.dart';
import 'package:call_notification/model/received_action.dart';
import 'package:call_notification_example/call_screen.dart';
import 'package:call_notification_example/calling_screen.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();

    CallNotification().actionStream.listen((event) {
      print("Call Events-----------------------");
      print(event.notification.toJson());
      if (event.buttonInputType == ButtonInputType.Accepts) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallingScreen(),
          ),
        );
      } else if (event.buttonInputType == ButtonInputType.Decline) {
        print("decline------------------");
      } else if (event.buttonInputType == ButtonInputType.Launch) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(),
          ),
        );
      }
    }, onError: (err) {
      print(err);
    });
  }

  @override
  void dispose() {
    CallNotification().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              CallNotificationData callNotificationData = CallNotificationData(
                callerName: "Sumit kakshapati",
                roomId: "123456",
                isBackgroundNotification: true,
              );
                CallNotification().showNotification(
                    callNotificationData: callNotificationData);
            },
            child: Text("Show Notification"),
          ),
          TextButton(
            onPressed: () {
              CallNotificationData callNotificationData = CallNotificationData(
                callerName: "Sumit kakshapati",
                roomId: "123456",
                isBackgroundNotification: true,
              );
              CallNotification()
                  .actionStream
                  .add(NotificationReceivedAction.fromJson(
                    {
                      "buttonInputType": "accept",
                      "notification": callNotificationData.toJson(),
                    },
                  ));
            },
            child: Text("Stream"),
          ),
          TextButton(
            onPressed: () async {
              final status = await CallNotification().isNotificationEnabled;
              print(status);
            },
            child: Text("NotificationStatus"),
          )
        ],
      ),
    );
  }
}

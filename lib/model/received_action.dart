import 'package:call_notification/enum/button_input_type.dart';
import 'package:call_notification/model/call_notification_data.dart';

class NotificationReceivedAction {
  ButtonInputType buttonInputType;
  CallNotificationData notification;

  NotificationReceivedAction({
    required this.buttonInputType,
    required this.notification,
  });

  factory NotificationReceivedAction.handled() {
    return NotificationReceivedAction(
      buttonInputType: ButtonInputType.Handled,
      notification: CallNotificationData.initial(),
    );
  }

  factory NotificationReceivedAction.fromJson(Map<String, dynamic> json) {
    ButtonInputType type = ButtonInputType.Launch;
    if (json["buttonInputType"]?.toString() == "accept") {
      type = ButtonInputType.Accepts;
    } else if (json["buttonInputType"]?.toString() == "reject") {
      type = ButtonInputType.Decline;
    } else if (json["buttonInputType"]?.toString() == "launch") {
      type = ButtonInputType.Launch;
    } else {
      type = ButtonInputType.None;
    }
    return NotificationReceivedAction(
      buttonInputType: type,
      notification: CallNotificationData.toJson(
          Map<String, dynamic>.from(json["notification"] ?? {})),
    );
  }
}

import 'package:call_notification/enum/channel_profile.dart';
import 'package:call_notification/enum/client_role.dart';
import 'package:call_notification/utils/enum_utils.dart';

class CallNotificationData {
  String callerName;
  String roomId;
  ClientRole clientRole;
  ChannelProfile channelProfile;
  Map<String, dynamic> extra;
  int notificationAutoCancelDuration;
  bool isBackgroundNotification;

  CallNotificationData({
    required this.callerName,
    required this.roomId,
    this.channelProfile = ChannelProfile.Communication,
    this.clientRole = ClientRole.Audience,
    this.extra = const {},
    this.notificationAutoCancelDuration = 30,
    required this.isBackgroundNotification,
  });

  Map<String, dynamic> toJson() {
    return {
      "callerName": callerName,
      "roomId": roomId,
      "channelProfile":
          EnumTransformUtils.getChannelProfile(this.channelProfile),
      "clientRole": EnumTransformUtils.getClientRole(this.clientRole),
      "extra": this.extra,
      "notificationDuration": this.notificationAutoCancelDuration,
      "isBackgroundNotification": this.isBackgroundNotification,
    };
  }

  factory CallNotificationData.toJson(Map<String, dynamic> json) {
    return CallNotificationData(
      callerName: json["callerName"] ?? "",
      channelProfile: EnumTransformUtils.getChannelProfileEnum(
          json["channelProfile"] ?? ""),
      clientRole:
          EnumTransformUtils.getClientRoleEnum(json["clientRole"] ?? ""),
      roomId: json["roomId"] ?? "",
      extra: Map<String, dynamic>.from(json["extra"] ?? {}),
      notificationAutoCancelDuration: json["notificationDuration"] ?? 30,
      isBackgroundNotification: json["isBackgroundNotification"] ?? false,
    );
  }
}

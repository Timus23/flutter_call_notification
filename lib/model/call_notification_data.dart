import 'package:call_notification/enum/channel_profile.dart';
import 'package:call_notification/enum/client_role.dart';
import 'package:call_notification/utils/enum_utils.dart';

class CallNotificationData {
  String callerName;
  String description;
  String roomId;
  ClientRole clientRole;
  ChannelProfile channelProfile;
  Map<String, dynamic> extra;

  CallNotificationData({
    required this.description,
    required this.callerName,
    required this.roomId,
    required this.channelProfile,
    required this.clientRole,
    required this.extra,
  });

  Map<String, dynamic> toJson() {
    return {
      "callerName": callerName,
      "description": description,
      "roomId": roomId,
      "channelProfile":
          EnumTransformUtils.getChannelProfile(this.channelProfile),
      "clientRole": EnumTransformUtils.getClientRole(this.clientRole),
      "extra": this.extra,
    };
  }

  factory CallNotificationData.toJson(Map<String, dynamic> json) {
    return CallNotificationData(
      callerName: json["callerName"] ?? "",
      channelProfile: EnumTransformUtils.getChannelProfileEnum(
          json["channelProfile"] ?? ""),
      clientRole:
          EnumTransformUtils.getClientRoleEnum(json["clientRole"] ?? ""),
      description: json["description"] ?? "",
      roomId: json["roomId"] ?? "",
      extra: Map<String, dynamic>.from(json["extra"] ?? {}),
    );
  }
}

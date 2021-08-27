import 'package:call_notification/enum/channel_profile.dart';
import 'package:call_notification/enum/client_role.dart';

class EnumTransformUtils {
  static ChannelProfile getChannelProfileEnum(String profile) {
    switch (profile) {
      case "game":
        return ChannelProfile.Game;
      case "liveBroadcasting":
        return ChannelProfile.LiveBroadcasting;
      default:
        return ChannelProfile.Communication;
    }
  }

  static ClientRole getClientRoleEnum(String profile) {
    switch (profile) {
      case "audience":
        return ClientRole.Audience;
      default:
        return ClientRole.Broadcaster;
    }
  }

  static String getChannelProfile(ChannelProfile profile) {
    switch (profile) {
      case ChannelProfile.Communication:
        return "game";
      case ChannelProfile.LiveBroadcasting:
        return "liveBroadcasting";
      default:
        return "communication";
    }
  }

  static String getClientRole(ClientRole role) {
    switch (role) {
      case ClientRole.Audience:
        return "audience";
      default:
        return "broadcaster";
    }
  }
}

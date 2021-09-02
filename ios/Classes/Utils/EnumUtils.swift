class EnumUtils {
    static func getClientRoleString(role: ClientRole) -> String {
        switch role {
        case ClientRole.Audience:
            return "audience"
        default:
           return "broadcaster"
        }
    }
    
    static func getChannelProfileString(channel: ChannelProfile) -> String {
        switch channel {
        case ChannelProfile.Game:
            return "game"
        case ChannelProfile.LiveBroadcasting:
            return "liveBroadcasting"
        default:
           return "communication"
        }
    }
    
    static func getClientRoleEnum(role: String) -> ClientRole {
        switch role {
        case "audience":
            return ClientRole.Audience
        default:
            return ClientRole.Broadcaster
        }
    }
    
    static func getChannelProfileEnum(channel: String) -> ChannelProfile {
        switch channel {
        case "game":
            return ChannelProfile.Game
        case "liveBroadcasting":
            return ChannelProfile.LiveBroadcasting
        default:
            return ChannelProfile.Communication
        }
    }
}

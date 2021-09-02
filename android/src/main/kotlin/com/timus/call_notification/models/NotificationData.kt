package com.timus.call_notification.models

import com.timus.call_notification.enums.ChannelProfile
import com.timus.call_notification.enums.ClientRole

class NotificationData(arguments: Map<String, Any>) {
    var callerName : String = arguments["callerName"] as String;
    var roomId :String = arguments["roomId"] as String
    var clientRole: ClientRole;
    var channelProfile: ChannelProfile;
    var extra : HashMap<String,Any>;
    var notificationDuration : Int = arguments["notificationDuration"] as Int;

    init {
        clientRole = getClientRoleEnum(arguments["clientRole"] as String)
        channelProfile = getChannelProfileEnum(arguments["channelProfile"] as String)
        extra = (arguments["extra"] ?: HashMap<String,Any>()) as HashMap<String, Any>
    }

    fun toMap(): Map<String, Any> {
        var returnedObject: HashMap<String, Any> = HashMap<String, Any> ()
        returnedObject["callerName"] = this.callerName;
        returnedObject["roomId"] = this.roomId;
        returnedObject["clientRole"] = getEnumClientRoleString(this.clientRole)
        returnedObject["channelProfile"] = getEnumChannelProfileString(this.channelProfile)
        returnedObject["extra"] = this.extra
        returnedObject["notificationDuration"] = this.notificationDuration
        return returnedObject;
    }

    private fun getClientRoleEnum(role : String) : ClientRole{
        return if(role == "audience") ClientRole.Audience;
        else ClientRole.BroadCaster;
    }

    private fun getEnumClientRoleString(role : ClientRole) : String{
        return if(role == ClientRole.Audience) "audience";
        else "broadcaster";
    }

    private fun getChannelProfileEnum(role : String) : ChannelProfile{
        return when (role) {
            "game" -> ChannelProfile.Game
            "liveBroadcasting" -> ChannelProfile.LiveBroadcasting
            else -> ChannelProfile.Communication
        };
    }

    private fun getEnumChannelProfileString(role : ChannelProfile) : String{
        return when (role) {
            ChannelProfile.Game -> "game"
            ChannelProfile.LiveBroadcasting -> "liveBroadcasting"
            else -> "communication"
        };
    }
}
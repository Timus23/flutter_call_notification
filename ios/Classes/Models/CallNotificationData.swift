class CallNotificationData{
    var callerName : String
    var roomId : String
    var clientRole : ClientRole
    var channelProfile: ChannelProfile
    var extra : Dictionary<String,Any>
    var notificationDuration : Int
    
    init(json : Dictionary<String,Any>) {
        self.callerName = json["callerName"] as? String ?? ""
        self.roomId = json["roomId"] as? String ?? ""
        self.clientRole = EnumUtils.getClientRoleEnum(role: json["clientRole"] as? String ?? "")
        self.channelProfile = EnumUtils.getChannelProfileEnum(channel: json["channelProfile"] as? String ?? "")
        self.extra = json["extra"] as? Dictionary<String,Any> ?? [String : Any]()
        self.notificationDuration = (json["notificationDuration"] as? Int) ?? 30
    }
    
    func toMap() -> Dictionary<String,Any>{
        return [
            "callerName" : self.callerName,
            "roomId" : self.roomId,
            "clientRole" : EnumUtils.getClientRoleString(role: self.clientRole),
            "channelProfile": EnumUtils.getChannelProfileString(channel: self.channelProfile),
            "extra" : self.extra,
            "notificationDuration" : self.notificationDuration
        ]
    }
}

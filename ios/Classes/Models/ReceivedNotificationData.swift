class ReceivedNotificationData {
    var buttonInputType: String = ""
    var notification : CallNotificationData
    
    init(json: Dictionary<String,Any>) {
        self.buttonInputType = json["buttonInputType"] as? String ?? ""
        self.notification = CallNotificationData.init(json: json["notification"] as! Dictionary<String,Any>)
    }
    
    func toMap() -> Dictionary<String,Any>{
        return [
            "buttonInputType" : self.buttonInputType,
            "notification": self.notification.toMap()
        ]
    }
}

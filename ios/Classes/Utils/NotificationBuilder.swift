class NotificationBuilder {
    static func buildLaunchNotificationAction(notificationData : Dictionary<String,Any>) -> ReceivedNotificationData{
        var returnObjects = [String : Any]()
        returnObjects["buttonInputType"] = "launch"
        returnObjects["notification"] = notificationData
        return ReceivedNotificationData.init(json: returnObjects)
    }
}

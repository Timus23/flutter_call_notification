package com.timus.call_notification.models

class ReceivedNotificationData(arguments: Map<String, Any>) {
    val buttonInputType : String = arguments["buttonInputType"] as String;
    val notification: NotificationData = NotificationData(arguments["notification"] as HashMap<String,Any>);

    fun toMap(): Map<String, Any> {
        var returnedObject: HashMap<String, Any> = HashMap<String, Any> ()
        returnedObject["buttonInputType"] = this.buttonInputType;
        returnedObject["notification"] = this.notification.toMap();
        return returnedObject;
    }
}
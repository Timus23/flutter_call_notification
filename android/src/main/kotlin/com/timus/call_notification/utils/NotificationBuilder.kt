package com.timus.call_notification.utils

import android.content.Context
import android.content.Intent
import com.timus.call_notification.NotificationButtonActions
import com.timus.call_notification.models.ReceivedNotificationData

class NotificationBuilder {
    companion object{
        fun buildNotificationActionFromIntent(context: Context, intent: Intent): ReceivedNotificationData? {
            val actionKey = intent.action ?: return null
            val tempValue: HashMap<String, Any> = HashMap<String, Any>();
            when (actionKey) {
                NotificationButtonActions.acceptAction -> {
                    tempValue["buttonInputType"] = "accept";
                }
                NotificationButtonActions.rejectAction -> {
                    tempValue["buttonInputType"] = "reject";
                } NotificationButtonActions.launchAction -> {
                tempValue["buttonInputType"] = "launch";
            } else -> {
                tempValue["buttonInputType"] = "";
            }
            }
            tempValue["notification"] = intent.getSerializableExtra("notification") as HashMap<String,Any>;
            return ReceivedNotificationData(tempValue);
        }
    }
}
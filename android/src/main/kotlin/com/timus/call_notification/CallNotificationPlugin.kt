package com.timus.call_notification

import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import com.timus.call_notification.enums.NotificationLifeCycle

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** CallNotificationPlugin */
class CallNotificationPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  lateinit var applicationContext : Context;
  private lateinit var foregroundIntent : Intent;

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "call_notification")
    channel.setMethodCallHandler(this)
    applicationContext = flutterPluginBinding.applicationContext;
//    foregroundIntent = Intent(applicationContext,CallService::class.java)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
        "showNotification" -> {
          val message: HashMap<String, Any> = call.arguments()
            val returnObject: HashMap<String, Any> = HashMap<String,Any>();
            returnObject["notification"] = message;
            returnObject["buttonInputType"] = "accept";
            channel.invokeMethod(CallNotificationChannel.ReceivedAction, returnObject)
          result.success(true)
        }
        "cancelCallNotification" -> {
          cancelCallNotification()
          result.success(true)
        }
        else -> {
          result.notImplemented()
        }
    }
  }

  private fun receiveNotificationAction(intent: Intent, appLifeCycle: NotificationLifeCycle): Boolean {
//    val actionModel: ReceivedNotificationData? = NotificationBuilder.buildNotificationActionFromIntent(applicationContext, intent)
//
//    if (actionModel != null) {
//      val returnObject: Map<String, Any> = actionModel.toMap()
//      if(intent.action == NotificationButtonActions.rejectAction || intent.action == NotificationButtonActions.acceptAction){
//        cancelCallNotification()
//      }
      val returnObject: HashMap<String, Any> = HashMap<String,Any>();
      channel.invokeMethod(CallNotificationChannel.ReceivedAction, returnObject)
//    }
    return true
  }

  private fun cancelCallNotification(){
    applicationContext.stopService(foregroundIntent)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

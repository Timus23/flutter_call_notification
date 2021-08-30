package com.timus.call_notification

import android.app.*
import android.content.Context
import android.content.Intent
import android.graphics.drawable.Drawable
import android.media.Ringtone
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build
import android.os.IBinder
import android.os.Vibrator
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.timus.call_notification.models.NotificationData


class CallService : Service() {
    lateinit var notificationManagerCompat: NotificationManagerCompat
    private val ChannelId = "PersonalNotification"
    lateinit var ringTone : Ringtone;
    lateinit var vibrator: Vibrator;

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val tempData : HashMap<String,Any> = intent?.getSerializableExtra("notificationData") as HashMap<String,Any>;
        playRingtone();
        vibratePhone();
        displayNotifications(NotificationData(tempData))
        return super.onStartCommand(intent, flags, startId)
    }

    override fun onDestroy() {
        ringTone.stop();
        vibrator.cancel()
        stopForeground(true)
        super.onDestroy()
    }

    private fun vibratePhone(){
        vibrator = getSystemService(Context.VIBRATOR_SERVICE) as Vibrator;
        val vibrationPattern = longArrayOf(0, 100, 200, 300);
        vibrator.vibrate(vibrationPattern,0);
    }

    private fun playRingtone(){
        val ringTonePath: Uri = Uri.parse("android.resource://" + applicationContext.packageName + "/" + R.raw.ring_tone);
        RingtoneManager.setActualDefaultRingtoneUri(
                applicationContext, RingtoneManager.TYPE_RINGTONE,ringTonePath);
        ringTone = RingtoneManager.getRingtone(applicationContext,ringTonePath)

        ringTone.play();
    }

    private fun displayNotifications(notificationData: NotificationData) {
        notificationManagerCompat = NotificationManagerCompat.from(applicationContext)
        val launchIntent: Intent = getLaunchIntent(applicationContext)
        launchIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        launchIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        launchIntent.action = NotificationButtonActions.launchAction;
        launchIntent.putExtra("notification",notificationData.toMap() as HashMap<String,Any>)
        val acceptIntent: Intent = getLaunchIntent(applicationContext)
        acceptIntent.action = NotificationButtonActions.acceptAction;
        acceptIntent.putExtra("notification",notificationData.toMap() as HashMap<String,Any>)
        val rejectIntent: Intent = getLaunchIntent(applicationContext)
        rejectIntent.action = NotificationButtonActions.rejectAction;
        rejectIntent.putExtra("notification",notificationData.toMap() as HashMap<String,Any>)
        val launchPendingIntent = PendingIntent.getActivity(applicationContext, 1, launchIntent, PendingIntent.FLAG_UPDATE_CURRENT)
        createNotificationChannel(notificationData)
        var receiveIntent: PendingIntent = PendingIntent.getActivity(applicationContext, 0,acceptIntent, PendingIntent.FLAG_UPDATE_CURRENT)
        var declineIntent: PendingIntent = PendingIntent.getActivity(applicationContext, 1,rejectIntent, PendingIntent.FLAG_UPDATE_CURRENT)
        val builder: NotificationCompat.Builder = NotificationCompat.Builder(applicationContext, ChannelId)
        builder.setSmallIcon(applicationContext.applicationInfo.icon)
        builder.setContentText(notificationData.description)
        builder.setContentTitle(notificationData.callerName)
//        builder.setFullScreenIntent(launchPendingIntent,true)
        builder.setOnlyAlertOnce(false)
        builder.priority = NotificationCompat.PRIORITY_HIGH
        builder.addAction(R.drawable.call_accept, "Answer", receiveIntent)
        builder.addAction(R.drawable.call_end, "Decline", declineIntent)
        val notification: Notification = builder.build()
        notification.flags = Notification.FLAG_INSISTENT;
        startForeground(1,notification)
    }

    private fun createNotificationChannel(notificationData: NotificationData) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val importance: Int = NotificationManager.IMPORTANCE_HIGH
            val channel = NotificationChannel(ChannelId, notificationData.callerName, importance)
            channel.description = notificationData.description
            channel.setSound(null,null);
//            val alarmSound: Uri = Uri.parse("android.resource://" + applicationContext.packageName + "/" + R.raw.ring_tone);
//            val attributes : AudioAttributes = AudioAttributes.Builder()
//                    .setUsage(AudioAttributes.USAGE_NOTIFICATION)
//                    .build()
//            channel.setSound(alarmSound,attributes)
            notificationManagerCompat.createNotificationChannel(channel)
        }
    }

    private fun getLaunchIntent(context: Context): Intent {
        val packageName = context.packageName
        val packageManager = context.packageManager
        return packageManager.getLaunchIntentForPackage(packageName)!!
    }
}
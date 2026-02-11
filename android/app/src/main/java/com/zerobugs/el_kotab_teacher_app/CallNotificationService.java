package com.zerobugs.el_kotab_teacher_app;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.IBinder;
import android.util.Log;
import androidx.core.app.NotificationCompat;

public class CallNotificationService extends Service {
    private static final String TAG = "CallNotificationService";
    private static final String CHANNEL_ID = "zego_call_channel";
    private static final String CHANNEL_NAME = "Zego Calls";
    
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
    
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.d(TAG, "🔔 CallNotificationService started");
        
        if (intent != null && intent.getAction() != null) {
            String action = intent.getAction();
            Log.d(TAG, "🎯 Action received: " + action);
            
            if ("STOP_RINGING".equals(action)) {
                stopRinging();
            }
        }
        
        return START_NOT_STICKY;
    }
    
    public void showIncomingCallNotification(String callerName, String callId) {
        Log.d(TAG, "📞 Showing incoming call notification from: " + callerName);
        
        // Create intent for answering the call
        Intent answerIntent = new Intent(this, MainActivity.class);
        answerIntent.setAction("ANSWER_CALL");
        answerIntent.putExtra("call_notification", true);
        answerIntent.putExtra("caller_name", callerName);
        answerIntent.putExtra("call_id", callId);
        answerIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        
        PendingIntent answerPendingIntent = PendingIntent.getActivity(
            this, 
            0, 
            answerIntent, 
            PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE
        );
        
        // Create intent for rejecting the call
        Intent rejectIntent = new Intent(this, CallNotificationService.class);
        rejectIntent.setAction("STOP_RINGING");
        
        PendingIntent rejectPendingIntent = PendingIntent.getService(
            this, 
            1, 
            rejectIntent, 
            PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE
        );
        
        // Create notification channel
        createNotificationChannel();
        
        // Build notification
        NotificationCompat.Builder builder = new NotificationCompat.Builder(this, CHANNEL_ID)
                .setSmallIcon(android.R.drawable.ic_dialog_email)
                .setContentTitle("📞 Incoming Call")
                .setContentText("Call from " + callerName)
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setCategory(NotificationCompat.CATEGORY_CALL)
                .setAutoCancel(false)
                .setOngoing(true)
                .addAction(android.R.drawable.ic_menu_call, "Answer", answerPendingIntent)
                .addAction(android.R.drawable.ic_delete, "Reject", rejectPendingIntent)
                .setFullScreenIntent(answerPendingIntent, true);
        
        // Show notification
        NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.notify(1001, builder.build());
        
        Log.d(TAG, "✅ Call notification displayed");
    }
    
    public void stopRinging() {
        Log.d(TAG, "🔕 Stopping call ringing");
        NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.cancel(1001);
        
        // Stop the service
        stopSelf();
    }
    
    private void createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel(
                CHANNEL_ID,
                CHANNEL_NAME,
                NotificationManager.IMPORTANCE_HIGH
            );
            channel.setDescription("Incoming call notifications");
            channel.enableVibration(true);
            channel.enableLights(true);
            
            NotificationManager notificationManager = getSystemService(NotificationManager.class);
            notificationManager.createNotificationChannel(channel);
        }
    }
}

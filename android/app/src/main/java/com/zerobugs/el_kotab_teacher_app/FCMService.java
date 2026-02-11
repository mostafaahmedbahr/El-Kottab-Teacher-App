package com.zerobugs.el_kotab_teacher_app;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import androidx.core.app.NotificationCompat;
import androidx.core.app.NotificationManagerCompat;
import io.flutter.embedding.android.FlutterActivity;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

public class FCMService extends FirebaseMessagingService {
    private static final String TAG = "FCMService";
    private static final String CHANNEL_ID = "zego_call_channel";

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        Log.d(TAG, "📩 FCM Message received: " + remoteMessage.getData());
        
        // Check if this is a Zego call
        Bundle data = new Bundle();
        for (String key : remoteMessage.getData().keySet()) {
            data.putString(key, remoteMessage.getData().get(key));
        }
        
        // Handle Zego call notifications
        if (isZegoCall(remoteMessage)) {
            Log.d(TAG, "📞 Zego call detected, // Show persistent call notification");
            String callerName = remoteMessage.getData().get("callerName");
            String callId = remoteMessage.getData().get("callID");
            showCallNotification(callerName, callId);
            
            // Start call notification service for persistent ringing
            startCallNotificationService(callerName, callId);
            startCallActivity();
        }
    }

    @Override
    public void onNewToken(String token) {
        Log.d(TAG, "🔔 FCM Token refreshed: " + token);
        // You might want to send this to your Flutter app
    }

    private boolean isZegoCall(RemoteMessage message) {
        // Check if message contains Zego call data
        return message.getData().containsKey("callID") || 
               message.getData().containsKey("invitationID") ||
               message.getData().containsKey("zego");
    }

    private void showCallNotification(String callerName, String callId) {
        try {
            NotificationCompat.Builder builder = new NotificationCompat.Builder(this, CHANNEL_ID)
                    .setSmallIcon(android.R.drawable.ic_dialog_email)
                    .setContentTitle("📞 Incoming Call")
                    .setContentText("Call from " + (callerName != null ? callerName : "Unknown"))
                    .setPriority(NotificationCompat.PRIORITY_HIGH)
                    .setAutoCancel(true)
                    .setFullScreenIntent(createCallIntent(), true);

            NotificationManagerCompat notificationManager = NotificationManagerCompat.from(this);
            notificationManager.notify(1, builder.build());
        } catch (Exception e) {
            Log.e(TAG, "Error showing notification: " + e.getMessage());
        }
    }
    
    private void startCallNotificationService(String callerName, String callId) {
        try {
            Intent serviceIntent = new Intent(this, CallNotificationService.class);
            serviceIntent.putExtra("caller_name", callerName);
            serviceIntent.putExtra("call_id", callId);
            startService(serviceIntent);
            Log.d(TAG, "✅ Call notification service started");
        } catch (Exception e) {
            Log.e(TAG, "Error starting call notification service: " + e.getMessage());
        }
    }

    private void startCallActivity() {
        try {
            Intent intent = new Intent(this, MainActivity.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            intent.addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);
            intent.putExtra("call_notification", true);
            
            startActivity(intent);
            Log.d(TAG, "✅ Call activity started");
        } catch (Exception e) {
            Log.e(TAG, "Error starting activity: " + e.getMessage());
        }
    }

    private android.app.PendingIntent createCallIntent() {
        Intent intent = new Intent(this, MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        intent.putExtra("call_notification", true);
        
        return android.app.PendingIntent.getActivity(
                this, 
                0, 
                intent, 
                android.app.PendingIntent.FLAG_UPDATE_CURRENT | android.app.PendingIntent.FLAG_IMMUTABLE
        );
    }
}

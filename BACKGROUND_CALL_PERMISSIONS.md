# Background Call Permissions Guide

## Problem: Calls don't appear when app is closed/in background

## 🔍 Required Permissions:

### Android (android/app/src/main/AndroidManifest.xml)
```xml
<!-- Essential for background calls -->
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.DISABLE_KEYGUARD" />

<!-- For call notifications -->
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
<uses-permission android:name="android.permission.USE_FULL_SCREEN_INTENT" />

<!-- Audio permissions -->
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.CAMERA" />
```

### iOS (ios/Runner/Info.plist)
```xml
<key>UIBackgroundModes</key>
<array>
    <string>audio</string>
    <string>voip</string>
    <string>background-fetch</string>
    <string>remote-notification</string>
</array>

<key>NSMicrophoneUsageDescription</key>
<string>This app needs microphone access for calls</string>

<key>NSCameraUsageDescription</key>
<string>This app needs camera access for video calls</string>
```

## 🛠️ Additional Configuration:

### 1. Firebase Service Worker
Create `android/app/src/main/java/com/yourapp/FCMService.java`:
```java
public class FCMService extends FirebaseMessagingService {
    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        // Handle Zego call notifications when app is in background
        if (remoteMessage.getData().containsKey("zego_call")) {
            // Start call activity
            Intent intent = new Intent(this, MainActivity.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);
        }
    }
}
```

### 2. Background Service (Android)
```xml
<service
    android:name=".FCMService"
    android:exported="false">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT" />
    </intent-filter>
</service>
```

### 3. Runtime Permissions (Flutter)
Add to your main.dart:
```dart
import 'package:permission_handler/permission_handler.dart';

// Request permissions at startup
Future<void> _requestPermissions() async {
  await [
    Permission.microphone,
    Permission.camera,
    Permission.notification,
    Permission.systemAlertWindow,
  ].request();
}
```

## 🔧 Zego Cloud Configuration:

1. **Enable Push Notifications** in Zego Dashboard
2. **Upload FCM Server Key** to Zego
3. **Configure APNS** for iOS
4. **Set resourceID** to "zego_push"

## 📱 Testing Steps:

1. **Close app completely** (swipe from recent apps)
2. **Make call from student app**
3. **Check if call appears** with notification
4. **Verify app launches** when call is accepted

## ⚠️ Common Issues:

1. **Missing WAKE_LOCK**: App won't wake up for calls
2. **Missing SYSTEM_ALERT_WINDOW**: Call UI won't show over other apps
3. **Missing POST_NOTIFICATIONS**: No notification when app is closed
4. **Missing background modes**: iOS kills the app immediately

## 🎯 Quick Fix:

Add these permissions to AndroidManifest.xml FIRST:
```xml
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
```

This should solve most background call issues!

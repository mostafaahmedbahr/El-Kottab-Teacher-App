# Call Receiving Troubleshooting Guide

## Problem: Teacher App Not Receiving Calls from Student App

### ✅ What I've Fixed:
1. **Added Debug Logging**: Added comprehensive logging to track initialization and incoming calls
2. **Fixed Zego Service**: Uncommented and properly configured push notification handling
3. **Enhanced Error Tracking**: Added logs for user data and FCM token retrieval

### 🔍 Steps to Debug:

#### 1. Check Console Logs
Run the app and check these logs:
```
🔔 Zego Init Data:
   UserID: [should show user ID]
   UserName: [should show user name]  
   FCM Token: [should show FCM token]
🔔 ZegoService Init - UserID: [user ID], UserName: [user name], FCM: [FCM token]
✅ ZegoService initialized successfully
```

#### 2. Verify Required Data:
Make sure these are NOT empty/null:
- **User ID**: Should be a valid integer
- **User Name**: Should be a valid string
- **FCM Token**: Should be a long string (like: `fcm_token_here...`)

#### 3. Check Environment Variables:
Ensure `.env` file contains:
```
ZEGO_APP_ID=your_app_id
ZEGO_APP_SIGN=your_app_sign
```

#### 4. Firebase Configuration:
- FCM token should be generated (check logs)
- App should have notification permissions
- Firebase project should be properly configured

#### 5. Zego Cloud Configuration:
- Make sure FCM server key is configured in Zego dashboard
- Verify app ID and sign are correct
- Check if push notifications are enabled for your app

### 🛠️ Common Issues & Solutions:

#### Issue 1: Empty User Data
**Problem**: UserID, UserName, or FCM token are empty
**Solution**: 
- Check if user is properly logged in
- Verify cache is working correctly
- Ensure Firebase is initialized before getting FCM token

#### Issue 2: FCM Token Not Generated
**Problem**: No FCM token in logs
**Solution**:
- Check internet connection
- Verify Firebase configuration
- Ensure app has proper permissions

#### Issue 3: Zego Configuration Issues
**Problem**: Zego service fails to initialize
**Solution**:
- Verify ZEGO_APP_ID and ZEGO_APP_SIGN in .env
- Check if Zego cloud credentials are correct
- Ensure app is registered in Zego dashboard

#### Issue 4: Push Notification Not Working
**Problem**: App receives calls only when open
**Solution**:
- Check FCM server key in Zego dashboard
- Verify app permissions (background, notifications)
- Test with different devices

### 📱 Testing Steps:

1. **Install both apps** (student and teacher)
2. **Login as teacher** first
3. **Check console logs** for initialization
4. **Login as student** on another device
5. **Make a call** from student to teacher
6. **Monitor logs** for incoming call data

### 🔧 Additional Debugging:

If still not working, add these logs to track Firebase messages:

```dart
// In main.dart _initFirebaseMessaging()
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  log('📩 Foreground message received: ${message.data}');
  log('📩 Message from: ${message.from}');
});

FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  log('📲 Notification clicked: ${message.data}');
});
```

### 📋 Required Permissions:

#### Android:
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
```

#### iOS:
- Microphone permission
- Camera permission  
- Push notifications
- Background app refresh

### 🎯 Next Steps:

1. **Run the app** and check console logs
2. **Verify all data** is populated correctly
3. **Test call functionality** with student app
4. **Check Zego dashboard** for push configuration
5. **Ensure FCM server key** is properly set in Zego cloud

If you follow these steps and still face issues, the problem might be:
- Incorrect Zego cloud configuration
- FCM server key not properly set
- Network/firewall issues
- App permissions not granted

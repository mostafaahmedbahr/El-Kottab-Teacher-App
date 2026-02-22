# 📞 نظام إشعارات المكالمات - الشرح الكامل

## 🎯 **إزاي يحصل لما التطبيق مقفول؟**

### **الخطوات بالترتيب:**

1. **📩 وصول FCM Message** 
   - Student يبعت مكالمة
   - Firebase يبعت رسالة للـ FCMService

2. **🔍 FCMService يستقبل الرسالة**
   ```java
   @Override
   public void onMessageReceived(RemoteMessage remoteMessage) {
       if (isZegoCall(remoteMessage)) {
           showCallNotification(callerName, callId);
           startCallNotificationService(callerName, callId);
           startCallActivity();
       }
   }
   ```

3. **📱 إشعار أولي يظهر**
   ```java
   NotificationCompat.Builder builder = new NotificationCompat.Builder(this, CHANNEL_ID)
       .setSmallIcon(android.R.drawable.ic_dialog_email)
       .setContentTitle("📞 Incoming Call")
       .setContentText("Call from " + callerName)
       .setPriority(NotificationCompat.PRIORITY_HIGH)
       .setFullScreenIntent(createCallIntent(), true);
   ```

4. **🔄 CallNotificationService يبدأ**
   - Service بيشتغل في الخلفية
   - بيظهر إشعار مستمر مع "رد" و "رفض"
   - بيستمر في الرنين لحد ما المستخدم يرد

5. **📱 MainActivity يفتح**
   ```java
   Intent intent = new Intent(this, MainActivity.class);
   intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
   intent.putExtra("call_notification", true);
   startActivity(intent);
   ```

6. **🎯 Flutter يستقبل الـ Intent**
   ```dart
   @override
   void onNewIntent(Intent intent) {
       if (intent.getAction() == "ANSWER_CALL" || 
           intent.getBooleanExtra("call_notification", false)) {
           // Forward to Zego call UI
           methodChannel.invokeMethod("onCallReceived", callData);
       }
   }
   ```

7. **📞 شاشة المكالمة تظهر**
   - ZegoUIKitPrebuiltCallInvitationService().enterAcceptedOfflineCall();
   - شاشة المكالمة بتظهر عادي

## ✅ **إزاي هي النتيجة؟**

### **لو كل حاجة شغالة صح:**
1. **📩 FCM Message** ← يوصل للـ FCMService
2. **📱 إشعار** ← يظهر على شاشة الموبايل  
3. **🔔 Service** ← بيشتغل في الخلفية ويستمر في الرنين
4. **📱 App يفتح** ← لما المستخدم يضغط "رد"
5. **📞 Zego UI** ← شاشة المكالمة بتظهر

### **المشاكل الممكنة:**

#### **❌ لو FCM مش شغال:**
- ما فيش إشعارات بتوصل أصلاً
- Firebase مش متصل صح

#### **❌ لو SYSTEM_ALERT_WINDOW permission مش موجود:**
- الإشعارات مش بتظهر
- Service مش بيقدر يشتغل

#### **❌ لو MainActivity مش بتعامل مع الـ Intent:**
- التطبيق بيفتح لكن مش بيفتح على شاشة المكالمة
- onNewIntent مش شغال

#### **❌ لو Zego initialization مش صحيح:**
- Service بيشتغل لكن Zego مش مجهز
- ما فيش FCM Token أو userID

## 🧪 **إزاي تختبر:**

### **1. اختبر FCM:**
```bash
adb shell am broadcast -a com.google.firebase.MESSAGING_EVENT \
  --es callID "12345" \
  --es callerName "Test Student"
```

### **2. اختبر الإشعارات:**
- شوف هل الإشعار بتظهر في status bar
- اختبر الضغط على الإشعار

### **3. اختبر الـ Service:**
```bash
adb shell dumpsys activity services | grep "CallNotificationService"
```

### **4. اختبر Zego:**
- Logcat: `ZegoService`, `ZegoUIKit`
- شوف هل initialization ناجح

## 🎉 **الوضع المثالي:**

**لما التطبيق مقفول والمكالمة جاية:**

1. **📩 FCM يوصل** ← Firebase شغال
2. **📱 إشعار يظهر** ← NotificationManager شغال  
3. **🔔 Service شغال** ← CallNotificationService بيشتغل
4. **📱 App يفتح** ← MainActivity بيستقبل الـ intent
5. **📞 Zego UI يظهر** ← Flutter يفتح شاشة المكالمة

**كل حاجة في السلسلة دي لازم تشغل صح عشان المكالمات توصل لما التطبيق مقفول!** 🎯📞✨

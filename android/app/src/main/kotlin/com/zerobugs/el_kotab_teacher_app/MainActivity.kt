package com.zerobugs.el_kotab_teacher_app

import android.content.Intent
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    
    private val TAG = "MainActivity"
    
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Handle call intent when app launches from notification
        intent?.let { handleCallIntent(it) }
    }
    
    override fun onCreate(savedInstanceState: android.os.Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d(TAG, "🚀 MainActivity onCreate")
        
        // Handle call intent when app launches from background
        intent?.let { handleCallIntent(it) }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        Log.d(TAG, "🔄 MainActivity onNewIntent")
        
        // Handle call intent when app is already running
        handleCallIntent(intent)
    }

    private fun handleCallIntent(intent: Intent?) {
        intent?.let {
            Log.d(TAG, "📱 Handling intent: ${it.action}")
            Log.d(TAG, "📱 Intent extras: ${it.extras}")
            
            if (it.action == "ANSWER_CALL" || it.getBooleanExtra("call_notification", false)) {
                Log.d(TAG, "📞 CALL INTENT DETECTED - Processing Zego call")
                
                // Get call details
                val callerName = it.getStringExtra("caller_name") ?: "Unknown"
                val callId = it.getStringExtra("call_id") ?: ""
                
                Log.d(TAG, "📞 Call details - Caller: $callerName, CallID: $callId")
                
                // Stop the call notification service
                stopCallNotificationService()
                
                // Forward call data to Flutter
                val flutterEngine = flutterEngine ?: return
                val methodChannel = io.flutter.plugin.common.MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "calls")
                
                val callData = mapOf(
                    "action" to "answer_call",
                    "caller_name" to callerName,
                    "call_id" to callId
                )
                
                methodChannel.invokeMethod("onCallReceived", callData)
                Log.d(TAG, "✅ Call data sent to Flutter")
            }
        }
    }
    
    private fun stopCallNotificationService() {
        try {
            val serviceIntent = Intent(this, CallNotificationService::class.java)
            serviceIntent.action = "STOP_RINGING"
            startService(serviceIntent)
            Log.d(TAG, "🔕 Call notification service stopped")
        } catch (e: Exception) {
            Log.e(TAG, "Error stopping call notification service: ${e.message}")
        }
    }
}

package com.zerobugs.el_kotab_teacher

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

import im.zego.zegoexpress.ZegoExpressEngine
import im.zego.zim.ZIM

class MainActivity : FlutterActivity() {

    private val TAG = "MainActivity"
    private val REQUEST_CODE = 100

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Handle call intent when app launches from notification
        intent?.let { handleCallIntent(it) }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d(TAG, "🚀 MainActivity onCreate")

        // Handle call intent when app launches from background
        intent?.let { handleCallIntent(it) }

        // In pages where audio and video need to be kept active, start foreground services.
        startForegroundNotificationService()
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        Log.d(TAG, "🔄 MainActivity onNewIntent")

        // Handle call intent when app is already running
        handleCallIntent(intent)
    }

    // start foreground services.
    private fun startForegroundNotificationService() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.RECORD_AUDIO), REQUEST_CODE)
        } else {
            // Permission obtained, start foreground service
            startService(Intent(this, ForegroundService::class.java))
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == REQUEST_CODE) {
            if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                // Permission obtained, start foreground service
                startService(Intent(this, ForegroundService::class.java))
            } else {
                Toast.makeText(this, "audio permission had rejected", Toast.LENGTH_SHORT).show()
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()

        ZegoExpressEngine.destroyEngine {}

        ///  if you added zego_uikit_signaling_plugin
        var zim = ZIM.getInstance()
        if (zim != null) {
            zim.destroy()
        }

        // when no longer needed, end the foreground service.
        //  stopService(Intent(this, ForegroundService::class.java))
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
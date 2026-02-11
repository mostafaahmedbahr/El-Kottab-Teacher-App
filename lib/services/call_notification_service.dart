import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallNotificationService {
  static const MethodChannel _channel = MethodChannel('calls');
  static final CallNotificationService _instance = CallNotificationService._internal();
  factory CallNotificationService() => _instance;
  CallNotificationService._internal();

  void initialize() {
    debugPrint('🔔 Initializing Call Notification Service');
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    debugPrint('📱 Method received: ${call.method}');
    
    switch (call.method) {
      case 'onCallReceived':
        await _handleCallReceived(call.arguments);
        break;
      default:
        debugPrint('❌ Unknown method: ${call.method}');
    }
  }

  Future<void> _handleCallReceived(dynamic arguments) async {
    try {
      if (arguments is Map) {
        final action = arguments['action'] as String?;
        final callerName = arguments['caller_name'] as String? ?? 'Unknown';
        final callId = arguments['call_id'] as String? ?? '';
        
        debugPrint('📞 Call received - Action: $action, Caller: $callerName, CallID: $callId');
        
        if (action == 'answer_call') {
          debugPrint('📞 Answering call from $callerName');
          
          // Enter the accepted offline call to show Zego call UI
          ZegoUIKitPrebuiltCallInvitationService().enterAcceptedOfflineCall();
          
          // Show a snackbar to indicate call is being answered
          _showCallAnsweredNotification(callerName);
        }
      }
    } catch (e) {
      debugPrint('❌ Error handling call received: $e');
    }
  }

  void _showCallAnsweredNotification(String callerName) {
    debugPrint('🔔 Showing call answered notification for $callerName');
    
    // You can show a local notification or snackbar here
    // For now, we'll just log it since Zego handles the UI
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // You could show a snackbar if you have a context
      debugPrint('📞 Call from $callerName answered!');
    });
  }
}

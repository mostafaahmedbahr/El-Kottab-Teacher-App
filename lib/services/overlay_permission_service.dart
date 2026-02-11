import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class OverlayPermissionService {
  static final OverlayPermissionService _instance =
      OverlayPermissionService._internal();
  factory OverlayPermissionService() => _instance;
  OverlayPermissionService._internal();

  Future<bool> checkOverlayPermission() async {
    return await Permission.systemAlertWindow.isGranted;
  }

  Future<void> requestOverlayPermission(BuildContext context) async {
    try {
      final status = await Permission.systemAlertWindow.request();

      if (status.isGranted) {
        debugPrint('✅ Overlay permission granted');
        _showSuccessDialog(context);
      } else if (status.isDenied) {
        debugPrint('❌ Overlay permission denied');
        _showPermissionDialog(context);
      } else if (status.isPermanentlyDenied) {
        debugPrint('❌ Overlay permission permanently denied');
        _showSettingsDialog(context);
      }
    } catch (e) {
      debugPrint('❌ Error requesting overlay permission: $e');
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('✅ Permission Granted'),
        content: const Text(
          'Overlay permission is now enabled. You will receive call notifications even when the app is closed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🔔 Overlay Permission Required'),
        content: const Text(
          'This app needs "Display over other apps" permission to show incoming call notifications when the app is closed.\n\n'
          'Without this permission, you won\'t see call notifications when the app is in background.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              requestOverlayPermission(context);
            },
            child: const Text('Grant Permission'),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('⚙️ Enable Permission Manually'),
        content: const Text(
          'Overlay permission was permanently denied. Please enable it manually:\n\n'
          '1. Go to App Settings\n'
          '2. Find "Permissions"\n'
          '3. Enable "Display over other apps"\n\n'
          'This is required for call notifications to work when the app is closed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}

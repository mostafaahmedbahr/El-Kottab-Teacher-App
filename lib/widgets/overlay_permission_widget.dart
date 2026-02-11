import 'package:flutter/material.dart';
import '../services/overlay_permission_service.dart';

class OverlayPermissionWidget extends StatelessWidget {
  final Widget child;

  const OverlayPermissionWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: OverlayPermissionService().checkOverlayPermission(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return child; // Show child while checking
        }

        final hasPermission = snapshot.data ?? false;
        
        if (!hasPermission) {
          return Stack(
            children: [
              child, // Your app content
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red.withOpacity(0.9),
                  child: Row(
                    children: [
                      const Icon(Icons.warning, color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(
                        child: const Text(
                          '⚠️ Call notifications disabled. Enable "Display over other apps" permission.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          OverlayPermissionService().requestOverlayPermission(context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red,
                        ),
                        child: const Text('Enable'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        return child; // Permission granted, show normal content
      },
    );
  }
}

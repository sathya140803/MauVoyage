import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'authentications.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogoutPressed;
  final AuthService authService = AuthService();  // Instance of AuthService

  // Remove the 'const' keyword here
  LogoutDialog({
    super.key,
    required this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Log Out?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Are you sure you want to log out from your account?',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey.shade600,
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.pop(context);
            await authService.logout(); // Call logout from AuthService
            onLogoutPressed(); // Run the logout action provided from the parent
            SystemNavigator.pop(); // Exit the app after logout
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.logout, color: Colors.white, size: 16),
              SizedBox(width: 8),
              Text('Ok'),
            ],
          ),
        ),
      ],
    );
  }
}

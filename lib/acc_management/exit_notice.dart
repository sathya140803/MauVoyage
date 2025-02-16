import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemNavigator

class ExitDialog extends StatelessWidget {
  final VoidCallback onExitPressed;

  const ExitDialog({
    super.key,
    required this.onExitPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Exit App?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Are you sure you want to exit the app?',
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
          onPressed: () {
            Navigator.pop(context); // Close the dialog

            SystemNavigator.pop(); // Exit the app
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
              Icon(Icons.exit_to_app, color: Colors.white, size: 16),
              SizedBox(width: 8),
              Text('Exit'),
            ],
          ),
        ),
      ],
    );
  }
}

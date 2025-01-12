
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About Our App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'This app helps users discover various points of interest around Mauritius. '
                  'With features such as booking activities, exploring restaurants, and finding maps for navigation, '
                  'it aims to make the travel experience seamless and enjoyable.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Contact Us:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Email: contact@ourapp.com',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'Phone: +230 1234 5678',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Action to contact or feedback
              },
              style: ElevatedButton.styleFrom(iconColor: Colors.blueAccent),
              child: const Text('Send Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}

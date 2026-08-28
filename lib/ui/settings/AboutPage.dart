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
        child: ListView(
          children: [
            // App Logo/Image
            Center(
              child: Image.asset(
                'assets/icon/logo.png', // Replace with your logo path
                width: 100,
                height: 100,
              ),
            ),
            // About Section
            Text(
              'About Our App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'This app helps users discover various points of interest around Mauritius. '
                      'With features such as scheduling activities, exploring restaurants, and finding maps for navigation, '
                      'it aims to make the travel experience seamless and enjoyable.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Developed by Level 2 students of Software Engineering 2025:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('• SEGOBIN Dhavishsingh', style: TextStyle(fontSize: 16)),
                    Text('• MOOTHOOSAWMY Sathya Prakash  ', style: TextStyle(fontSize: 16)),
                    Text('• UNORUTH Pragneshsing ', style: TextStyle(fontSize: 16)),
                    Text('• TELVAR Jean-Naël Jefferson ', style: TextStyle(fontSize: 16)),
                    Text('• BADAREE Pravish  ', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),

            Text(
              'Contact Us:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.blueAccent),
                        SizedBox(width: 8),
                        Text('Email: UomNerd69@gmail.com', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.blueAccent),
                        SizedBox(width: 8),
                        Text('Phone: +230 1234 5678', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class HealthAndWellnessPage extends StatelessWidget {
  List<HealthTip> healthTips = [
    HealthTip(
      title: "Stay Hydrated",
      description: "Drinking enough water is key to maintaining your health.",
      category: "Wellness Advice",
      imageUrl: "https://example.com/image.jpg",
    ),
    HealthTip(
      title: "Morning Stretch Routine",
      description: "A quick stretch routine to start your day.",
      category: "Exercise Routines",
      imageUrl: "https://example.com/stretch.jpg",
    ),
    HealthTip(
      title: "Local Health Services",
      description: "Find the nearest healthcare providers in your area.",
      category: "Local Health Services",
      imageUrl: "https://example.com/clinic.jpg",
    ),
    // Add more tips here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health & Wellness'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: healthTips.map((tip) {
            return Card(
              margin: EdgeInsets.only(bottom: 12.0),
              child: ListTile(
                leading: Image.network(tip.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                title: Text(tip.title),
                subtitle: Text(tip.description),
                onTap: () {
                  // Navigate to detailed page for more information
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HealthDetailPage(tip: tip)),
                  );
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class HealthDetailPage extends StatelessWidget {
  final HealthTip tip;

  HealthDetailPage({required this.tip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tip.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(tip.imageUrl),
            SizedBox(height: 12),
            Text(tip.description, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Category: ${tip.category}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            // You can add more details here, like links to related articles or services.
          ],
        ),
      ),
    );
  }
}

class HealthTip {
  final String title;
  final String description;
  final String category;
  final String imageUrl;

  HealthTip({required this.title, required this.description, required this.category, required this.imageUrl});
}

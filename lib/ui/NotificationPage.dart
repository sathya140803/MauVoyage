import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample notifications
    final List<Map<String, String>> notifications = [
      {
        "title": "New Destination Added!",
        "description": "Discover the beautiful Le Morne Brabant.",
        "time": "2 hours ago",
      },
      {
        "title": "Booking Reminder",
        "description": "Your booking for Scuba Diving is tomorrow.",
        "time": "1 day ago",
      },
      {
        "title": "Special Offer",
        "description": "50% off on Chamarel Seven Colored Earth tours!",
        "time": "3 days ago",
      },
      {
        "title": "Explore New Restaurants",
        "description": "Try the latest seafood specials at Ocean's Delight.",
        "time": "1 week ago",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
              title: Text(
                notification["title"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification["description"]!,
                    style: const TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    notification["time"]!,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              onTap: () {
                // Handle notification tap
                // For example: Navigate to the specific destination page
              },
            ),
          );
        },
      ),
    );
  }
}

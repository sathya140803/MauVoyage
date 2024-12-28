import 'package:flutter/material.dart';
import 'package:my_application/data_model/Activity.dart'; // Import the Activity model
import 'package:my_application/ui/DetailPage.dart'; // Import the DetailPage

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activities'),
        backgroundColor: Colors.orangeAccent, // Activity color theme
      ),
      body: ListView.builder(
        itemCount: Activity.activityList.length,  // Replace with your actual list of activities
        itemBuilder: (context, index) {
          final activity = Activity.activityList[index];
          return Card(
            child: ListTile(
              title: Text(activity.name),
              leading: Image.asset(activity.imageURL),
              onTap: () {
                // Navigate to the DetailPage and pass the selected activity item
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(item: activity),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

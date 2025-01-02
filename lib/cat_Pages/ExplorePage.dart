import 'package:flutter/material.dart';
import 'package:my_application/data_model/Beach.dart';
import 'package:my_application/data_model/Forest.dart';
import 'package:my_application/data_model/Activity.dart';
import 'package:my_application/data_model/NightClubEvent .dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final beaches = Beach.beachList; // List of beaches
    final forests = Forest.forestList; // List of forests
    final activities = Activity.activityList; // List of activities
    final nightClubEvents = NightClubEvent.nightClubList; // List of nightclub events

    Widget buildCategorySection(String title, List<dynamic> items) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Make text visible on a dark background
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Vertical Cards
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(), // Disable scrolling for ListView
              shrinkWrap: true, // Allows ListView to adjust to its content
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: Container(
                    height: 220, // Set height of the card
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(item.imageURL), // Item image background
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        children: [
                          // Dark overlay for readability
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow[700],
                                      size: 16,
                                    ),
                                    Text(
                                      item.rating.toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                // Conditionally render openingHours, entryFee, or duration
                                if (item is Beach || item is Forest)
                                  Text(
                                    item.openingHours,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                if (item is Activity)
                                  Text(
                                    "Duration: ${item.duration}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                if (item is NightClubEvent)
                                  Text(
                                    "Entry Fee: \$${item.entryFee}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Beach Section
              buildCategorySection("Beaches", beaches),

              // Forest Section
              buildCategorySection("Forests", forests),

              // Activity Section
              buildCategorySection("Activities", activities),

              // Nightclub Events Section
              buildCategorySection("Nightclub Events", nightClubEvents),
            ],
          ),
        ),
      ),
    );
  }
}

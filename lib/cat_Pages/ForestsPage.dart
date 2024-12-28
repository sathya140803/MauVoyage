import 'package:flutter/material.dart';
import 'package:my_application/data_model/Forest.dart'; // Import the Forest model
import 'package:my_application/ui/DetailPage.dart'; // Import the DetailPage

class ForestsPage extends StatelessWidget {
  const ForestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forests'),
        backgroundColor: Colors.greenAccent, // Forest color theme
      ),
      body: ListView.builder(
        itemCount: Forest.forestList.length,  // Replace with your actual list of forests
        itemBuilder: (context, index) {
          final forest = Forest.forestList[index];
          return Card(
            child: ListTile(
              title: Text(forest.name),
              leading: Image.asset(forest.imageURL),
              onTap: () {
                // Navigate to the DetailPage and pass the selected forest item
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(item: forest),
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

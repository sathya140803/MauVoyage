import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_application/ui/settings/font_provider.dart'; // Import the FontSizeProvider

class CategoryCarousel extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'title': 'Beaches', 'image': 'assets/cat3.jpg', 'route': '/beaches'},
    {'title': 'Forests', 'image': 'assets/cat2.jpg', 'route': '/forests'},
    {'title': 'Night Clubs', 'image': 'assets/cat1.jpg', 'route': '/nightclubs'},
    {'title': 'Activities', 'image': 'assets/cat4.jpg', 'route': '/activities'},
  ];

  CategoryCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width for dynamic font size
    double screenWidth = MediaQuery.of(context).size.width;
    // Get font size from FontSizeProvider
    double fontSize = Provider.of<FontSizeProvider>(context).fontSize;

    return SizedBox(
      height: 145, // Adjust height as per design
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, category['route']!);
              },
              child: Stack(
                alignment: Alignment.center, // Center the title
                children: [
                  // Icon/Image
                  Container(
                    width: 130, // Adjust the width here
                    height: 140, // Adjust the height here
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(category['image']!),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3), // Shadow color
                          offset: Offset(0, 4), // Shadow position
                          blurRadius: 8, // Shadow blur
                        ),
                      ],
                    ),
                  ),
                  // Title overlay
                  Container(
                    width: 130, // Match the width with the image container
                    height: 140, // Match the height with the image container
                    decoration: BoxDecoration(
                      color: Colors.black45, // Darken the image for better readability
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        category['title']!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize, // Use dynamic font size from provider
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
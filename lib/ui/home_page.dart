import 'package:flutter/material.dart';
import '../content/category_carousel.dart';
import 'package:my_application/data_model/PlaceOfInterest.dart';
import 'package:my_application/ui/DetailPage.dart';
import 'package:my_application/ui/NotificationPage.dart';
class HomePage extends StatelessWidget {
  final Function(PlaceOfInterest place) onFavoriteToggle; // Callback for managing favorites

  const HomePage({super.key, required this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    //List<PlaceOfInterest> placeList = PlaceOfInterest.placeList;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Section (Stack with background image, text, and search bar)
            Stack(
              children: [
                // Background Image
                Container(
                  height: screenHeight * 0.3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/top.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Text Overlay
                Positioned(
                  top: screenHeight * 0.05,
                  left: screenWidth * 0.05,
                  child: Text(
                    'Hi Dhavish',
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ],
                    ),
                  ),
                ),

                // Notification Icon
                Positioned(
                  top: screenHeight * 0.05,
                  right: screenWidth * 0.05,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Notification Icon Button
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const NotificationPage()),
                          );
                        },
                        icon: const Icon(Icons.notifications, color: Colors.blue),
                      ),

                      // Badge (Optional)
                      Positioned(
                        right: 4,
                        top: 4,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Center(
                            child: Text(
                              '3', // Dynamic notification count
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Search Bar
                Positioned(
                  top: screenHeight * 0.22,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  child: GestureDetector(
                    onTap: () {
                      // Add search functionality here
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const TextField(
                        enabled: false, // Disable the TextField to prevent direct input
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),


            // Text Section Below Image
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Featured Places',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Most trending places in Mauritius!',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            // Horizontal ListView of Places
            SizedBox(
              height: size.height * 0.3,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,  // Set the scroll direction to horizontal
                itemCount: PlaceOfInterest.placeList.length,  // Replace with your actual list of places
                itemBuilder: (context, index) {
                  final place = PlaceOfInterest.placeList[index];  // Use a different name for the variable
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the DetailPage and pass the selected place item
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(item: place),
                        ),
                      );
                    },
                    child: Container(
                      width: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.8),  // You can change the background color
                        borderRadius: BorderRadius.circular(20),
                      ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              // Background Image
                              Positioned.fill(
                                child: Image.asset(
                                  place.imageURL,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              // Heart Icon with Fade Black Circle Behind It
                              Positioned(
                                top: 10,
                                right: 10, // Align the heart icon to the top-right corner
                                child: Container(
                                  width: 40,  // Width of the circle
                                  height: 40, // Height of the circle
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4), // Semi-transparent black background
                                    shape: BoxShape.circle, // Make the container circular
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.favorite_border, // Outline heart icon
                                      color: Colors.white,   // White color for visibility
                                      size: 24,              // Adjust the size of the icon
                                    ),
                                    onPressed: () {
                                      // This is non-functional for now
                                      // You can add functionality later if needed
                                    },
                                  ),
                                ),
                              ),

                              // Overlay with Place Details
                              Positioned(
                                bottom: 10,
                                left: 10,
                                right: 10, // Ensures the overlay spans the width of the card
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4), // Semi-transparent black color
                                    borderRadius: BorderRadius.circular(10), // Add rounded corners
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10), // Padding for text
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start, // Align text and rating to the start
                                    children: [
                                      Text(
                                        place.name,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 5), // Space between name and rating
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow[700],
                                            size: 16,
                                          ),
                                          const SizedBox(width: 5), // Space between the star icon and rating
                                          Text(
                                            place.rating.toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )

                    ),
                  );
                },
              ),
            ),

            // Categories Section
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explore more',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'According to your personal taste',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            CategoryCarousel(),
          ],
        ),
      ),
    );
  }
}
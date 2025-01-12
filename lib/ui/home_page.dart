import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_application/data_model/PlaceOfInterest.dart';
import 'package:my_application/ui/NotificationPage.dart';
import 'package:my_application/content/SearchPage.dart';
import 'package:my_application/cat_Pages/ExplorePage.dart';
import 'package:my_application/ui/settings/theme_provider.dart'; // Import ThemeProvider
import '../content/category_carousel.dart'; // Import your CategoryCarousel
import 'package:my_application/ui/DetailPage.dart';


class HomePage extends StatelessWidget {
  final Function(PlaceOfInterest place) onFavoriteToggle;

  const HomePage({super.key, required this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;

    // Use the ThemeProvider to check if it's dark mode
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

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
                      color: isDarkMode ? Colors.black : Colors.white, // Adjust text color
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
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NotificationPage()),
                          );
                        },
                        icon: const Icon(Icons.notifications, color: Colors.blue),
                      ),
                      // Badge
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
                              '3',
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
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => SearchPage(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0); // Start from the bottom
                            const end = Offset.zero; // End at the top (original position)
                            const curve = Curves.easeInOut;

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(position: offsetAnimation, child: child);
                          },
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.white : Colors.white, // Adjust background color
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(
                            color: isDarkMode ? Colors.black54 : Colors.black54, // Adjust hint text color
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: isDarkMode ? Colors.black54 : Colors.black54, // Adjust icon color
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Text Section Below Image
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Discover Top Picks',
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black, // Adjust text color
                        ),
                      ),
                      Text(
                        'Experience the Best of Mauritius!',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? Colors.white70 : Colors.black54, // Adjust text color
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ExplorePage()),
                        );
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Horizontal ListView of Places
            SizedBox(
              height: size.height * 0.3,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: PlaceOfInterest.placeList.length,
                itemBuilder: (context, index) {
                  final place = PlaceOfInterest.placeList[index];
                  return GestureDetector(
                    onTap: () {
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
                        color: Colors.blue.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                place.imageURL,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // Heart Icon
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.favorite_border,
                                      color: Colors.white),
                                  onPressed: () {},
                                ),
                              ),
                            ),

                            // Overlay with Place Details
                            Positioned(
                              bottom: 10,
                              left: 10,
                              right: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      place.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: Colors.yellow[700],
                                            size: 16),
                                        const SizedBox(width: 5),
                                        Text(
                                          place.rating.toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Categories Section
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Explore more',
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black, // Adjust text color
                        ),
                      ),
                      Text(
                        'According to your personal taste',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? Colors.white70 : Colors.black54, // Adjust text color
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ExplorePage()),
                        );
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Category Carousel
            Padding(
              padding: const EdgeInsets.only(left: 7.0), // Adjust the value as needed
              child: CategoryCarousel(),
            ),
          ],
        ),
      ),
    );
  }
}

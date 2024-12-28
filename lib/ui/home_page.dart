// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
// import '../content/category_carousel.dart';
// import '../data_model/PlaceOfInterest.dart';
// import 'detail_page.dart';
// import 'dart:ui';
// import '../content/SearchScreen.dart';
// class HomePage extends StatelessWidget {
//   final Function(PlaceOfInterest place) onFavoriteToggle; // Callback for managing favorites
//
//   const HomePage({super.key, required this.onFavoriteToggle});
//
//   @override
//   Widget build(BuildContext context) {
//     // Get screen dimensions
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     Size size = MediaQuery.of(context).size;
//     List<PlaceOfInterest> placeList = PlaceOfInterest.placeList;
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // First Section (Stack with background image, text, and search bar)
//             Stack(
//               children: [
//                 // Background Image
//                 Container(
//                   height: screenHeight * 0.3,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('assets/topImg.jpg'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 // Text Overlay
//                 Positioned(
//                   top: screenHeight * 0.05,
//                   left: screenWidth * 0.05,
//                   child: Text(
//                     'Hi Dhavish',
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.06,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       shadows: [
//                         Shadow(
//                           blurRadius: 3,
//                           color: Colors.black.withOpacity(0.6),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Search Bar Overlay
//                 // Inside the Positioned widget where the search bar is defined
//                 Positioned(
//                   top: screenHeight * 0.22,
//                   left: screenWidth * 0.05,
//                   right: screenWidth * 0.05,
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         PageTransition(
//                           type: PageTransitionType.bottomToTop,
//                           child: SearchScreen(),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 4,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: const TextField(
//                         enabled: false, // Disable the TextField to prevent direct input
//                         decoration: InputDecoration(
//                           hintText: 'Search...',
//                           prefixIcon: Icon(Icons.search, color: Colors.grey),
//                           border: InputBorder.none,
//                           contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//               ],
//             ),
//
//             // Text Section Below Image
//             Padding(
//               padding: EdgeInsets.all(screenWidth * 0.01),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Featured Places',
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.05,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Text(
//                     'Most trending places in Mauritius!',
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.04,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Horizontal ListView of Places
//             SizedBox(
//               height: size.height * 0.3,
//               child: ListView.builder(
//                 itemCount: placeList.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (BuildContext context, int index) {
//                   final place = placeList[index];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         PageTransition(
//                           child: DetailPage(
//                             placeId: place.placeId,
//                           ),
//                           type: PageTransitionType.bottomToTop,
//                         ),
//                       );
//                     },
//                     child: Container(
//                       width: 200,
//                       margin: const EdgeInsets.symmetric(horizontal: 10),
//                       decoration: BoxDecoration(
//                         color: Colors.blue.withOpacity(0.8),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(20),
//                         child: Stack(
//                           children: [
//                             Positioned.fill(
//                               child: Image.asset(
//                                 place.imageURL,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 15,
//                               left: 10,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     place.category,
//                                     style: const TextStyle(
//                                       color: Colors.white70,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                   Text(
//                                     place.placeName,
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // Favorite Icon Button
//                             Positioned(
//                               top: 10,
//                               right: 20,
//                               child: Container(
//                                 height: 50,
//                                 width: 50,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(50),
//                                 ),
//                                 child: IconButton(
//                                   onPressed: () {
//                                     // Toggle the favorite status and call the callback
//                                     onFavoriteToggle(place);
//                                     place.isFavorited = !place.isFavorited; // Update the state of `isFavorited`
//                                   },
//                                   icon: Icon(
//                                     place.isFavorited ? Icons.favorite : Icons.favorite_border,
//                                     color: place.isFavorited ? Colors.red : Colors.grey,
//                                   ),
//                                   iconSize: 30,
//                                 ),
//                               ),
//                             ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             // Categories Section
//             Padding(
//               padding: EdgeInsets.all(screenWidth * 0.01),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Explore more',
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.05,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Text(
//                     'According to your personal taste',
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.04,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             CategoryCarousel(),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../content/category_carousel.dart';
import 'package:my_application/data_model/PlaceOfInterest.dart';
import 'package:my_application/ui/DetailPage.dart';
import 'dart:ui';
import '../content/SearchScreen.dart';
class HomePage extends StatelessWidget {
  final Function(PlaceOfInterest place) onFavoriteToggle; // Callback for managing favorites

  const HomePage({super.key, required this.onFavoriteToggle});



  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    List<PlaceOfInterest> placeList = PlaceOfInterest.placeList;

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
                      image: AssetImage('assets/topImg.jpg'),
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
                // Search Bar Overlay
                // Inside the Positioned widget where the search bar is defined
                //Positioned(
                //   top: screenHeight * 0.22,
                //   left: screenWidth * 0.05,
                //   right: screenWidth * 0.05,
                  // child: GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       PageTransition(
                  //         type: PageTransitionType.bottomToTop,
                  //         child: SearchScreen(),
                  //       ),
                  //     );
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(8),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black.withOpacity(0.2),
                  //           blurRadius: 4,
                  //           offset: const Offset(0, 2),
                  //         ),
                  //       ],
                  //     ),
                  //     child: const TextField(
                  //       enabled: false, // Disable the TextField to prevent direct input
                  //       decoration: InputDecoration(
                  //         hintText: 'Search...',
                  //         prefixIcon: Icon(Icons.search, color: Colors.grey),
                  //         border: InputBorder.none,
                  //         contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  //       ),
                  //     ),
                  //   ),
                  // ),
               // ),

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
                            Positioned.fill(
                              child: Image.asset(
                                place.imageURL,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // You can add other widgets on top of the image (e.g., title)
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Text(
                                place.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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

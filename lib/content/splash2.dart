// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:my_application/ui/root_page.dart'; // Update path to RootPage if necessary
//
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Full-screen PageView for images, title, and subtitle
//           PageView(
//             controller: _pageController,
//             children: [
//               _buildPage(
//                 imagePath: 'assets/image1.jpg',
//                 title: 'Welcome to Mauritius',
//                 subtitle: 'Discover the stunning landscapes, vibrant culture, '
//                     'and endless adventures that await you in Mauritius.',
//                 showGradient: true,
//               ),
//               _buildPage(
//                 imagePath: 'assets/image2.jpg',
//                 title: 'Book Your Activities Easily',
//                 subtitle: 'Plan your perfect vacation with just a few taps. '
//                     'Browse and book activities that suit your style and interests.',
//                 showGradient: true,
//               ),
//               _buildPage(
//                 imagePath: 'assets/waterfall.jpg',
//                 title: 'Get Started Now!',
//                 subtitle: 'Join us today and begin your adventure. Explore, book, and make '
//                     'the most of your time in paradise.',
//                 showGradient: false, // No fading gradient on the last page
//                 showButton: true,
//               ),
//             ],
//           ),
//           // Sliding dot indicator at the bottom
//           Positioned(
//             bottom: 80,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: SmoothPageIndicator(
//                 controller: _pageController,
//                 count: 3,
//                 effect: const ExpandingDotsEffect(
//                   dotHeight: 8,
//                   dotWidth: 8,
//                   spacing: 16,
//                   dotColor: Colors.grey,
//                   activeDotColor: Colors.blue,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPage({
//     required String imagePath,
//     required String title,
//     required String subtitle,
//     bool showGradient = true,
//     bool showButton = false,
//   }) {
//     return Stack(
//       children: [
//         // Background image
//         Positioned.fill(
//           child: Image.asset(
//             imagePath,
//             fit: BoxFit.cover,
//           ),
//         ),
//         // Optional gradient overlay
//         if (showGradient)
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.black.withOpacity(0.6),
//                     Colors.transparent,
//                   ],
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                 ),
//               ),
//             ),
//           ),
//         // Content overlay
//         Align(
//           alignment: Alignment.center,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Animated title
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 35,
//                     fontFamily: 'Miniver',
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     shadows: [
//                       Shadow(
//                         blurRadius: 10,
//                         color: Colors.black54,
//                         offset: Offset(2, 2),
//                       ),
//                     ],
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 16),
//                 // Animated subtitle
//                 Text(
//                   subtitle,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontFamily: 'Arial',
//                     color: Colors.white70,
//                     shadows: [
//                       Shadow(
//                         blurRadius: 8,
//                         color: Colors.black38,
//                         offset: Offset(1, 1),
//                       ),
//                     ],
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 if (showButton) ...[
//                   const SizedBox(height: 40),
//                   // Animated "Get Started" button
//                   ElevatedButton(
//                     onPressed: () {
//                       // Navigate to RootPage
//                       Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(builder: (context) => RootPage()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blueAccent,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 40,
//                         vertical: 12,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     child: const Text(
//                       'Get Started',
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

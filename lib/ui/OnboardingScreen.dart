import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_application/acc_management/email_RegisterScreen.dart';
import 'package:my_application/acc_management/login_page.dart';
import 'package:my_application/ui/InterestSelectionScreen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                OnboardingPage(
                  animationPath: 'assets/animation/anim3.json',
                  title: "Navigate with Ease",
                  description:
                  "Find your way to amazing destinations with our detailed maps.",
                  bgColor: const LinearGradient(
                    colors: [Colors.blueAccent, Colors.deepOrangeAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                OnboardingPage(
                  animationPath: 'assets/animation/anim5.json',
                  title: "Discover Activities",
                  description:
                  "Explore beaches, nightclubs, forests, and more at your fingertips.",
                  bgColor: const LinearGradient(
                    colors: [Colors.redAccent, Colors.deepPurple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                OnboardingPage(
                  animationPath: 'assets/animation/anim4.json',
                  title: "Book Your Adventures",
                  description:
                  "Plan and book activities effortlessly with our calendar feature.",
                  bgColor: const LinearGradient(
                    colors: [Colors.orangeAccent, Colors.purpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                OnboardingPage(
                  animationPath: 'assets/animation/anim6.json',
                  title: "Enjoy the Journey",
                  description:
                  "Embrace every moment of your adventure with stunning views.",
                  bgColor: const LinearGradient(
                    colors: [Colors.blueAccent, Colors.tealAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ],
            ),
          ),
          BottomNavigation(
            controller: _controller,
            totalPages: 4,
            currentPage: _currentPage,
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String animationPath;
  final String title;
  final String description;
  final LinearGradient bgColor;

  const OnboardingPage({
    required this.animationPath,
    required this.title,
    required this.description,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: bgColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animationPath, height: 250),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  final PageController controller;
  final int totalPages;
  final int currentPage;

  const BottomNavigation({
    required this.controller,
    required this.totalPages,
    required this.currentPage,
  });

  // Define gradient colors for each slide
  LinearGradient _getGradientForPage(int page) {
    switch (page) {
      case 0:
        return const LinearGradient(
          colors: [Colors.deepOrangeAccent, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 1:
        return const LinearGradient(
          colors: [Colors.redAccent, Colors.deepPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 2:
        return const LinearGradient(
          colors: [Colors.orangeAccent, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return const LinearGradient(
          colors: [Colors.blueAccent, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 70,
      decoration: BoxDecoration(
        gradient: _getGradientForPage(currentPage),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SKIP Button
          if (currentPage != totalPages - 1)
            TextButton(
              onPressed: () {
                controller.jumpToPage(totalPages - 1);
              },
              child: const Text(
                "SKIP",
                style: TextStyle(color: Colors.white),
              ),
            ),
          if (currentPage == totalPages - 1) const SizedBox(width: 60), // Spacer for alignment

          // Indicators
          Row(
            children: List.generate(
              totalPages,
                  (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: index == currentPage
                      ? Colors.white
                      : Colors.white.withOpacity(0.6),
                ),
              ),
            ),
          ),

          // NEXT or START Button
          if (currentPage != totalPages - 1)
            TextButton(
              onPressed: () async {
                final nextPage = ((await controller.page)?.toInt() ?? 0) + 1;
                if (nextPage < totalPages) {
                  controller.animateToPage(nextPage,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                }
              },
              child: const Text(
                "NEXT",
                style: TextStyle(color: Colors.white),
              ),
            )
          else
            TextButton(
              onPressed: () {
                // Navigate to the InterestSelectionScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInPage(),
                        //InterestSelectionScreen(),
                  ),
                );
              },
              child: const Text(
                "START",
                style: TextStyle(color: Colors.white),
              ),
            ),

        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:my_application/ui/InterestSelectionScreen.dart';
//
// class OnboardingScreen extends StatefulWidget {
//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _controller = PageController();
//   int _currentPage = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: PageView(
//               controller: _controller,
//               onPageChanged: (index) {
//                 setState(() {
//                   _currentPage = index;
//                 });
//               },
//               children: [
//                 OnboardingPage(
//                   imagePath: 'assets/images/seaside.jpg',
//                   title: "Navigate with Ease",
//                   description:
//                   "Find your way to amazing destinations with our detailed maps.",
//                 ),
//                 OnboardingPage(
//                   imagePath: 'assets/images/water.jpg',
//                   title: "Discover Activities",
//                   description:
//                   "Explore beaches, nightclubs, forests, and more at your fingertips.",
//                 ),
//                 OnboardingPage(
//                   imagePath: 'assets/images/lizard.jpg',
//                   title: "Book Your Adventures",
//                   description:
//                   "Plan and book activities effortlessly with our calendar feature.",
//                 ),
//               ],
//             ),
//           ),
//           BottomNavigation(
//             controller: _controller,
//             totalPages: 3,
//             currentPage: _currentPage,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class OnboardingPage extends StatelessWidget {
//   final String imagePath;
//   final String title;
//   final String description;
//
//   const OnboardingPage({
//     required this.imagePath,
//     required this.title,
//     required this.description,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         // Background Image
//         Image.asset(
//           imagePath,
//           fit: BoxFit.cover,
//         ),
//         // Overlay for better text visibility
//         Container(
//           color: Colors.black.withOpacity(0.4),
//         ),
//         // Text Content
//         Column(
//           children: [
//             // Spacer to move content up
//             const Spacer(flex: 1),
//             // Title
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 10),
//             // Description
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Text(
//                 description,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             // Spacer to balance the layout
//             const Spacer(flex: 3),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// class BottomNavigation extends StatelessWidget {
//   final PageController controller;
//   final int totalPages;
//   final int currentPage;
//
//   const BottomNavigation({
//     required this.controller,
//     required this.totalPages,
//     required this.currentPage,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       height: 70,
//       color: Colors.black.withOpacity(0.7),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // SKIP Button
//           if (currentPage != totalPages - 1)
//             TextButton(
//               onPressed: () {
//                 controller.jumpToPage(totalPages - 1);
//               },
//               child: const Text(
//                 "SKIP",
//                 style: TextStyle(color: Colors.white),
//               ),
//             )
//           else
//             const SizedBox(width: 60), // Spacer for alignment
//
//           // Indicators
//           Row(
//             children: List.generate(
//               totalPages,
//                   (index) => Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                 child: CircleAvatar(
//                   radius: 5,
//                   backgroundColor: index == currentPage
//                       ? Colors.white
//                       : Colors.white.withOpacity(0.6),
//                 ),
//               ),
//             ),
//           ),
//
//           // NEXT or START Button
//           if (currentPage != totalPages - 1)
//             TextButton(
//               onPressed: () async {
//                 final nextPage = ((await controller.page)?.toInt() ?? 0) + 1;
//                 if (nextPage < totalPages) {
//                   controller.animateToPage(nextPage,
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut);
//                 }
//               },
//               child: const Text(
//                 "NEXT",
//                 style: TextStyle(color: Colors.white),
//               ),
//             )
//           else
//             TextButton(
//               onPressed: () {
//                 // Navigate to the InterestSelectionScreen
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => InterestSelectionScreen(),
//                   ),
//                 );
//               },
//               child: const Text(
//                 "START",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:my_application/ui/OnboardingScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Navigate to the next page after delay
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => OnboardingScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              'https://images.pexels.com/photos/2583832/pexels-photo-2583832.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', // Replace with your image URL
              fit: BoxFit.cover,
            ),
          ),

          // Black Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // Black overlay with 50% opacity
            ),
          ),
          // Content
          Center(
            child: ScaleTransition(
              scale: _animation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.03),
                  // Animated "Welcome to" text
                  FadeTransition(
                    opacity: _animation,
                    child: Text(
                      'Welcome to',
                      style: TextStyle(
                        fontSize: size.width * 0.06,
                        color: Colors.white, // Change text color to white for better visibility
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  // Type animation for "Mauritius"
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: size.width * 0.08,
                      color: Colors.white, // Change text color to white for better visibility
                      fontWeight: FontWeight.bold,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          'Mauritius',
                          speed: Duration(milliseconds: 100),
                        ),
                      ],
                      isRepeatingAnimation: false,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  // Tagline animation
                  FadeTransition(
                    opacity: _animation,
                    child: Text(
                      'Plan and Book Your Trip With Us',
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        color: Colors.white, // Change text color to white for better visibility
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  // Loading animation
                  Lottie.asset(
                    'assets/animation/anim2.json', // Adjust animation path
                    width: size.width * 0.6,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
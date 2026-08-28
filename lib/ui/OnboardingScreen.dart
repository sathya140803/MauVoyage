import 'package:flutter/material.dart';
import 'package:my_application/acc_management/login_page.dart'; // Replace with actual LoginPage import
import 'dart:ui'; // Import to use BackdropFilter

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
                  imagePath:
                  'https://images.pexels.com/photos/1433052/pexels-photo-1433052.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', // Replace with your image
                  title: "Navigate with Ease",
                  description:
                  "Find your way to amazing destinations with our detailed maps.",
                  currentPage: _currentPage,
                ),
                OnboardingPage(
                  imagePath:
                  'https://images.pexels.com/photos/3538245/pexels-photo-3538245.jpeg?auto=compress&cs=tinysrgb&w=600', // Replace with your image
                  title: "Discover Activities",
                  description:
                  "Explore beaches, nightclubs, forests, and more at your fingertips.",
                  currentPage: _currentPage,
                ),
                OnboardingPage(
                  imagePath:
                  'https://images.pexels.com/photos/3225531/pexels-photo-3225531.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', // Replace with your image
                  title: "Book Your Adventures",
                  description:
                  "Plan and book activities effortlessly with our calendar feature.",
                  currentPage: _currentPage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final int currentPage;

  const OnboardingPage({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image from URL
        Positioned.fill(
          child: Image.network(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        // Black Overlay
        Positioned.fill(
          child: Container(
            color: Colors.black
                .withOpacity(0.5), // Black overlay with transparency
          ),
        ),
        // Content
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            if (currentPage == 2) // Add "START" button for the last page
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the Login page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SignInPage(), // Replace with actual LoginPage
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: const Text("START"),
                ),
              ),
          ],
        ),
        // Persistent Dot indicators at the bottom of the images
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _DotIndicator(isActive: currentPage == 0),
              _DotIndicator(isActive: currentPage == 1),
              _DotIndicator(isActive: currentPage == 2),
            ],
          ),
        ),
      ],
    );
  }
}

class _DotIndicator extends StatelessWidget {
  final bool isActive;

  const _DotIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CircleAvatar(
        radius: 5,
        backgroundColor:
        isActive ? Colors.white : Colors.white.withOpacity(0.6),
      ),
    );
  }
}
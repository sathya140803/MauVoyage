import 'package:flutter/material.dart';
import 'package:my_application/ui/root_page.dart';

class InterestSelectionScreen extends StatefulWidget {
  @override
  _InterestSelectionScreenState createState() => _InterestSelectionScreenState();
}

class _InterestSelectionScreenState extends State<InterestSelectionScreen> {
  final List<String> artists = [
    'Night Club', 'Forest', 'Beaches', 'Activities', 'Kid Club',
    'Waterfall', 'Aquarium', 'Hiking', 'Festivals', 'Water Sports',
    'Spa & Wellness', 'Souvenirs', 'Traditional', 'Nature', 'Farm Tours'
  ];

  final List<String> images = [
    'assets/cat1.jpg', 'assets/cat2.jpg', 'assets/cat3.jpg',
    'assets/cat4.jpg', 'assets/cat5.jpg', 'assets/waterfall.jpg',
    'assets/aquarium.jpg', 'assets/hiking.jpg', 'assets/festival.jpg',
    'assets/snorking.jpg', 'assets/spa.jpg', 'assets/souv.jpg',
    'assets/traditinel.jpg', 'assets/images/riverenoir.jpg', 'assets/lavanille.jpg'
  ];

  List<bool> selectedArtists = List.generate(15, (index) => false);
  bool isContinueButtonVisible = false;

  void _updateSelection(int index) {
    setState(() {
      selectedArtists[index] = !selectedArtists[index];
      int selectedCount = selectedArtists.where((selected) => selected).length;
      isContinueButtonVisible = selectedCount >= 3;
    });
  }

  void _navigateToNextScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RootPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        int crossAxisCount = screenWidth > 600 ? 4 : 3;
        double childAspectRatio = screenWidth > 600 ? 0.7 : 0.8;
        double avatarRadius = screenWidth * 0.12;

        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600), // Limit max width
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenWidth * 0.02
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Choose 3 or more interests you like.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: childAspectRatio,
                            crossAxisSpacing: screenWidth * 0.04,
                            mainAxisSpacing: screenWidth * 0.04,
                          ),
                          itemCount: artists.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => _updateSelection(index),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        radius: avatarRadius,
                                        backgroundColor: Colors.grey[900],
                                        backgroundImage: AssetImage(images[index]),
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        artists[index],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.03,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  if (selectedArtists[index])
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: screenWidth * 0.06,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      if (isContinueButtonVisible)
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.02),
                          child: ElevatedButton(
                            onPressed: _navigateToNextScreen,
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, screenHeight * 0.06),
                            ),
                            child: Text(
                              'Continue',
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
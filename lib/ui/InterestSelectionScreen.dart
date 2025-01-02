import 'package:flutter/material.dart';
import 'package:my_application/ui/root_page.dart';

class InterestSelectionScreen extends StatefulWidget {
  @override
  _InterestSelectionScreenState createState() => _InterestSelectionScreenState();
}

class _InterestSelectionScreenState extends State<InterestSelectionScreen> {
  final List<String> artists = [
    'Night Club',
    'Forest',
    'Beaches',
    'Activities',
    'Kid Club',
    'Waterfall',
    'Aquarium', // New interest
    'Hiking', // New interest
    'Festivals', // New interest
    'Water Sports', // New interest
    'Spa & Wellness', // New interest
    'Souvenirs', // New interest
    'Traditional', // New interest
    'Nature', // New interest
    'Farm Tours', // New interest

  ];

  final List<String> images = [
    'assets/cat1.jpg',
    'assets/cat2.jpg',
    'assets/cat3.jpg',
    'assets/cat4.jpg',
    'assets/cat5.jpg',
    'assets/waterfall.jpg',
    'assets/aquarium.jpg', // New image
    'assets/hiking.jpg', // New image
    'assets/festival.jpg', // New image
    'assets/snorking.jpg', // New image
    'assets/spa.jpg', // New image
    'assets/souv.jpg', // New image
    'assets/traditinel.jpg', // New image
    'assets/images/riverenoir.jpg', // New image
    'assets/lavanille.jpg', // New image
  ];

  List<bool> selectedArtists = List.generate(20, (index) => false);
  bool isContinueButtonVisible = false;

  void _updateSelection(int index) {
    setState(() {
      selectedArtists[index] = !selectedArtists[index];
      int selectedCount = selectedArtists.where((selected) => selected).length;
      isContinueButtonVisible = selectedCount >= 3;
    });
  }

  void _navigateToNextScreen() {
    // Navigate to the RootPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RootPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Positioning the "Choose 3 or more artists you like." text
            Padding(
              padding: const EdgeInsets.only(top: 40.0), // Adjust top padding
              child: Text(
                'Choose 3 or more interests you like.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // Centered the text
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
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
                              radius: 55,
                              backgroundColor: Colors.grey[900],
                              backgroundImage: AssetImage(images[index]),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              artists[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
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
                              size: 24,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (isContinueButtonVisible) // Show button only if minimum selection is met
              ElevatedButton(
                onPressed: _navigateToNextScreen,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Full width
                  iconColor: Colors.orangeAccent, // Set button color to green
                ),
                child: Text('Continue'),
              ),
          ],
        ),
      ),
    );
  }
}

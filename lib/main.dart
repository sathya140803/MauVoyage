
import 'package:flutter/material.dart';
import 'content//splash_screen.dart'; // Import the SplashScreen
import 'ui/root_page.dart';
import 'cat_Pages/NightClubsPage.dart'; // Import the NightClubsPage
import 'cat_Pages/ForestsPage.dart'; // Import the ForestsPage
import 'cat_Pages/BeachesPage.dart'; // Import the BeachesPage
import 'cat_Pages/ActivitiesPage.dart'; // Import the ActivitiesPage
import 'ui/InterestSelectionScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'myapp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(), // Use the SplashScreen from the new file
      routes: {
        '/nightclubs': (context) => NightClubsPage(),
        '/forests': (context) => ForestsPage(),
        '/beaches': (context) => BeachesPage(),
        '/activities': (context) => ActivitiesPage(),
        '/InterestSelectionScreen': (context) => ActivitiesPage(),
        '/root_page': (context) => RootPage(),
      },
    );
  }
}

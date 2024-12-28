// import 'package:flutter/material.dart';
// import 'ui/root_page.dart';
// import 'cat_Pages//NightClubsPage.dart'; // Import the NightClubsPage
// import 'cat_Pages//ForestsPage.dart'; // Import the ForestsPage
// import 'cat_Pages//BeachesPage.dart'; // Import the BeachesPage
// import 'cat_Pages//ActivitiesPage.dart'; // Import the ActivitiesPage
// import 'cat_Pages//KidsClubPage.dart'; // Import the KidsClubPage
//
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Navigation Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: RootPage(), // Assuming RootPage is your main screen
//       routes: {
//         '/nightclubs': (context) => NightClubsPage(),
//         '/forests': (context) => ForestsPage(),
//         '/beaches': (context) => BeachesPage(),
//         '/activities': (context) => ActivitiesPage(),
//         '/kidsclub': (context) => KidsClubPage(),
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'content//splash_screen.dart'; // Import the SplashScreen
import 'ui/root_page.dart';
import 'cat_Pages/NightClubsPage.dart'; // Import the NightClubsPage
import 'cat_Pages/ForestsPage.dart'; // Import the ForestsPage
import 'cat_Pages/BeachesPage.dart'; // Import the BeachesPage
import 'cat_Pages/ActivitiesPage.dart'; // Import the ActivitiesPage
import 'cat_Pages/KidsClubPage.dart'; // Import the KidsClubPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(), // Use the SplashScreen from the new file
      routes: {
        '/nightclubs': (context) => NightClubsPage(),
        '/forests': (context) => ForestsPage(),
        '/beaches': (context) => BeachesPage(),
        '/activities': (context) => ActivitiesPage(),
        '/kidsclub': (context) => KidsClubPage(),
        '/root_page': (context) => RootPage(),
      },
    );
  }
}

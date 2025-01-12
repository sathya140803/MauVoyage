import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_application/ui/settings/theme_provider.dart'; // Import the ThemeProvider
import 'content/splash_screen.dart'; // Import the SplashScreen
import 'ui/root_page.dart';
import 'cat_Pages/NightClubsPage.dart';
import 'cat_Pages/ForestsPage.dart';
import 'cat_Pages/BeachesPage.dart';
import 'cat_Pages/ActivitiesPage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'myapp',
      themeMode: themeProvider.themeMode, // Use themeMode from ThemeProvider
      theme: MyThemes.lightTheme,        // Light theme
      darkTheme: MyThemes.darkTheme,     // Dark theme
      home: const RootPage(),
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

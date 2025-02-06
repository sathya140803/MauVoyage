
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_application/data_model/PlaceOfInterest.dart';
import 'package:my_application/notification_schedule/local_notification.dart';
import 'package:my_application/notification_schedule/schedule_controller.dart';
import 'package:my_application/ui/InterestSelectionScreen.dart';
import 'package:my_application/ui/home_page.dart';
import 'package:provider/provider.dart';
import 'package:my_application/ui/settings/theme_provider.dart'; // Import the ThemeProvider
import 'content/splash_screen.dart'; // Import the SplashScreen
import 'ui/root_page.dart';

import 'cat_Pages/NightClubsPage.dart'; // Import the NightClubsPage
import 'cat_Pages/ForestsPage.dart'; // Import the ForestsPage
import 'cat_Pages/BeachesPage.dart'; // Import the BeachesPage
import 'cat_Pages/ActivitiesPage.dart'; // Import the ActivitiesPage
import 'acc_management/login_page.dart';
import 'acc_management/profile_setting.dart';
import 'acc_management/security_frontend.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LocalNotification.init();
  GetStorage.init();
  if(kIsWeb) {

    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAeSpjJOi0771PosXMZh5RLICuceeXHIgI",
            authDomain: "travelapp-74f28.firebaseapp.com",
            projectId: "travelapp-74f28",
            storageBucket: "travelapp-74f28.firebasestorage.app",
            messagingSenderId: "340107156944",
            appId: "1:340107156944:web:d1d5c4738f9b4bd12cedd5",
            measurementId: "G-K12JG3B610"));

  }else {
   await Firebase.initializeApp();
  }
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=>ThemeProvider())
        ],
        child: const MyApp(),
      )
  );
  removeOldDates();
  //GetStorage().remove("schedules");
  //GetStorage().remove("notifications");
  //GetStorage().remove("notification_id");
  //GetStorage().remove("inAppNotiId");
  //GetStorage().remove("favourites");

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'myapp',

          themeMode: themeProvider.themeMode, // Use themeMode from ThemeProvider
          theme: MyThemes.lightTheme,        // Light theme
          darkTheme: MyThemes.darkTheme,     // Dark theme
          home:  SplashScreen(),

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

    );
  }
}

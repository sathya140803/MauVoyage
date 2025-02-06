import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_application/ui/settings/theme_provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../data_model/PlaceOfInterest.dart';
import 'home_page.dart';
import 'favourite_page.dart';
import 'calendar_page.dart';
import 'settings/settings_page.dart';
import 'currency_converter_page.dart';
import 'EmergencyPage.dart';  // Import the EmergencyPage

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  List<Widget> _widgetOptions() {
    return [
      HomePage(),
      FavouritePage(),
      CalendarPage(),
      CurrencyConverterPage(),
      SettingsPage(),
    ];
  }


  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          _widgetOptions()[_currentIndex],
          // Emergency Button
          Visibility(
            visible: themeProvider.isEmergencyButtonEnabled,
            child: Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () {
                  // Navigate to the EmergencyPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EmergencyPage()),
                  );
                },
                child: const Icon(Icons.warning, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            selectedColor: Colors.red,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.calendar_today),
            title: const Text('Calendar'),
            selectedColor: Colors.purple,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.attach_money),
            title: const Text('Converter'),
            selectedColor: Colors.teal,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('Settings'),
            selectedColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

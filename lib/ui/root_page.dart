import 'package:flutter/material.dart';
import 'package:my_application/data_model/PlaceOfInterest.dart';
import 'home_page.dart';
import 'favourite_page.dart';
import 'calendar_page.dart';
import 'settings_page.dart';
import 'currency_converter_page.dart'; // Import the new page
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<PlaceOfInterest> favorites = [];
  int _currentIndex = 0;

  List<Widget> _widgetOptions() {
    return [
      HomePage(
        onFavoriteToggle: _updateFavorites,
      ),
      FavouritePage(favoritedPlaces: favorites),
      CalenderPage(),
      CurrencyConverterPage(),
      SettingsPage(),
       // Add the new page
    ];
  }

  void _updateFavorites(PlaceOfInterest place) {
    setState(() {
      if (favorites.contains(place)) {
        favorites.remove(place);
      } else {
        favorites.add(place);
      }
    });
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions()[_currentIndex],
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
            selectedColor: Colors.green,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.attach_money),
            title: const Text('Converter'),
            selectedColor: Colors.teal,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('Settings'),
            selectedColor: Colors.grey,
          ),

        ],
      ),
    );
  }
}

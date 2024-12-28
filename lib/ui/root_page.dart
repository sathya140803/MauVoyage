import 'package:flutter/material.dart';
import 'package:my_application/data_model/PlaceOfInterest.dart';
import 'home_page.dart';
import 'favourite_page.dart';
import 'calendar_page.dart';
import 'settings_page.dart';

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
      CalendarPage(),
      SettingsPage(),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}



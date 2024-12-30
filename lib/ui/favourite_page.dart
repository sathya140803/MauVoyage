import 'package:flutter/material.dart';
import 'package:my_application/data_model/PlaceOfInterest.dart';

class FavouritePage extends StatelessWidget {
  final List<PlaceOfInterest> favoritedPlaces;

  const FavouritePage({Key? key, required this.favoritedPlaces}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoritedPlaces.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoritedPlaces[index].name), // Assuming `name` is a property of PlaceOfInterest
            // You can add more details here as needed
          );
        },
      ),
    );
  }
}



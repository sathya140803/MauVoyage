// import 'package:flutter/material.dart';
// import '../data_model/PlaceOfInterest.dart';
// import 'detail_page.dart';  // Import your DetailPage
//
// class FavouritePage extends StatefulWidget {
//   final List<PlaceOfInterest> favoritedPlaces;
//
//   const FavouritePage({Key? key, required this.favoritedPlaces}) : super(key: key);
//
//   @override
//   _FavouritePageState createState() => _FavouritePageState();
// }
//
// class _FavouritePageState extends State<FavouritePage> {
//   late List<PlaceOfInterest> displayedFavorites;
//
//   @override
//   void initState() {
//     super.initState();
//     displayedFavorites = widget.favoritedPlaces;
//   }
//
//   void _removeFromFavorites(int index) {
//     setState(() {
//       displayedFavorites.removeAt(index);
//     });
//   }
//
//   // void _filterFavorites(String query) {
//   //   setState(() {
//   //     if (query.isEmpty) {
//   //       displayedFavorites = widget.favoritedPlaces;
//   //     } else {
//   //       displayedFavorites = widget.favoritedPlaces
//   //           .where((place) =>
//   //           place.placeName.toLowerCase().contains(query.toLowerCase()))
//   //           .toList();
//   //     }
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Favourites'),
//       ),
//       body: Column(
//         children: [
//           // Show search bar only if there are favorites
//           if (displayedFavorites.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search favorites...',
//                   prefixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 onChanged: _filterFavorites,
//               ),
//             ),
//           Expanded(
//             child: displayedFavorites.isEmpty
//                 ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Image for Empty State
//                   Image.asset(
//                     'assets/location.png', // Replace with your own image
//                     width: 150,
//                     height: 150,
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     'No favorites added yet',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ],
//               ),
//             )
//                 : ListView.builder(
//               itemCount: displayedFavorites.length,
//               itemBuilder: (context, index) {
//                 final place = displayedFavorites[index];
//                 return Dismissible(
//                   key: UniqueKey(),
//                   onDismissed: (direction) {
//                     _removeFromFavorites(index);
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('${place.placeName} removed from favorites'),
//                       ),
//                     );
//                   },
//                   background: Container(
//                     color: Colors.red,
//                     alignment: Alignment.centerRight,
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: const Icon(Icons.delete, color: Colors.white),
//                   ),
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               DetailPage(placeId: index),
//                         ),
//                       );
//                     },
//                     child: Card(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 15, vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       elevation: 5,
//                       child: Row(
//                         children: [
//                           // Image Section
//                           ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(15),
//                               bottomLeft: Radius.circular(15),
//                             ),
//                             child: Image.asset(
//                               place.imageURL,
//                               width: 100,
//                               height: 100,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           // Name Section
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 10),
//                               child: Text(
//                                 place.placeName,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           // Remove from Favorites Button
//                           IconButton(
//                             onPressed: () {
//                               _removeFromFavorites(index);
//                             },
//                             icon: const Icon(
//                               Icons.favorite,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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



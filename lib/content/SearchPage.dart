// import 'package:flutter/material.dart'; // Keep the default Material package for other widgets
// import 'package:flutter_search_bar/flutter_search_bar.dart' as search_bar; // Alias flutter_search_bar
//
// import '../data_model/PlaceOfInterest.dart'; // Explicitly import SearchBar from flutter_search_bar
//
// class SearchPage extends StatefulWidget {
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }
//
// class _SearchPageState extends State<SearchPage> {
//   late search_bar.SearchBar searchBar; // Use the aliased SearchBar
//   String searchQuery = "";
//
//   // Initialize search bar
//   _SearchPageState() {
//     searchBar = search_bar.SearchBar(
//       inBar: true,
//       setState: setState,
//       onSubmitted: (query) {
//         setState(() {
//           searchQuery = query;
//         });
//       },
//       onChanged: (query) {
//         setState(() {
//           searchQuery = query;
//         });
//       },
//       buildDefaultAppBar: (BuildContext context) {
//         return AppBar(
//           title: Text('Search Places'),
//           actions: [searchBar.getSearchAction(context)],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: searchBar.build(context), // Build the search bar
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             // Search Results or Suggestions
//             Expanded(
//               child: ListView.builder(
//                 itemCount: PlaceOfInterest.placeList.length,
//                 itemBuilder: (context, index) {
//                   final place = PlaceOfInterest.placeList[index];
//
//                   // Filter places based on the search query
//                   if (place.name.toLowerCase().contains(searchQuery.toLowerCase())) {
//                     return ListTile(
//                       title: Text(place.name),
//                       subtitle: Text('Rating: ${place.rating}'),
//                       leading: Image.asset(place.imageURL, width: 50, height: 50),
//                       onTap: () {
//                         // Handle navigation or place selection here
//                       },
//                     );
//                   } else {
//                     return Container(); // Return an empty container for non-matching places
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

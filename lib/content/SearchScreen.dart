// import 'package:flutter/material.dart';
// import '../data_model/PlaceOfInterest.dart';
// import  'package:my_application/ui/detail_page.dart';
// class SearchScreen extends StatefulWidget {
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   TextEditingController _searchController = TextEditingController();
//   List<PlaceOfInterest> _searchResults = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_onSearchChanged);
//   }
//
//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   void _onSearchChanged() {
//     setState(() {
//       _searchResults = PlaceOfInterest.placeList.where((place) {
//         final query = _searchController.text.toLowerCase();
//         return place.placeName.toLowerCase().contains(query) ||
//             place.category.toLowerCase().contains(query);
//       }).toList();
//     });
//   }
//
//   Widget _buildDropdown() {
//     if (_searchResults.isEmpty || _searchController.text.isEmpty) {
//       return SizedBox.shrink(); // Hide dropdown if no results or no query
//     }
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: ListView.builder(
//         shrinkWrap: true, // Ensure dropdown doesn't expand fully
//         itemCount: _searchResults.length,
//         itemBuilder: (context, index) {
//           final place = _searchResults[index];
//           return ListTile(
//             leading: ClipRRect(
//               borderRadius: BorderRadius.circular(8), // Rounded corners for the thumbnail
//               child: Image.asset(
//                 place.imageURL,
//                 width: 50, // Adjust size as needed
//                 height: 50,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             title: Text(place.placeName),
//             subtitle: Text(place.category),
//             onTap: () {
//               // Navigate to the detail screen
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DetailPage(placeId: place.placeId),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search Places'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search by name or category',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             _buildDropdown(), // Display the dropdown below the TextField
//             Expanded(
//               child: _searchResults.isEmpty && _searchController.text.isNotEmpty
//                   ? Center(child: Text('No results found'))
//                   : SizedBox.shrink(), // Main list view hidden for dropdown implementation
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:my_application/data_model/Forest.dart';
import 'package:my_application/data_model/Activity.dart';
import 'package:my_application/data_model/Beach.dart';  // Import the Beach model
import 'package:my_application/data_model/PlaceOfInterest.dart';  // Import the PlaceOfInterest model
import 'package:my_application/data_model/NightClubEvent .dart';  // Import the NightClubEvent model
import 'package:my_application/ui/DetailPage.dart';  // Import the DetailPage

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  List<dynamic> filteredResults = [];
  List<String> suggestions = [
    'Gato-de-lhuile',
    'Le Morne Beach',
    'Exciting Activities',
    'Quad Biking Adventure',
    'Must-Visit Places',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(searchFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  focusNode: searchFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      query = value;
                      if (query.isEmpty) {
                        filteredResults.clear();
                      } else {
                        filteredResults = [
                          ...Forest.forestList.where((forest) =>
                              forest.name.toLowerCase().contains(query.toLowerCase())),
                          ...Activity.activityList.where((activity) =>
                              activity.name.toLowerCase().contains(query.toLowerCase())),
                          ...Beach.beachList.where((beach) =>
                              beach.name.toLowerCase().contains(query.toLowerCase())),
                          ...PlaceOfInterest.placeList.where((poi) =>
                              poi.name.toLowerCase().contains(query.toLowerCase())),
                          ...NightClubEvent.nightClubList.where((event) =>
                              event.name.toLowerCase().contains(query.toLowerCase())),
                        ];
                      }
                    });
                  },
                ),
              ),
              if (query.isNotEmpty)
                IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      searchController.clear();
                      query = '';
                      filteredResults.clear();
                    });
                  },
                ),
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: query.isEmpty ? buildSuggestions() : buildSearchResults(),
    );
  }

  Widget buildSuggestions() {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return GestureDetector(
          onTap: () {
            // Fill the search bar with the suggestion
            searchController.text = suggestion;
            setState(() {
              query = suggestion;
              filteredResults = [
                ...Forest.forestList.where((forest) =>
                    forest.name.toLowerCase().contains(query.toLowerCase())),
                ...Activity.activityList.where((activity) =>
                    activity.name.toLowerCase().contains(query.toLowerCase())),
                ...Beach.beachList.where((beach) =>
                    beach.name.toLowerCase().contains(query.toLowerCase())),
                ...PlaceOfInterest.placeList.where((poi) =>
                    poi.name.toLowerCase().contains(query.toLowerCase())),
                ...NightClubEvent.nightClubList.where((event) =>
                    event.name.toLowerCase().contains(query.toLowerCase())),
              ];
            });
          },
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            child: ListTile(
              title: Text(
                suggestion,
                style: TextStyle(
                  color: Colors.blueAccent, // Highlight color
                  fontWeight: FontWeight.bold,
                  fontSize: 16, // Larger font size
                ),
              ),
              trailing: Icon(Icons.arrow_forward, color: Colors.grey),
            ),
          ),
        );
      },
    );
  }

  Widget buildSearchResults() {
    if (filteredResults.isEmpty && query.isNotEmpty) {
      return const Center(child: Text('No results found.'));
    }

    return ListView.builder(
      itemCount: filteredResults.length,
      itemBuilder: (context, index) {
        final item = filteredResults[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          elevation: 2.0,
          child: ListTile(
            contentPadding: EdgeInsets.all(8.0),
            title: Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item.description),
            leading: ClipOval(
              child: Image.asset(
                item.imageURL,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(item: item),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }
}

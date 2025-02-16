import 'package:flutter/material.dart';
import 'package:my_application/data_model/Forest.dart';
import 'package:my_application/data_model/Activity.dart';
import 'package:my_application/data_model/Beach.dart';
import 'package:my_application/data_model/PlaceOfInterest.dart';
import 'package:my_application/data_model/NightClubEvent .dart';
import 'package:my_application/ui/DetailPage.dart';

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
  ];

  // List of categories for the carousel
  final List<String> categories = [
    'Beaches',
    'Forests',
    'Activities',
    'Nightlife',
  ];
  String selectedCategory = 'Beaches';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(searchFocusNode);
    });
  }

  // Function to show the filter modal
  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Filter by Category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ListTile(
                leading: Icon(Icons.nature),
                title: Text('Forest'),
                onTap: () {
                  // Implement filtering logic here
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.beach_access),
                title: Text('Beach'),
                onTap: () {
                  // Implement filtering logic here
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.local_activity),
                title: Text('Activities'),
                onTap: () {
                  // Implement filtering logic here
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.nightlife),
                title: Text('Nightlimfe'),
                onTap: () {
                  // Implement filtering logic here
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[100]!,
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            '',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterModal, // Open filter modal
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue[100]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Category Carousel
            Container(
              height: 60,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = categories[index];
                        filteredResults =
                            _filterResultsByCategory(selectedCategory);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      padding:
                          EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: selectedCategory == categories[index]
                            ? Colors.blue
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: selectedCategory == categories[index]
                                ? Colors.white
                                : Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Search bar
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      focusNode: searchFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                      ),
                      onChanged: (value) {
                        setState(() {
                          query = value;
                          if (query.isEmpty) {
                            filteredResults.clear();
                          } else {
                            filteredResults = _performSearch(query);
                          }
                        });
                      },
                    ),
                  ),
                  if (query.isNotEmpty)
                    IconButton(
                      icon: Icon(Icons.clear),
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
            // Suggestions or search results
            Expanded(
              child: query.isEmpty ? buildSuggestions() : buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  // Filter results by selected category
  List<dynamic> _filterResultsByCategory(String category) {
    switch (category) {
      case 'Beaches':
        return Beach.beachList;
      case 'Forests':
        return Forest.forestList;
      case 'Activities':
        return Activity.activityList;
      case 'Nightlife':
        return NightClubEvent.nightClubList;
      default:
        return [];
    }
  }

  // Perform search on all categories
  List<dynamic> _performSearch(String query) {
    return [
      ...Forest.forestList.where(
          (forest) => forest.name.toLowerCase().contains(query.toLowerCase())),
      ...Activity.activityList.where((activity) =>
          activity.name.toLowerCase().contains(query.toLowerCase())),
      ...Beach.beachList.where(
          (beach) => beach.name.toLowerCase().contains(query.toLowerCase())),
      ...PlaceOfInterest.placeList
          .where((poi) => poi.name.toLowerCase().contains(query.toLowerCase())),
      ...NightClubEvent.nightClubList.where(
          (event) => event.name.toLowerCase().contains(query.toLowerCase())),
    ];
  }

  Widget buildSuggestions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              'Trending Searches',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = suggestions[index];
                return GestureDetector(
                  onTap: () {
                    searchController.text = suggestion;
                    setState(() {
                      query = suggestion;
                      filteredResults = _performSearch(query);
                    });
                  },
                  child: ListTile(
                    leading: Icon(Icons.search), // Add an icon to suggestions
                    title: Text(
                      suggestion,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(item: item),
              ),
            );
          },
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            elevation: 4.0, // Increased elevation for better separation
            child: ListTile(
              contentPadding: EdgeInsets.all(8.0),
              title: Text(item.name,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item.description),
              leading: ClipOval(
                child: Image.asset(
                  item.imageURL,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                ),
              ),
            ),
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

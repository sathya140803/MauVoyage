import 'package:flutter/material.dart';
import 'package:my_application/data_model/Activity.dart';
import 'package:my_application/data_model/Beach.dart';
import 'package:my_application/data_model/Forest.dart';
import 'package:my_application/data_model/NightClubEvent .dart';
import 'package:my_application/data_model/PlaceOfInterest.dart';
import 'package:my_application/favourite_manager/favourite_manipulator.dart';
import 'package:my_application/ui/DetailPage.dart';

getItem(int id, String type) {
  if (type == "Beach") return Beach.beachList[id];
  if (type == "Forest") return Forest.forestList[id];
  if (type == "Activity") return Activity.activityList[id];
  if (type == "NightClubEvent") return NightClubEvent.nightClubList[id];
  if (type == "PlaceOfInterest") return PlaceOfInterest.placeList[id];
  return null;
}

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePage();
}

class _FavouritePage extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    var favourites = getFavourites();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: favourites.isEmpty
            ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/location.png',  // Replace with the path to your image
                  width: 125,  // Adjust width as needed
                  height: 125,  // Adjust height as needed
                  fit: BoxFit.cover,  // Use BoxFit for image scaling
                ),
                SizedBox(height: 16),
                Text(
                  'No favorites selected yet',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            )

        )
            : ListView.builder(
          itemCount: favourites.length,
          itemBuilder: (context, index) {
            var favourite = favourites[index];
            var item = getItem(favourite["item_id"], favourite["item_type"]);

            if (item == null) return const SizedBox.shrink();

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailPage(item: item)),
                  ).then((val) => setState(() {}));
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          item.imageURL,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              item.description!,
                              style: TextStyle(color: Colors.black87),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              favourite["item_type"] == "Activity" ? item.price : item.entryFee,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            removeFavourite(index);
                          });
                        },
                        icon: const Icon(
                          Icons.favorite,
                          size: 28,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

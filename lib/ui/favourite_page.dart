import 'package:flutter/material.dart';
import 'package:my_application/data_model/Activity.dart';
import 'package:my_application/data_model/Beach.dart';
import 'package:my_application/data_model/Forest.dart';
import 'package:my_application/data_model/NightClubEvent%20.dart';
import 'package:my_application/data_model/PlaceOfInterest.dart';
import 'package:my_application/favourite_manager/favourite_manipulator.dart';
import 'package:my_application/ui/DetailPage.dart';

getItem(int id, String type){
  if (type == "Beach") return Beach.beachList[id];
  if (type == "Forest") return Forest.forestList[id];
  if (type == "Activity") return Activity.activityList[id];
  if (type == "NightClubEvent") return NightClubEvent.nightClubList[id];
  if (type == "PlaceOfInterest") return PlaceOfInterest.placeList[id];
  return "";
}


class FavouritePage extends StatefulWidget{
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
        title: const Text('Favorites'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: favourites.length,
        itemBuilder: (context, index) {
          var favourite = favourites[index];
          var item = getItem(favourite["item_id"], favourite["item_type"]);

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: ClipOval(
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(25.0),
                    child: Image.asset(item.imageURL, fit: BoxFit.cover),
                  )
              ),
              title: Text(
                item.name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.description!,
                    style: const TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    favourite["item_type"] == "Activity"? item.price : item.entryFee,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              trailing: IconButton(
                  onPressed: (){
                    removeFavourite(index);
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.heart_broken,
                    size: 30,
                    color: Colors.red,

                  ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => DetailPage(item: item)));
              },
            ),
          );
        },
      ),
    );
  }
}



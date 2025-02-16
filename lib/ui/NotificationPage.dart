import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_application/data_model/Activity.dart';
import 'package:my_application/data_model/Beach.dart';
import 'package:my_application/data_model/Forest.dart';
import 'package:my_application/data_model/NightClubEvent%20.dart';
import 'package:my_application/data_model/PlaceOfInterest.dart';
import 'package:my_application/notification_schedule/notification_controller.dart';
import 'package:my_application/notification_schedule/schedule_controller.dart';
import 'package:my_application/ui/DetailPage.dart';


getItem(int id, String type){
  if (type == "Beach") return Beach.beachList[id];
  if (type == "Forest") return Forest.forestList[id];
  if (type == "Activity") return Activity.activityList[id];
  if (type == "NightClubEvent") return NightClubEvent.nightClubList[id];
  if (type == "PlaceOfInterest") return PlaceOfInterest.placeList[id];
  return "";
}



class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    removeOldDates();
    // Sample notifications
    /*final List<Map<String, String>> notifications = [
      {
        "title": "New Destination Added!",
        "description": "Discover the beautiful Le Morne Brabant.",
        "time": "2 hours ago",
        "image": "https://thewandertherapy.com/wp-content/uploads/2024/02/3.scuba-diving-andaman-1200x900.jpg", // Example image URL
      },
      {
        "title": "Booking Reminder",
        "description": "Your booking for Scuba Diving is tomorrow.",
        "time": "1 day ago",
        "image": "https://example.com/destination2.jpg", // Example image URL
      },
      {
        "title": "Special Offer",
        "description": "50% off on Chamarel Seven Colored Earth tours!",
        "time": "3 days ago",
        "image": "https://example.com/offer.jpg", // Example image URL
      },
      {
        "title": "Explore New Restaurants",
        "description": "Try the latest seafood specials at Ocean's Delight.",
        "time": "1 week ago",
        "image": "https://example.com/restaurant.jpg", // Example image URL
      },
    ];*/

    List<dynamic> notifications = getNotifications();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          var notification = notifications[index];
          var item = getItem(notification["itemId"], notification["itemType"]);
          if((DateTime.parse(notification["showTime"])).isBefore(DateTime.now())) {
            String due = DateTime.now().isAfter(DateTime.parse(notification["showTime"]).add(Duration(days: 1))) ? " Today!" : " Tomorrow!";
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
                  notification["type"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification["description"]+due!,
                      style: const TextStyle(color: Colors.black87),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      notification["showTime"].substring(0,11)!,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => DetailPage(item: item)));
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

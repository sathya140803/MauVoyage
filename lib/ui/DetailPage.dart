import 'package:cloudinary_dart/transformation/resize/pad.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_application/content/cloudinary_controller.dart';
import 'package:my_application/content/comment_controller.dart';
import 'package:my_application/data_model/Beach.dart'; // Import the Beach model
import 'package:my_application/data_model/Forest.dart'; // Import the Forest model
import 'package:my_application/data_model/Activity.dart'; // Import the Activity model
import 'package:my_application/data_model/NightClubEvent .dart'; // Import the NightClubEvent model
import 'package:my_application/data_model/PlaceOfInterest.dart'; // Import the PlaceOfInterest model
import 'package:my_application/favourite_manager/favourite_manipulator.dart';
import 'package:my_application/notification_schedule/schedule_controller.dart';
import 'package:table_calendar/table_calendar.dart'; // Import the custom_calendar_picker package
import 'package:http/http.dart' as http;

import "package:my_application/acc_management/authentications.dart";
import 'package:url_launcher/url_launcher_string.dart';

import '../Location/map.dart';

int getDays(DateTime to){
  var cur = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var to2 = DateTime(to.year, to.month, to.day);
  return (to2.difference(cur).inHours/24).round() - 1;
}


Future<Widget> commentsBuilder(String placeString, var width, Color textColor, Function commentSettings, Function addUserComment, User? currentUser) async{
  var data = await getComments(placeString);
  var commentCheck = false;
  if(data.data() != null && data.data()!.isNotEmpty){
    var userComment = data.data().entries.map((entry) async {
      String uid = entry.key;
      if(entry.value["user"] == null || entry.value["comment"] == null){
        return Container();
      }
      String userName = entry.value["user"];
      String comment = entry.value["comment"];
      if(uid == currentUser?.uid){
        commentCheck = true;
        String imageUrl = await getImage(uid);
        var response = await http.get(Uri.parse(imageUrl));
        if(response.statusCode == 404){
          imageUrl = 'https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg';
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.network(
                  imageUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textColor),
                  ),
                  SizedBox(
                    width: width * 0.675,
                    child: Text(
                      comment,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: IconButton(
                      onPressed: (){
                        commentSettings(comment);
                      },
                      icon: Icon(Icons.more_vert)
                  )
              )
            ],
          ),
        );
      }
      return Container();
    }).toList();
    var commentList = data.data().entries.map((entry) async {
      String uid = entry.key;
      if(entry.value["user"] == null || entry.value["comment"] == null){
        return Container();
      }
      String userName = entry.value["user"];
      String comment = entry.value["comment"];
      String imageUrl = await getImage(uid);
      var response = await http.get(Uri.parse(imageUrl));
      if(response.statusCode == 404){
        imageUrl = 'https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg';
      }
      if(uid != currentUser?.uid){
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.network(
                  imageUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textColor),
                  ),
                  SizedBox(
                    width: width * 0.75,
                    child: Text(
                      comment,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
      return Container();
    }).toList();
    if(!commentCheck){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: (){
                addUserComment();
              },
              child: Text("Add Comment")
          ),
          Divider(),
          for(var item in commentList) await item
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(var item in userComment) await item,
        Divider(),
        for(var item in commentList) await item
      ],
    );
  }
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextButton(
          onPressed: (){
            addUserComment();
          },
          child: Text("Add Comment",)
      ),
      Divider(),
      Text("No Comments")
    ],
  );
}


class DetailPage extends StatelessWidget {
  final dynamic item;
  const DetailPage({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return CommonDetailLayout(
      item: item,
      itemName: getItemName(),
      itemType: getItemType(),
      itemImageURL: getItemImageURL(),
      itemDescription: getItemDescription(),
      comments: getItemComments(),
      additionalInfo: getAdditionalInfo(context),  // Pass the context here
      themeColor: getThemeColor(),
    );
  }


  String getItemName() {
    if (item is Beach) return item.name;
    if (item is Forest) return item.name;
    if (item is Activity) return item.name;
    if (item is NightClubEvent) return item.name;
    if (item is PlaceOfInterest) return item.name;
    return 'Unknown Item';
  }

  String getItemImageURL() {
    if (item is Beach) return item.imageURL;
    if (item is Forest) return item.imageURL;
    if (item is Activity) return item.imageURL;
    if (item is NightClubEvent) return item.imageURL;
    if (item is PlaceOfInterest) return item.imageURL;
    return '';
  }

  String getItemDescription() {
    if (item is Beach) return item.description;
    if (item is Forest) return item.description;
    if (item is Activity) return item.description;
    if (item is NightClubEvent) return item.description;
    if (item is PlaceOfInterest) return item.description;
    return '';
  }

  List<String> getItemComments() {
    if (item is Beach) return [item.comment1, item.comment2];
    if (item is Forest) return [item.comment1, item.comment2];
    if (item is Activity) return [item.comment1, item.comment2];
    if (item is NightClubEvent) return [item.comment1, item.comment2];
    if (item is PlaceOfInterest) return [item.comment1, item.comment2];
    return [];
  }

  List<Widget> getAdditionalInfo(BuildContext context) {
    // Get the current theme data
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black54;

    if (item is Activity) {
      return [
        Text('Price: ${item.price}', style: TextStyle(fontSize: 16, color: textColor)),
        Text('Duration: ${item.duration}', style: TextStyle(fontSize: 16, color: textColor)),
      ];
    }
    if (item is Beach) {
      return [
        Text('EntryFee: ${item.entryFee}', style: TextStyle(fontSize: 16, color: textColor)),
        Text('OpeningHour: ${item.openingHours}', style: TextStyle(fontSize: 16, color: textColor)),
      ];
    }
    if (item is NightClubEvent) {
      return [
        Text('EntryFee: ${item.entryFee}', style: TextStyle(fontSize: 16, color: textColor)),
        Text('EventDate: ${item.eventDate}', style: TextStyle(fontSize: 16, color: textColor)),
      ];
    }
    if (item is Forest) {
      return [
        Text('EntryFee: ${item.entryFee}', style: TextStyle(fontSize: 16, color: textColor)),
        Text('OpeningHours: ${item.openingHours}', style: TextStyle(fontSize: 16, color: textColor)),
      ];
    }
    if (item is PlaceOfInterest) {
      return [
        Text('EntryFee: ${item.entryFee}', style: TextStyle(fontSize: 16, color: textColor)),
        Text('OpeningHours: ${item.openingHours}', style: TextStyle(fontSize: 16, color: textColor)),
      ];
    }
    return [];
  }

  String getItemType() {
    if (item is Beach) return "Beach";
    if (item is Forest) return "Forest";
    if (item is Activity) return "Activity";
    if (item is NightClubEvent) return "NightClubEvent";
    if (item is PlaceOfInterest) return "PlaceOfInterest";
    return "";
  }


  Color getThemeColor() {
    if (item is Beach) return Colors.blueAccent;
    if (item is Forest) return Colors.greenAccent;
    if (item is Activity) return Colors.orangeAccent;
    if (item is NightClubEvent) return Colors.deepPurple;
    if (item is PlaceOfInterest) return Colors.teal;
    return Colors.grey;
  }
}

class CommonDetailLayout extends StatefulWidget {
  final dynamic item;
  final String itemName;
  final String itemType;
  final String itemImageURL;
  final String itemDescription;
  final List<String> comments;
  final List<Widget> additionalInfo;
  final Color themeColor;

  const CommonDetailLayout({
    super.key,
    required this.item,
    required this.itemName,
    required this.itemType,
    required this.itemImageURL,
    required this.itemDescription,
    required this.comments,
    required this.additionalInfo,
    required this.themeColor,
  });

  @override
  State<StatefulWidget> createState() => _CommonDetailLayout();
}

class _CommonDetailLayout extends State<CommonDetailLayout> {

  var commentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dynamic item = widget.item;
    String itemName = widget.itemName;
    String itemType = widget.itemType;
    String itemImageURL = widget.itemImageURL;
    String itemDescription = widget.itemDescription;
    List<String> comments = widget.comments;
    List<Widget> additionalInfo = widget.additionalInfo;
    Color themeColor = widget.themeColor;
    Size size = MediaQuery.of(context).size;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color textColor = isDarkMode ? Colors.white : Colors.black;
    Color backgroundColor = isDarkMode ? Colors.black : Colors.white;

    List<String> commenterNames = ['Dhavish_69😎🔥', 'Gina_23❤️'];

    addUserComment() {
      final textColor = Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black;
      final themeColor = widget.themeColor;

      return showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Allows the sheet to resize when keyboard appears
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (BuildContext context) {
          return FractionallySizedBox(
            heightFactor: 0.6,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
              ),
              child: SingleChildScrollView( // Allows scrolling when the keyboard is open
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Avoid unnecessary extra space
                    children: [
                      const Text(
                        'Add Comment',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black, // Matching the settings title color
                        ),
                      ),
                      const Divider(height: 24, color: Colors.grey),
                      TextFormField(
                        controller: commentsController,
                        autofocus: true,
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          hintText: 'Write your comment...',
                          hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: themeColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: themeColor, width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          onPressed: () async {
                            await addComment(
                              widget.itemType + widget.item.id.toString(),
                              commentsController.text,
                            );
                            ScaffoldMessenger.of(context)
                              ..clearSnackBars()
                              ..showSnackBar(
                                const SnackBar(content: Text("Successfully Commented!")),
                              );
                            Navigator.pop(context);
                            setState(() => commentsController.clear());
                          },
                          child: const Text('Post'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }


    userCommentSettings(String curComment) {
      return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (BuildContext context) {
          return FractionallySizedBox(
            heightFactor: 0.3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Comment Options',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.edit, color: Colors.blue),
                    title: const Text(
                      'Edit Comment',
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      commentsController.text = curComment;
                      addUserComment();
                    },
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.delete, color: Colors.red),
                    title: const Text(
                      'Delete Comment',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    onTap: () async {
                      Navigator.pop(context);
                      final confirm = await showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Delete Comment'),
                          content: const Text(
                              'This action cannot be undone. Are you sure you want to permanently delete this comment?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () async {
                                await deleteComment(itemType + item.id.toString());
                                ScaffoldMessenger.of(context)
                                  ..clearSnackBars()
                                  ..showSnackBar(
                                    const SnackBar(
                                        content: Text("Comment deleted successfully")),
                                  );
                                Navigator.pop(context, true);
                                setState(() {});
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.5,
            child: Image.asset(
              itemImageURL,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              height: size.height * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemName,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          itemDescription,
                          style: TextStyle(fontSize: 16, color: textColor),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Get Location Button
                            Expanded(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: themeColor,
                                    radius: 24,
                                    child: IconButton(
                                      icon: const Icon(Icons.location_on, color: Colors.white),
                                      onPressed: () {
                                        launchUrlString("https://www.google.com/maps/search/?api=1&query="+item.urlCode);
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text('Location', style: TextStyle(color: textColor)),
                                ],
                              ),
                            ),
                            //const SizedBox(width: 20),
                            // Book Button
                            Expanded(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: themeColor,
                                    radius: 24,
                                    child: IconButton(
                                      icon: const Icon(Icons.book, color: Colors.white),
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (BuildContext context) {
                                            return SizedBox(
                                              height: size.height * 0.6,
                                              child: TableCalendar(
                                                focusedDay: DateTime.now(),
                                                firstDay: DateTime.utc(2020, 01, 01),
                                                lastDay: DateTime.utc(2030, 12, 31),
                                                onDaySelected: (selectedDay, focusedDay) {
                                                  var days = getDays(selectedDay);
                                                  if(days < 2){
                                                    ScaffoldMessenger.of(context).clearSnackBars();
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text("Failed: You can only set a schedule three or more days in the future!")),
                                                    );
                                                  }else{
                                                    ScaffoldMessenger.of(context).clearSnackBars();
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text("Successfully Scheduled!")),
                                                    );
                                                    addSchedule(item.id, itemType, selectedDay);
                                                  }
                                                  //addSchedule(item.id, itemType, selectedDay);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text('Schedule', style: TextStyle(color: textColor)),
                                ],
                              ),
                            ),
                            //const SizedBox(width: 20),
                            // Favorite Button
                            Expanded(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: themeColor,
                                    radius: 24,
                                    child: IconButton(
                                      icon: checkIfFavourite(item.id, itemType)? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border, color: Colors.white),
                                      onPressed: () {
                                        var msg = "";
                                        if(checkIfFavourite(item.id, itemType)){
                                          removeFavouriteFull(item.id, itemType);
                                          msg = "Successfully removed from favourites!";
                                        }else{
                                          addFavourite(item.id, itemType);
                                          msg = "Successfully added to favourites!";
                                        }
                                        setState(() {
                                          ScaffoldMessenger.of(context).clearSnackBars();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text(msg)),
                                          );
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text('Favorite', style: TextStyle(color: textColor)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Rating: ${item.rating} ',
                                style: TextStyle(fontSize: 16, color: textColor),
                              ),
                              Row(
                                children: List.generate(1, (index) {
                                  return Icon(
                                    index < item.rating ? Icons.star : Icons.star_border,
                                    color: Colors.yellow,
                                    size: 25,
                                  );
                                }),
                              ),
                            ],
                          ),
                          ...additionalInfo,
                          const SizedBox(height: 16),
                          Text(
                            'Comments',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
                          ),
                          const SizedBox(height: 8),
                          FutureBuilder<Widget>(
                              future: commentsBuilder(itemType+item.id.toString(),MediaQuery.sizeOf(context).width, textColor, userCommentSettings, addUserComment, AuthService().getCurrentUser()),
                              builder: (BuildContext context, AsyncSnapshot<Widget> widget, ){
                                if(widget.connectionState == ConnectionState.done){
                                  if (!widget.hasData) {
                                    print(widget.error);
                                    return Center(
                                        child: Text('Something went wrong....')
                                    );
                                  }else{
                                    return widget.requireData;
                                  }
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 19,
            child: Material(
              color: Colors.transparent, // Make sure the material doesn't cover anything
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(30), // Circular tap area
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  radius: 20, // Adjust size of the avatar (larger if needed)
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20, // Icon size
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
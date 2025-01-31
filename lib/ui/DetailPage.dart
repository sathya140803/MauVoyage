import 'package:flutter/material.dart';
import 'package:my_application/data_model/Beach.dart'; // Import the Beach model
import 'package:my_application/data_model/Forest.dart'; // Import the Forest model
import 'package:my_application/data_model/Activity.dart'; // Import the Activity model
import 'package:my_application/data_model/NightClubEvent .dart'; // Import the NightClubEvent model
import 'package:my_application/data_model/PlaceOfInterest.dart'; // Import the PlaceOfInterest model
import 'package:table_calendar/table_calendar.dart'; // Import the custom_calendar_picker package



class DetailPage extends StatelessWidget {
  final dynamic item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return CommonDetailLayout(
      item: item,
      itemName: getItemName(),
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


  Color getThemeColor() {
    if (item is Beach) return Colors.blueAccent;
    if (item is Forest) return Colors.greenAccent;
    if (item is Activity) return Colors.orangeAccent;
    if (item is NightClubEvent) return Colors.deepPurple;
    if (item is PlaceOfInterest) return Colors.teal;
    return Colors.grey;
  }
}

class CommonDetailLayout extends StatelessWidget {
  final dynamic item;
  final String itemName;
  final String itemImageURL;
  final String itemDescription;
  final List<String> comments;
  final List<Widget> additionalInfo;
  final Color themeColor;

  const CommonDetailLayout({
    super.key,
    required this.item,
    required this.itemName,
    required this.itemImageURL,
    required this.itemDescription,
    required this.comments,
    required this.additionalInfo,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color textColor = isDarkMode ? Colors.white : Colors.black;
    Color backgroundColor = isDarkMode ? Colors.black : Colors.white;

    List<String> commenterNames = ['Dhavish_69😎🔥', 'Gina_23❤️'];
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
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: themeColor,
                                  radius: 24,
                                  child: IconButton(
                                    icon: const Icon(Icons.location_on, color: Colors.white),
                                    onPressed: () {
                                      // Implement location functionality
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text('Get Location', style: TextStyle(color: textColor)),
                              ],
                            ),
                            const SizedBox(width: 20),
                            // Book Button
                            Column(
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
                                          return Container(
                                            height: size.height * 0.6,
                                            child: TableCalendar(
                                              focusedDay: DateTime.now(),
                                              firstDay: DateTime.utc(2020, 01, 01),
                                              lastDay: DateTime.utc(2030, 12, 31),
                                              onDaySelected: (selectedDay, focusedDay) {
                                                // Perform booking logic here
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
                                Text('Book', style: TextStyle(color: textColor)),
                              ],
                            ),
                            const SizedBox(width: 20),
                            // Favorite Button
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: themeColor,
                                  radius: 24,
                                  child: IconButton(
                                    icon: const Icon(Icons.favorite_border, color: Colors.white),
                                    onPressed: () {
                                      // Implement favoriting functionality
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text('Favorite', style: TextStyle(color: textColor)),
                              ],
                            ),
                            const SizedBox(width: 20),
                            // Share Button
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: themeColor,
                                  radius: 24,
                                  child: IconButton(
                                    icon: const Icon(Icons.share, color: Colors.white),
                                    onPressed: () {
                                      // Implement share functionality
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text('Share', style: TextStyle(color: textColor)),
                              ],
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
                            'What does people say:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
                          ),
                          const SizedBox(height: 8),
                          ...comments.asMap().entries.map((entry) {
                            int index = entry.key;
                            String comment = entry.value;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipOval(
                                    child: Image.asset(
                                      index == 0 ? item.imageURL2 : item.imageURL3,
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
                                        commenterNames[index],
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textColor),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.75,
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
                          }),
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

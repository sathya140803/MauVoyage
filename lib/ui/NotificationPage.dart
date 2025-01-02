// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
//
// class NotificationPage extends StatelessWidget {
//   const NotificationPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Sample notifications
//     final List<Map<String, String>> notifications = [
//       {
//         "title": "New Destination Added!",
//         "description": "Discover the beautiful Le Morne Brabant.",
//         "time": "2 hours ago",
//         "image": "https://thewandertherapy.com/wp-content/uploads/2024/02/3.scuba-diving-andaman-1200x900.jpg", // Example image URL
//       },
//       {
//         "title": "Booking Reminder",
//         "description": "Your booking for Scuba Diving is tomorrow.",
//         "time": "1 day ago",
//         "image": "https://example.com/destination2.jpg", // Example image URL
//       },
//       {
//         "title": "Special Offer",
//         "description": "50% off on Chamarel Seven Colored Earth tours!",
//         "time": "3 days ago",
//         "image": "https://example.com/offer.jpg", // Example image URL
//       },
//       {
//         "title": "Explore New Restaurants",
//         "description": "Try the latest seafood specials at Ocean's Delight.",
//         "time": "1 week ago",
//         "image": "https://example.com/restaurant.jpg", // Example image URL
//       },
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Notifications"),
//         backgroundColor: Colors.teal,
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: notifications.length,
//         itemBuilder: (context, index) {
//           final notification = notifications[index];
//
//           return Slidable(
//             // Use the correct action pane
//             startActionPane: ActionPane(
//               motion: const DrawerMotion(), // Slide motion
//               dismissible: DismissiblePane(onDismissed: () {
//                 // Handle dismiss
//               }),
//               children: [
//                 SlidableAction(
//                   onPressed: (context) {
//                     // Handle mark as read action
//                   },
//                   backgroundColor: Colors.green,
//                   icon: Icons.check,
//                   label: 'Mark as Read', // Add label
//                 ),
//               ],
//             ),
//             child: Card(
//               margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(notification["image"]!),
//                   radius: 25,
//                 ),
//                 title: Text(
//                   notification["title"]!,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       notification["description"]!,
//                       style: const TextStyle(color: Colors.black87),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       notification["time"]!,
//                       style: const TextStyle(color: Colors.grey, fontSize: 12),
//                     ),
//                   ],
//                 ),
//                 trailing: const Icon(
//                   Icons.arrow_forward_ios,
//                   size: 16,
//                   color: Colors.grey,
//                 ),
//                 onTap: () {
//                   // Handle notification tap
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../data_model/PlaceOfInterest.dart';
//
//
// class DetailPage extends StatefulWidget {
//   const DetailPage({super.key, required this.placeId});
//   final int placeId;
//
//   @override
//   State<DetailPage> createState() => _DetailPageState();
// }
//
// class _DetailPageState extends State<DetailPage> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     List<PlaceOfInterest> placeList = PlaceOfInterest.placeList;
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Top Half: Fullscreen Image
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             height: size.height * 0.5,
//             child: Image.asset(
//               placeList[widget.placeId].imageURL,
//               fit: BoxFit.cover,
//             ),
//           ),
//           // Close and Favorite Icons
//           Positioned(
//             top: size.height * 0.05, // Responsive padding
//             left: size.width * 0.05,
//             right: size.width * 0.05,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     Icons.arrow_back_ios,
//                     color: Colors.black,
//                     size: size.width * 0.07,
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//
//               ],
//             ),
//           ),
//
//
//           // Bottom Half: Place Features
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: EdgeInsets.symmetric(
//                 horizontal: size.width * 0.07,
//                 vertical: size.height * 0.02,
//               ),
//               height: size.height * 0.6,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Place Name with Rating and Stars
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           placeList[widget.placeId].placeName,
//                           style: TextStyle(
//                             fontSize: size.width * 0.06,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             placeList[widget.placeId].rating.toString(),
//                             style: TextStyle(
//                               fontSize: size.width * 0.045,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           SizedBox(width: size.width * 0.01),
//                           Row(
//                             children: List.generate(
//                               3,
//                                   (index) => Icon(Icons.star, size: size.width * 0.06, color: Colors.yellow),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: size.height * 0.015),
//                   // About Section
//                   PlaceFeature(
//                     title: 'About',
//                     placeFeature: placeList[widget.placeId].description.toString(),
//                   ),
//                   SizedBox(height: size.height * 0.03),
//                   // Row of Icons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       IconAction(
//                         icon: Icons.location_on,
//                         label: "Get Location",
//                         size: size,
//                         onTap: () {
//                           // Add functionality for "Get Location" here
//                         },
//                       ),
//                       IconAction(
//                         icon: Icons.calendar_today,
//                         label: "Book Now",
//                         size: size,
//                         onTap: () {
//                           // Add functionality for "Book Now" here
//                         },
//                       ),
//                       IconAction(
//                         icon: Icons.favorite,
//                         label: "Favorite",
//                         size: size,
//                         onTap: () {
//                           // Add functionality for "Favorite" here
//                         },
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: size.height * 0.02),
//                   // What does people say Section
//                   Text(
//                     'What do people say :',
//                     style: TextStyle(
//                       fontSize: size.width * 0.05,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   SizedBox(height: size.height * 0.015),
//                   // Comments Section
//                   CommentsSection(placeList: placeList, size: size, placeId: widget.placeId),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class IconAction extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Size size;
//   final VoidCallback onTap;
//
//   const IconAction({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.size,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Icon(icon, color: Colors.black, size: size.width * 0.07),
//           SizedBox(height: size.height * 0.005),
//           Text(
//             label,
//             style: TextStyle(fontSize: size.width * 0.03, color: Colors.black),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CommentsSection extends StatelessWidget {
//   final List<PlaceOfInterest> placeList;
//   final Size size;
//   final int placeId;
//
//   const CommentsSection({
//     super.key,
//     required this.placeList,
//     required this.size,
//     required this.placeId,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CommentCard(
//           size: size,
//           imageURL: placeList[placeId].imageURL2,
//           name: "Dhavish",
//           comment: placeList[placeId].comment2,
//         ),
//         SizedBox(height: size.height * 0.02),
//         CommentCard(
//           size: size,
//           imageURL: placeList[placeId].imageURL3,
//           name: "Gina_lenati",
//           comment: placeList[placeId].comment1,
//         ),
//       ],
//     );
//   }
// }
//
// class CommentCard extends StatelessWidget {
//   final Size size;
//   final String imageURL;
//   final String name;
//   final String comment;
//
//   const CommentCard({
//     super.key,
//     required this.size,
//     required this.imageURL,
//     required this.name,
//     required this.comment,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         ClipOval(
//           child: Image.asset(
//             imageURL,
//             width: size.width * 0.1,
//             height: size.width * 0.1,
//             fit: BoxFit.cover,
//           ),
//         ),
//         SizedBox(width: size.width * 0.03),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     name,
//                     style: TextStyle(
//                       fontSize: size.width * 0.04,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                     ),
//                   ),
//                   SizedBox(width: size.width * 0.02),
//                   Row(
//                     children: List.generate(3, (index) => Icon(Icons.star, size: size.width * 0.04, color: Colors.yellow)),
//                   ),
//                 ],
//               ),
//               SizedBox(height: size.height * 0.005),
//               Text(
//                 comment,
//                 style: TextStyle(
//                   fontSize: size.width * 0.035,
//                   color: Colors.black,
//                 ),
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class PlaceFeature extends StatelessWidget {
//   final String placeFeature;
//   final String title;
//
//   const PlaceFeature({
//     super.key,
//     required this.placeFeature,
//     required this.title,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             color: Colors.black87,
//             fontSize: 19.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           placeFeature,
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 15.0,
//           ),
//           maxLines: 4,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ],
//     );
//   }
// }
//

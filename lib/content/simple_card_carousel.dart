// import 'package:flutter/material.dart';
// import 'package:my_application/data_model/Beach.dart';
// //import 'package:my_application/ui/DetailPage.dart';
//
// class SimpleCardCarousel extends StatelessWidget {
//   final List<Beach> beaches = Beach.beachList;
//
//   SimpleCardCarousel({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200, // Adjust height as per design
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: beaches.map((beach) {
//             return GestureDetector(
//               // onTap: () {
//               //   Navigator.push(
//               //     context,
//               //     MaterialPageRoute(
//               //       builder: (context) => DetailPage(beach: beach),
//               //     ),
//               //   );
//               // },
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   // Card Image
//                   Container(
//                     width: 150,
//                     height: 180,
//                     margin: const EdgeInsets.symmetric(horizontal: 8),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       image: DecorationImage(
//                         image: AssetImage(beach.imageURL),
//                         fit: BoxFit.cover,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.3),
//                           offset: const Offset(0, 4),
//                           blurRadius: 8,
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Title Overlay
//                   Container(
//                     width: 150,
//                     height: 180,
//                     decoration: BoxDecoration(
//                       color: Colors.black45,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Center(
//                       child: Text(
//                         beach.name,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
//
// class DetailPage extends StatelessWidget {
//   final Beach beach;
//
//   const DetailPage({required this.beach, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(beach.name),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Main Image
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.asset(beach.imageURL),
//             ),
//             const SizedBox(height: 16),
//             // Name and Rating
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   beach.name,
//                   style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 Row(
//                   children: [
//                     const Icon(Icons.star, color: Colors.amber),
//                     Text(
//                       beach.rating.toString(),
//                       style: const TextStyle(fontSize: 18),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             // Description
//             Text(
//               beach.description,
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 16),
//             // Entry Fee and Opening Hours
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Entry Fee: ${beach.entryFee}',
//                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 Text(
//                   'Hours: ${beach.openingHours}',
//                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             // Comments
//             const Text(
//               'Comments:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text('- ${beach.comment1}', style: const TextStyle(fontSize: 16)),
//             const SizedBox(height: 8),
//             Text('- ${beach.comment2}', style: const TextStyle(fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }
// }

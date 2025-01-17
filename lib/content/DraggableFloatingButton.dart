// import 'package:flutter/material.dart';
// import 'package:my_application/ui/translate.dart'; // Import your necessary pages
//
// class DraggableFloatingButton extends StatefulWidget {
//   @override
//   _DraggableFloatingButtonState createState() => _DraggableFloatingButtonState();
// }
//
// class _DraggableFloatingButtonState extends State<DraggableFloatingButton> {
//   Offset position = Offset(25, 100); // Initial position
//   bool isOpen = false; // State for small buttons (open or closed)
//
//   // Define sizes for buttons
//   final double buttonSize = 60.0;
//   final double smallButtonSize = 50.0;
//   final double buttonOffset = 10.0; // Spacing between the main button and small buttons
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned(
//           left: position.dx,
//           top: position.dy,
//           child: Draggable(
//             feedback: _buildButton(),
//             childWhenDragging: Container(),
//             onDragEnd: (details) {
//               double newX = details.offset.dx - (buttonSize / 2);
//               double newY = details.offset.dy - (buttonSize / 2);
//
//               // Get the screen size for boundary checks
//               double screenWidth = MediaQuery.of(context).size.width;
//               double screenHeight = MediaQuery.of(context).size.height;
//
//               setState(() {
//                 // Update position with screen bounds
//                 position = Offset(
//                   newX.clamp(0.0, screenWidth - buttonSize),
//                   newY.clamp(0.0, screenHeight - buttonSize),
//                 );
//               });
//             },
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   isOpen = !isOpen; // Toggle state for small buttons
//                 });
//               },
//               child: _buildButton(),
//             ),
//           ),
//         ),
//         // Vertical column for small buttons with roll-out animation
//         if (isOpen) ...[
//           // Use AnimatedPositioned for a roll-out effect
//           AnimatedPositioned(
//             duration: Duration(milliseconds: 300),
//             left: position.dx,
//             top: position.dy + buttonSize + buttonOffset,
//             child: _buildSmallButton(
//               icon: Icons.language,
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => TranslatePage()),
//                 );
//               },
//             ),
//           ),
//           AnimatedPositioned(
//             duration: Duration(milliseconds: 300),
//             left: position.dx,
//             top: position.dy + buttonSize + buttonOffset + smallButtonSize + buttonOffset,
//             child: _buildSmallButton(
//               icon: Icons.camera_alt,
//               onTap: () {
//                 // Add navigation to another page
//               },
//             ),
//           ),
//           AnimatedPositioned(
//             duration: Duration(milliseconds: 300),
//             left: position.dx,
//             top: position.dy + buttonSize + buttonOffset + 2 * (smallButtonSize + buttonOffset),
//             child: _buildSmallButton(
//               icon: Icons.map,
//               onTap: () {
//                 // Add navigation to another page
//               },
//             ),
//           ),
//         ],
//       ],
//     );
//   }
//
//   Widget _buildButton() {
//     return Container(
//       width: buttonSize,
//       height: buttonSize,
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         shape: BoxShape.circle,
//       ),
//       child: const Icon(Icons.add, color: Colors.white),
//     );
//   }
//
//   Widget _buildSmallButton({
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: smallButtonSize,
//         height: smallButtonSize,
//         decoration: BoxDecoration(
//           color: Colors.blue,
//           shape: BoxShape.circle,
//         ),
//         child: Icon(icon, color: Colors.white),
//       ),
//     );
//   }
// }
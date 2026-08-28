import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'font_provider.dart';

class FontSizeSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Font Size Settings"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Adjust Font Size title with enhanced styling
            Text(
              "Adjust Font Size",
              style: TextStyle(
                fontSize: 24.0, // Larger size for better visibility
                fontWeight: FontWeight.bold,
                color: Colors.teal[800], // Using a color for a pop effect
              ),
            ),
            SizedBox(height: 20), // Spacing for better layout

            // Slider with improved visual layout
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "12",
                  style: TextStyle(fontSize: 16.0),
                ),
                Expanded(
                  child: Slider(
                    value: fontSizeProvider.fontSize,
                    min: 12.0,
                    max: 24.0,
                    divisions: 12, // More divisions for finer control
                    label: fontSizeProvider.fontSize.toStringAsFixed(1),
                    activeColor: Colors.teal, // Custom color for the slider
                    inactiveColor: Colors.teal[100], // Slight color for inactive part
                    onChanged: (newSize) {
                      fontSizeProvider.setFontSize(newSize);
                    },
                  ),
                ),
                Text(
                  "24",
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(height: 20), // Spacing for visual separation

            // Container to center "We love Mauritius" text
            Container(
              alignment: Alignment.center, // Center the text
              padding: EdgeInsets.all(20.0), // Padding for the text
              margin: EdgeInsets.only(top: 10.0), // Top margin for spacing
              decoration: BoxDecoration(
                color: Colors.teal[50], // Light teal color for the box
                borderRadius: BorderRadius.circular(10.0), // Rounded corners
                border: Border.all(color: Colors.teal, width: 1.0), // Border for the box
              ),
              child: Text(
                "We love Mauritius",
                style: TextStyle(
                  fontSize: fontSizeProvider.fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[600], // Color matching the theme
                ),
              ),
            ),
            SizedBox(height: 20), // Spacing for aesthetics

            // Center the Reset button under the text box
            Center(
              child: ElevatedButton(
                onPressed: () {
                  fontSizeProvider.setFontSize(16.0); // Set to default size
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Button color
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                ),
                child: Text(
                  "Reset to Default",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
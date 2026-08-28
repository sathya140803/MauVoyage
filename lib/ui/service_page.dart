import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'currency_converter_page.dart';
import 'translation/TranslationPage.dart';
import 'TransportationPage.dart';
import 'package:my_application/ui/settings/font_provider.dart'; // Make sure to import FontSizeProvider

class ServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get dynamic font size from FontSizeProvider
    double fontSize = Provider.of<FontSizeProvider>(context).fontSize;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Services',
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ServiceCard(
              title: 'Currency Converter',
              description: 'Convert currencies in real time',
              icon: Icons.attach_money,
              backgroundImage: 'assets/currency.jpg',
              fontSize: fontSize, // Passing font size to ServiceCard
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CurrencyConverterPage()),
                );
              },
            ),
            SizedBox(height: 20),
            ServiceCard(
              title: 'Translation',
              description: 'Translate text instantly',
              icon: Icons.translate,
              backgroundImage: 'assets/language.jpg',
              fontSize: fontSize, // Passing font size to ServiceCard
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TranslationPage()),
                );
              },
            ),
            SizedBox(height: 20),
            ServiceCard(
              title: 'Transportation',
              description: 'Get your local bus on time',
              icon: Icons.emoji_transportation_outlined,
              backgroundImage: 'assets/bus.webp',
              fontSize: fontSize, // Passing font size to ServiceCard
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransportationPage()),
                );
              },
            ),

            SizedBox(height: 40),
            Center(
              child: Text(
                'More services coming soon...',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String backgroundImage;
  final VoidCallback onTap;
  final double fontSize; // Added fontSize parameter

  ServiceCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.backgroundImage,
    required this.onTap,
    required this.fontSize, // Initialize fontSize
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withOpacity(0.5),
            ),
            child: Row(
              children: [
                Icon(icon, size: 40, color: Colors.white),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: fontSize, // Applying dynamic font size
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        description,
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
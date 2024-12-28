import 'package:flutter/material.dart';

class KidsClubPage extends StatelessWidget {
  const KidsClubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kids Club'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade200, // Light purple
              Colors.purple.shade700, // Darker purple
            ],
          ),
        ),
        child: const Center(
          child: Text(
            'Welcome to the Kids Club Page!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

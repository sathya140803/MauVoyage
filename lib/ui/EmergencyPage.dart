import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmergencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Page'),
      ),
      body: Center(
        child: Text(
          'Emergency actions go here!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class CalenderPage extends StatelessWidget {
  const CalenderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Center(
        child: const Text(
          'This is the Calendar Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

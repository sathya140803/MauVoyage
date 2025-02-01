import 'package:flutter/material.dart';

class CalenderPage extends StatelessWidget {
  const CalenderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camendar'),
      ),
      body: Center(
        child: const Text(
          'This is the Calendarlll Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransportationPage extends StatelessWidget {
  String getMauritianTime() {
    DateTime now = DateTime.now().toUtc().add(Duration(hours: 4)); // Mauritius is UTC+4
    return DateFormat('hh:mm a').format(now);
  }

  List<BusSchedule> busSchedules = [
    BusSchedule(route: "Port Louis to Curepipe", time: "9:00 AM", stops: "Port Louis, Phoenix, Curepipe"),
    BusSchedule(route: "Curepipe to Quatre Bornes", time: "9:30 AM", stops: "Curepipe, Quatre Bornes"),
    BusSchedule(route: "Quatre Bornes to Rose Hill", time: "10:00 AM", stops: "Quatre Bornes, Rose Hill"),
    BusSchedule(route: "Rose Hill to Port Louis", time: "10:30 AM", stops: "Rose Hill, Port Louis"),
    BusSchedule(route: "Curepipe to Flic en Flac", time: "11:00 AM", stops: "Curepipe, Cascavelle, Flic en Flac"),
    BusSchedule(route: "Port Louis to Mahebourg", time: "11:30 AM", stops: "Port Louis, Plaine Magnien, Mahebourg"),
    BusSchedule(route: "Curepipe to Vacoas", time: "12:00 PM", stops: "Curepipe, Vacoas"),
    BusSchedule(route: "Vacoas to Curepipe", time: "12:30 PM", stops: "Vacoas, Curepipe"),
    BusSchedule(route: "Port Louis to Grand Baie", time: "1:00 PM", stops: "Port Louis, Pamplemousses, Grand Baie"),
    BusSchedule(route: "Curepipe to Belle Mare", time: "1:30 PM", stops: "Curepipe, Belle Mare"),
    // Additional bus routes can be added here as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transportation'),
        backgroundColor: Colors.teal, // Changed AppBar background color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Local Time: ${getMauritianTime()}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal), // Increased font color
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: busSchedules.length,
                itemBuilder: (context, index) {
                  final bus = busSchedules[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    color: Colors.lightBlue[50], // New background color for the cards
                    elevation: 2, // Adding some elevation for a shadow effect
                    child: ListTile(
                      title: Text(bus.route,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal[800])), // Customized title color
                      subtitle: Text('${bus.time} - ${bus.stops}',
                          style: TextStyle(color: Colors.black54)), // Gray color for subtitle
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BusSchedule {
  final String route;
  final String time;
  final String stops;

  BusSchedule({required this.route, required this.time, required this.stops});
}
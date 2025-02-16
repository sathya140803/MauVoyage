import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';



Widget _buildSwitchTile({
  required String title,
  required String subtitle,
  required String number
}) {
  return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      elevation: 2,
      child: TextButton(
        onPressed: (){
          launchUrlString("tel:"+number);
        },
        child: ListTile(
          leading: Icon(Icons.emergency, color: Colors.red),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Icon(Icons.call),
        ),
      )
  );
}




class EmergencyPage extends StatelessWidget {
  const EmergencyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Emergency'),
          backgroundColor: Colors.red,
        ),
        body: ListView(
          children: [
            _buildSwitchTile(title: "Airport Police", subtitle: "6377320", number: "6377320"),
            _buildSwitchTile(title: "Ambulance (SAMU)", subtitle: "114", number: "114"),
            _buildSwitchTile(title: "Emergency (Police)", subtitle: "999", number: "999"),
            _buildSwitchTile(title: "Fire & Rescue", subtitle: "115", number: "115"),
            _buildSwitchTile(title: "National Coast Guard Hotline", subtitle: "177", number: "177"),
            _buildSwitchTile(title: "Police Hotline", subtitle: "148", number: "148"),
            _buildSwitchTile(title: "Tourist Info", subtitle: "152", number: "152"),
          ],
        )
    );
  }
}

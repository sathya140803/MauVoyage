import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_application/notification_schedule/notification_controller.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkNotification() async{
  if(await Permission.notification.isPermanentlyDenied || await Permission.notification.isDenied){
    return false;
  }
  return true;

}

class NotificationSettingsPage extends StatefulWidget{
  const NotificationSettingsPage({Key? key}) : super(key: key);

  @override
  _NotificationSettingsPage createState() => _NotificationSettingsPage();
}


class _NotificationSettingsPage extends State<NotificationSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Notification Settings')),
        body: FutureBuilder(
            future: checkNotification(),
            builder: (BuildContext context, AsyncSnapshot<bool> widget){
              var userSettings = GetStorage().read("NotificationSettings");
              userSettings = jsonDecode(userSettings);
              if(widget.connectionState == ConnectionState.done){
                if (!widget.hasData) {
                  print(widget.error);
                  return Center(
                      child: Text('Something went wrong....')
                  );
                }else{
                  if(widget.requireData == false){
                    return Center(
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Please turn on Notification settings in the app."),
                            TextButton(
                                onPressed: (){
                                  SystemNavigator.pop();
                                  openAppSettings();
                                },
                                child: Text("Go to App Settings")
                            )
                          ],
                        )
                    );
                  }

                  return ListView(
                      children: [
                        Card(
                          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                          elevation: 2,
                          child: ListTile(
                            leading: Icon(Icons.notification_important_outlined),
                            title: Text("Scheduled Notifications"),
                            subtitle: Text("Notifies the user about a schedule a day before"),
                            trailing: Switch(
                              value: userSettings["ScheduledNotification"],
                              onChanged: (value) {
                                if(value){
                                  userSettings["ScheduledNotification"] = true;
                                  cancelAllNotifications();
                                  rebuildNotifications();
                                }else{
                                  userSettings["ScheduledNotification"] = false;
                                  cancelAllNotifications();
                                }
                                userSettings = jsonEncode(userSettings);
                                GetStorage().write("NotificationSettings", userSettings);
                                setState(() {

                                });
                                //Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Card(
                          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                          elevation: 2,
                          child: ListTile(
                            leading: Icon(Icons.notification_important_outlined),
                            title: Text("In-App Notifications"),
                            subtitle: Text("Notifies the user about number of current day schedule."),
                            trailing: Switch(
                              value: userSettings["InAppNotification"],
                              onChanged: (value) {
                                if(value){
                                  userSettings["InAppNotification"] = true;
                                }else{
                                  userSettings["InAppNotification"] = false;
                                }
                                userSettings = jsonEncode(userSettings);
                                GetStorage().write("NotificationSettings", userSettings);
                                setState(() {

                                });
                                //Navigator.pop(context);
                              },
                            ),
                          ),
                        )
                      ]
                  );
                }
              }
              return ListView(
                  children: [
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                      elevation: 2,
                      child: ListTile(
                        leading: Icon(Icons.notification_important_outlined),
                        title: Text("Scheduled Notifications"),
                        subtitle: Text("Notifies the user about a schedule a day before"),
                        trailing: Switch(
                          value: userSettings["ScheduledNotification"],
                          onChanged: (bool value) {  },
                        ),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                      elevation: 2,
                      child: ListTile(
                        leading: Icon(Icons.notification_important_outlined),
                        title: Text("In-App Notifications"),
                        subtitle: Text("Notifies the user about number of current day schedule."),
                        trailing: Switch(
                          value: userSettings["InAppNotification"],
                          onChanged: (bool value) {  },
                        ),
                      ),
                    )
                  ]
              );
            }
        )
    );
  }
}
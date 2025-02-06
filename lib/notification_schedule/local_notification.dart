import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotification{
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future init() async{

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings();
    final LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(
        defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        macOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: null);
  }

  static Future setScheduleTime(int id, var title, var description,int rDays) async{
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.local);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        description,
        tz.TZDateTime.now(tz.local).add(Duration(days: rDays)),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'channel 1', 'your channel name',
             channelDescription: 'your channel description'
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
    );
  }

  static Future inAppNotification(var title, var description) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, title, description, notificationDetails);
  }

  static Future cancelWithId(id) async{
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future cancelAll() async{
    await flutterLocalNotificationsPlugin.cancelAll();
  }

}
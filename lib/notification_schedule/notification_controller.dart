import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:my_application/notification_schedule/local_notification.dart';
import 'notification_builder.dart';

int getDays(DateTime to){
  var cur = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var to2 = DateTime(to.year, to.month, to.day);
  return (to2.difference(cur).inHours/24).round() - 1;
}

addNotification(notification noti){
  String separator = ",";

  if(GetStorage().read("notifications") == null || GetStorage().read("notifications") == ""){
    separator = "";
  }

  String json = jsonEncode(noti.toJson());
  String current = GetStorage().read("notifications")?? "";
  String fin = current + separator + json;

  var days = getDays(DateTime.parse(noti.showTime));

  LocalNotification.setScheduleTime(noti.id, noti.type, noti.description + " tomorrow!", days);

  GetStorage().write("notifications", fin);
}

int getCurrentNotificationCount(){
  var list = getNotifications();
  int len = 0;
  for(int i = 0; i < list.length; i++){
    if(DateTime.parse(list[i]["showTime"]).isBefore(DateTime.now())){
      len += 1;
    }
  }
  return len;
}

removeNotification(int listId){
  var notifications = getNotifications();
  notifications.removeAt(listId);
  String finalString = "";
  String seperator = ",";

  for(int i = 0; i < notifications.length; i++){
    if(i == notifications.length - 1){
      seperator = "";
    }
    dynamic curnotif = notifications[i];
    notification newnotif = notification(curnotif["description"], curnotif["id"], curnotif["type"], curnotif["itemId"], curnotif["itemType"], curnotif["showTime"]);
    finalString = finalString + jsonEncode(newnotif.toJson()) + seperator;
  }
  GetStorage().write("notifications", finalString);
}

removeNotificationWithId(var id){
  var notifications = getNotifications();
  LocalNotification.cancelWithId(id);
  String finalString = "";
  String seperator = ",";
  for(int i = 0; i < notifications.length; i++){
    if(notifications[i]["id"] == id){
      notifications.removeAt(i);
      continue;
    }
  }

  for(int i = 0; i < notifications.length; i++){
    if(i == notifications.length - 1){
      seperator = "";
    }
    dynamic curnotif = notifications[i];
    notification newnotif = notification(curnotif["description"], curnotif["id"], curnotif["type"], curnotif["itemId"], curnotif["itemType"], curnotif["showTime"]);
    finalString = finalString + jsonEncode(newnotif.toJson()) + seperator;
  }
  GetStorage().write("notifications", finalString);
}

List<dynamic> getNotifications(){
  String json = GetStorage().read("notifications")?? "";
  json = "["+json+"]";
  var mylist = jsonDecode(json).toList();
  return mylist;
}
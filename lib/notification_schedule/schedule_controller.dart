import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:my_application/data_model/Activity.dart';
import 'package:my_application/data_model/Beach.dart';
import 'package:my_application/data_model/Forest.dart';
import 'package:my_application/data_model/NightClubEvent%20.dart';
import 'package:my_application/data_model/PlaceOfInterest.dart';
import 'package:my_application/notification_schedule/local_notification.dart';
import 'package:my_application/notification_schedule/notification_builder.dart';
import 'package:my_application/notification_schedule/notification_controller.dart';
import 'package:my_application/notification_schedule/schedule_builder.dart';


getItem(int id, String type){
  if (type == "Beach") return Beach.beachList[id];
  if (type == "Forest") return Forest.forestList[id];
  if (type == "Activity") return Activity.activityList[id];
  if (type == "NightClubEvent") return NightClubEvent.nightClubList[id];
  if (type == "PlaceOfInterest") return PlaceOfInterest.placeList[id];
  return "";
}


addSchedule(int itemId, String itemType, DateTime date){
  String separator = ",";

  if(GetStorage().read("schedules") == null || GetStorage().read("schedules") == ""){
    separator = "";
  }

  if(GetStorage().read("notification_id") == null){
    GetStorage().write("notification_id",-1);
  }
  GetStorage().write("notification_id", GetStorage().read("notification_id")+1);
  schedule sche = schedule(date.toString(), itemId, itemType, GetStorage().read("notification_id"));



  String json = jsonEncode(sche.toJson());
  String current = GetStorage().read("schedules")?? "";
  String fin = current + separator + json;


  var showTime = DateTime(date.year, date.month, date.day-1);
  var item = getItem(itemId, itemType);

  addNotification(notification("Your scheduling for ${item.name} is due for", GetStorage().read("notification_id"), "Reminder", itemId, itemType, showTime.toString()));


  GetStorage().write("schedules", fin);
}

removeSchedule(int listId){
  var schedules = getSchedules();
  //if(DateTime.now().isBefore(DateTime.parse(schedules[listId]["date"]))){
    removeNotificationWithId(schedules[listId]["notificationId"]);
  //}

  schedules.removeAt(listId);
  String finalString = "";
  String seperator = ",";

  for(int i = 0; i < schedules.length; i++){
    if(i == schedules.length - 1){
      seperator = "";
    }
    dynamic cursche = schedules[i];
    schedule newsche = schedule(cursche["date"], cursche["itemId"], cursche["itemType"], cursche["notificationId"]);
    finalString = finalString + jsonEncode(newsche.toJson()) + seperator;
  }
  GetStorage().write("schedules", finalString);
}

showInAppNoti(){
  DateTime curDay = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
  if(GetStorage().read("inAppNotiId") == null ){
    GetStorage().write("inAppNotiId",0);
  }
  if(GetStorage().read("inAppNotiId") > curDay.millisecondsSinceEpoch){
    return;
  }
  var list = getSchedules();
  int listCount = 0;
  for(int i = 0; i< list.length; i++){
    var curSche = list[i];
    DateTime scheDate = DateTime.parse(curSche["date"]);
    if(DateTime.now().isAfter(scheDate) && DateTime.now().isBefore(scheDate.add(Duration(days:1)))){
      listCount += 1;
    }
  }
  if(listCount > 0){
    LocalNotification.inAppNotification("Reminder", "You have $listCount items scheduled for today!");
  }
  GetStorage().write("inAppNotiId", curDay.add(Duration(days: 1)).millisecondsSinceEpoch);
}

removeOldDates(){
  var list = getSchedules();
  for(int i = 0; i < list.length; i++){
    if(DateTime.now().isAfter(DateTime.parse(list[i]["date"]).add(Duration(days: 1)))){
      removeSchedule(i);
      removeOldDates();
      break;
    }
  }
}

List<dynamic> getSchedules(){
  String json = GetStorage().read("schedules")?? "";
  json = "["+json+"]";
  var mylist = jsonDecode(json).toList();
  return mylist;
}
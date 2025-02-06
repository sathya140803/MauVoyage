import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:my_application/data_model/Activity.dart';
import 'package:my_application/data_model/Beach.dart';
import 'package:my_application/data_model/Forest.dart';
import 'package:my_application/data_model/NightClubEvent%20.dart';
import 'package:my_application/data_model/PlaceOfInterest.dart';
import "package:my_application/notification_schedule/schedule_controller.dart";
import 'package:my_application/ui/DetailPage.dart';


getItem(int id, String type){
  if (type == "Beach") return Beach.beachList[id];
  if (type == "Forest") return Forest.forestList[id];
  if (type == "Activity") return Activity.activityList[id];
  if (type == "NightClubEvent") return NightClubEvent.nightClubList[id];
  if (type == "PlaceOfInterest") return PlaceOfInterest.placeList[id];
  return "";
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPage();
}

class _CalendarPage extends State<CalendarPage> {
  var currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    removeOldDates();
    var scheduleList = getSchedules();
    List<CalendarEventData> calenderData = [];
    for(int i = 0; i < scheduleList.length; i++){
      print(scheduleList[i]);
      var item = getItem(scheduleList[i]["itemId"], scheduleList[i]["itemType"]);
      calenderData.add(CalendarEventData(title: item.name, date: DateTime.parse(scheduleList[i]["date"])));
    }
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Calendar"),
        automaticallyImplyLeading: false,

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child:MonthView(
              controller: EventController()..addAll(calenderData),
              minMonth: DateTime(DateTime.now().year),
              maxMonth: DateTime(2050),
              initialMonth: DateTime.now(),
              cellAspectRatio: 1.05,
              onPageChange: (date, pageIndex) {
                setState(() {
                  currentDate = date;
                });
              },
              onCellTap: (events, date) {
                print(events);
              },
              startDay: WeekDays.sunday,
              showWeekTileBorder: false, // To show or hide header border
              hideDaysNotInMonth: true, // To hide days or cell that are not in current month
              showWeekends: true, // To hide weekends default value is true
            ),
          ),
          Expanded(
            child:ListView(
              padding: const EdgeInsets.only(top: 10.0),
              children: [
                for(int i = 0; i< scheduleList.length; i++)
                  if(DateTime.parse(scheduleList[i]["date"]).month == currentDate.month && DateTime.parse(scheduleList[i]["date"]).year == currentDate.year)
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(25.0),
                            child: Image.asset(getItem(scheduleList[i]["itemId"], scheduleList[i]["itemType"]).imageURL, fit: BoxFit.cover),
                          )
                        ),
                        title: Text(
                          getItem(scheduleList[i]["itemId"], scheduleList[i]["itemType"]).name!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tap to go to " + getItem(scheduleList[i]["itemId"], scheduleList[i]["itemType"]).name + " page"!,
                              style: const TextStyle(color: Colors.black87),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              DateTime.now().isAfter(DateTime.parse(scheduleList[i]["date"]))? "Today" : scheduleList[i]["date"].substring(0,11),
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: (){
                              setState(() {
                                removeSchedule(i);
                              });
                            },
                            icon: const Icon(Icons.remove, color: Colors.red,)
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(item: getItem(scheduleList[i]["itemId"], scheduleList[i]["itemType"]))));
                        },
                      ),
                    ),
                    /*Column(
                      children: [
                        Text(getItem(scheduleList[i]["itemId"], scheduleList[i]["itemType"]).name),

                        Row(
                          children: [
                            Expanded(
                                child: TextButton(
                                    onPressed: (){
                                      setState(() {
                                        removeSchedule(i);
                                      });
                                    },
                                    child: Text("Delete")
                                )
                            ),
                            Expanded(
                              child: TextButton(
                                  onPressed: (){
                                    setState(() {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(item: getItem(scheduleList[i]["itemId"], scheduleList[i]["itemType"]))));
                                    });
                                  },
                                  child: Text("Go to page")
                              )
                            )
                          ],
                        )
                      ],
                    )*/
                ],
              )
          )
        ]
      ),
    );
  }
}
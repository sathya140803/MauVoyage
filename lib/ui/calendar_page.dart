import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:my_application/data_model/Activity.dart';
import 'package:my_application/data_model/Beach.dart';
import 'package:my_application/data_model/Forest.dart';
import 'package:my_application/data_model/NightClubEvent .dart';
import 'package:my_application/data_model/PlaceOfInterest.dart';
import 'package:my_application/notification_schedule/notification_controller.dart';
import "package:my_application/notification_schedule/schedule_controller.dart";
import 'package:my_application/ui/DetailPage.dart';

getItem(int id, String type) {
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
  var checkDate = null;

  @override
  Widget build(BuildContext context) {
    removeOldDates();
    var scheduleList = getSchedules();
    List<CalendarEventData> calendarData = [];
    for (int i = 0; i < scheduleList.length; i++) {
      var item = getItem(scheduleList[i]["itemId"], scheduleList[i]["itemType"]);
      calendarData.add(CalendarEventData(
          title: item.name+i.toString(), date: DateTime.parse(scheduleList[i]["date"])));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Calendar", style: TextStyle(fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: MonthView(
              controller: EventController()..addAll(calendarData),
              cellBuilder: (date, events, isToday, isInMonth, hideDaysNotInMonth){
                if(isInMonth){
                  return Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 5),
                          decoration: !isToday? BoxDecoration(): BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                              child: Text(
                                date.day.toString(),
                              )
                          ),
                        ),
                      ),
                      Expanded(
                          child: Text(
                            events.isNotEmpty? events.length.toString(): "",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                          )
                      )
                    ],
                  );
                }
                return Container();
              },
              minMonth: DateTime(DateTime.now().year),
              maxMonth: DateTime(2050),
              initialMonth: DateTime.now(),
              cellAspectRatio: 1.02,
              onPageChange: (date, pageIndex) {
                setState(() {
                  currentDate = date;
                  checkDate = null;
                });
              },
              onCellTap: (events, date) {
                setState(() {
                  checkDate = date;
                });
              },
              startDay: WeekDays.sunday,
              showWeekTileBorder: false,
              hideDaysNotInMonth: true,
              showWeekends: true,
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Center(
                    child: Text(
                        checkDate == null? "Sorted By: None": "Sorted By: ${checkDate.toString().substring(0,11)}"
                    )
                ),
              ),
              Spacer(),
              Expanded(
                  child: TextButton(
                      onPressed: (){
                        setState(() {
                          checkDate = null;
                        });
                      },
                      child: Text("Clear")
                  )
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10.0),
              itemCount: scheduleList.length,
              itemBuilder: (context, index) {
                var schedule = scheduleList[index];
                var item = getItem(schedule["itemId"], schedule["itemType"]);
                var scheduleDate = DateTime.parse(schedule["date"]);
                scheduleDate = DateTime(scheduleDate.year, scheduleDate.month, scheduleDate.day);

                if (checkDate == null && scheduleDate.month == currentDate.month &&
                    scheduleDate.year == currentDate.year || (checkDate != null && checkDate == scheduleDate)) {
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(item: item),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                item.imageURL,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.description!,
                                    style: const TextStyle(color: Colors.black87),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    schedule["itemType"] == "Activity"
                                        ? item.price
                                        : item.entryFee,
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  removeSchedule(index);
                                });
                              },
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                size: 28,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

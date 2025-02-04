

class schedule {

  String date;
  int itemId;
  String itemType;
  int notificationId;

  schedule(this.date, this.itemId, this.itemType, this.notificationId);

  Map<String,dynamic> toJson(){
    return {
      "date": date.toString(),
      "itemId": itemId,
      "itemType": itemType,
      "notificationId": notificationId
    };
  }
}
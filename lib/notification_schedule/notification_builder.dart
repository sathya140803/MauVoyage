

class notification {
  String description;
  int id;
  String type;
  int itemId;
  String itemType;
  String showTime;

  notification(this.description,this.id,this.type,this.itemId,this.itemType,this.showTime);

  Map<String,dynamic> toJson(){
    return {
      "description": description,
      "id": id,
      "type": type,
      "itemId": itemId,
      "itemType": itemType,
      "showTime": showTime,
    };
  }
}



class favourite{

  int item_id;
  String item_type;

  favourite(this.item_id, this.item_type);

  Map<String,dynamic> toJson(){
    return {
      "item_id": item_id,
      "item_type": item_type
    };
  }

}
import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:my_application/favourite_manager/favourite_class.dart';

addFavourite(int item_id, String item_type){
  var string = GetStorage().read("favourites")?? "";
  var fav = favourite(item_id,item_type);
  var fav_str = jsonEncode(fav.toJson());
  if(GetStorage().read("favourites") == null || GetStorage().read("favourites") == ""){
    string += fav_str;
  }else{
    string += ", $fav_str";
  }
  GetStorage().write("favourites", string);
}

removeFavourite(int index){
  var fav_list = getFavourites();
  fav_list.removeAt(index);
  var string = "";
  for(int i = 0; i < fav_list.length; i++){
    var fav = favourite(fav_list[i]["item_id"], fav_list[i]["item_type"]);
    if(i == fav_list.length - 1){
      string += jsonEncode(fav.toJson());
    }else{
      string += "${jsonEncode(fav.toJson())},";
    }
  }
  GetStorage().write("favourites", string);
}

removeFavouriteFull(int item_id, String item_type){
  var fav_list = getFavourites();
  var string = "";
  for(int i = 0; i < fav_list.length; i++){
    if(fav_list[i]["item_id"] == item_id && fav_list[i]["item_type"] == item_type){
      fav_list.removeAt(i);
    }
  }
  for(int i = 0; i < fav_list.length; i++){
    var fav = favourite(fav_list[i]["item_id"], fav_list[i]["item_type"]);
    if(i == fav_list.length - 1){
      string += jsonEncode(fav.toJson());
    }else{
      string += "${jsonEncode(fav.toJson())},";
    }
  }
  GetStorage().write("favourites", string);
}

checkIfFavourite(int item_id, String item_type){
  var fav_list = getFavourites();
  for(int i = 0; i < fav_list.length; i++){
    if(fav_list[i]["item_id"] == item_id && fav_list[i]["item_type"] == item_type){
      return true;
    }
  }
  return false;
}

List<dynamic> getFavourites(){
  String string = GetStorage().read("favourites")?? "";
  string = "[$string]";
  var fav_list = jsonDecode(string).toList();
  return fav_list;
}
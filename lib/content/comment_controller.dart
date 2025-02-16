


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_application/acc_management/authentications.dart';

var commentsDb = FirebaseFirestore.instance.collection("Comments");




addComment(String placeString,String comment) async{
  if(comment.isNotEmpty){
    var uid = AuthService().getCurrentUser()?.uid;
    if(uid != null){
      var data = <String,dynamic>{
        uid : {
          "user": AuthService().getCurrentUser()?.displayName,
          "comment": comment
        }
      };
      await commentsDb.doc(placeString).set(data,SetOptions(merge: true));
    }
  }
}

deleteComment(String placeString) async{
  var uid = AuthService().getCurrentUser()?.uid;
  if(uid != null){
    var data = <String,dynamic>{
      uid : FieldValue.delete()
    };
    await commentsDb.doc(placeString).set(data,SetOptions(merge: true));
  }
}


getComments(String placeString) async{
  return await commentsDb.doc(placeString).get();
}
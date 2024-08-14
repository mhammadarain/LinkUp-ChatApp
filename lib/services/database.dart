import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id)async{
    return await FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .set(userInfoMap);
  }

  Future<QuerySnapshot> getUserbyemail(String email)async{
    return await FirebaseFirestore.instance
        .collection("User")
        .where("E-mail, isEqualTo: email")
        .get();
  }

  Future<QuerySnapshot> Search(String username)async{
    return await FirebaseFirestore.instance.collection("User").where("Searchkey", isEqualTo: username.substring(0,1).toUpperCase()).get();
  }
}

import 'package:chat_app/services/shared_pref.dart';
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

  Future<void> creatChatRoom(String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    final CollectionReference chatRooms = FirebaseFirestore.instance.collection('chatrooms');

    return chatRooms.doc(chatRoomId).set(chatRoomInfoMap).catchError((e) {
      print(e.toString());
    });
  }


  Future addMessage(String chatRoomId, String messageId, Map<String, dynamic> messageInfoMap)async{
    return FirebaseFirestore.instance.collection("chatrooms").doc(chatRoomId).collection("chats").doc(messageId).set(messageInfoMap);
  }

  updateLastMessageSend(String chatRoomId, Map<String, dynamic> lastMessageInfoMap){
    return FirebaseFirestore.instance.collection("chatrooms").doc(chatRoomId).update(lastMessageInfoMap);
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId)async{
    return FirebaseFirestore.instance.collection("chatrooms").doc(chatRoomId).collection("chats").orderBy("time", descending: true).snapshots();
  }

  Future<QuerySnapshot> getUserInfo(String username)async{
    return await FirebaseFirestore.instance.collection("users").where("username", isEqualTo: username).get();
  }

  Future<Stream<QuerySnapshot>> getChatRooms()async{
    String? myUsername = await SharedPreferenceHelper().getUserName();
    return FirebaseFirestore.instance.collection("chatrooms").orderBy("time", descending: true).where("users", arrayContains: myUsername!).snapshots();
  }


}
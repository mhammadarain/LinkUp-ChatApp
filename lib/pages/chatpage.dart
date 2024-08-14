import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color((0xff02223b)),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios_outlined,color: Colors.white70,size: 20,),
                    SizedBox(width: 20,),
                    Text("Hammad Arain",style: TextStyle(color: Colors.white70,fontSize: 25, fontWeight: FontWeight.bold),),

                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(left: 20,right: 20,top: 50, bottom: 40),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/ 1.15,
                decoration: BoxDecoration(color: Colors.white70,borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/1.7),
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(color: Color(0xFF023964),borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))),
                      child: Text("Hello, How are you?",style: TextStyle(color: Colors.white70,fontSize: 15, fontWeight: FontWeight.w500),),
                    ),
                    SizedBox(height: 15.0,),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width/1.7),
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(color: Color(0xff02223b),borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                      child: Text("Hi, I am fine, What about you?",style: TextStyle(color: Colors.white70,fontSize: 15, fontWeight: FontWeight.w500),),
                    ),
                    Spacer(),
                    Material(
                      elevation: 21.0,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: EdgeInsets.only(right: 4.0,left: 10),
                        decoration: BoxDecoration(color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Type a message here..."),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xff02223b),
                                borderRadius: BorderRadius.circular(8)
                              ),
                                child: Center(child: Icon(Icons.send,color: Colors.white,)))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

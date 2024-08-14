import 'package:chat_app/pages/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool search = false;

  var queryResultSet = [];
  var temSearchStore = [];

  initiateSearch(String value) {
    if (value.isEmpty) {
      setState(() {
        queryResultSet = [];
        temSearchStore = [];
        search = false;
      });
      return;
    }

    setState(() {
      search = true;
    });

    var capitalizedValue = value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.isEmpty && value.length == 1) {
      DatabaseMethods().Search(value).then((QuerySnapshot docs) {
        if (docs != null) {
          setState(() {
            queryResultSet = docs.docs.map((doc) => doc.data()).toList();
            temSearchStore = queryResultSet;
            print("Query Results: $queryResultSet");
            print("Filtered Results: $temSearchStore");
          });
        } else {
          print("No results found.");
        }
      }).catchError((error) {
        print("An error occurred: $error");
      });
    } else {
      setState(() {
        temSearchStore = queryResultSet
            .where((element) => element['username'].startsWith(capitalizedValue))
            .toList();
        print("Filtered Results: $temSearchStore");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff02223b),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    search
                        ? Expanded(
                      child: TextField(
                        onChanged: (value) {
                          initiateSearch(value);
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search User here...",
                            hintStyle: TextStyle(color: Colors.white70, fontSize: 20)),
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                        : const Text(
                      "LINK-UP",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 33,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          search = true;
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Icon(
                            Icons.search,
                            color: Color(0xff02223b),
                          )),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: search
                    ? MediaQuery.of(context).size.height / 1.19
                    : MediaQuery.of(context).size.height / 1.1,
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    search
                        ? ListView(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      primary: false,
                      shrinkWrap: true,
                      children: temSearchStore.map((element) {
                        print("Building result card for: $element");
                        return buildResultCard(element);
                      }).toList(),
                    )
                        : Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage()));
                          },
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: const Image(
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/p4.jpeg"),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Text(
                                        "Hammad Arain",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    "Hello, what are you doing?",
                                    style: TextStyle(
                                        color: Colors.black45, fontSize: 14),
                                  )
                                ],
                              ),
                              const Spacer(),
                              const Text(
                                "04:33 PM",
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: const Image(
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                                image: AssetImage("assets/logo.jpeg"),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text(
                                      "Sindh University",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "Hello, what are you doing?",
                                  style: TextStyle(
                                      color: Colors.black45, fontSize: 14),
                                )
                              ],
                            ),
                            const Spacer(),
                            const Text(
                              "04:33 PM",
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 14),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildResultCard(data) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data["Name"],
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    data["username"],
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

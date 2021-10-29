import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:design_event_management_app/screens/event_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    eventStream();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void eventStream() async {
    await for (var snapshot in _firestore.collection('events').snapshots()) {
      for (var event in snapshot.docs) {
        print(event.data());
      }
    }
  }

  String getTF(type) {
    if (type == true) {
      return "Yes";
    } else {
      return "No";
    }
  }

  String getType(type) {
    if (type == true) {
      return "Yes";
    } else {
      return "No";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f8fe),
      appBar: AppBar(
        backgroundColor: Color(0xFF3E4685),
        title: Text("Home"),
        leading: null,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.logout,
                  size: 26.0,
                ),
              )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xfff3f8fe),
        elevation: 10,
        onTap: (i) {
          if (i == 0) {
          } else if (i == 1) {
            Navigator.pushNamed(context, "add_event_screen");
          } else if (i == 2) {
            Navigator.pushNamed(context, "chat_screen");
          }
        },
        selectedItemColor: Color(0xFF3E4685),
        // backgroundColor: Colors.purple,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add Event"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat")
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('events').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final events = snapshot.data.docs;
            List<CardWidget> eventCards = [];
            for (var event in events) {
              final title = event.data()["title"];
              final description = event.data()["description"];
              final virtual = event.data()["virtual"];
              final location = event.data()["link/location"];
              final link = event.data()["imagelink"];
              final help1 = event.data()["required1"];
              final help2 = event.data()["required2"];
              final help3 = event.data()["required3"];
              final date = event.data()["date"];
              final inHouse = event.data()['type'];

              final inHouseType = getType(inHouse);
              final type = getTF(virtual);

              final cardWidget = CardWidget(
                title: title,
                description: description,
                virtual: type,
                location: location,
                imageLink: link,
                help1: help1,
                help2: help2,
                help3: help3,
                date: date,
                inHouse: inHouseType,
              );
              eventCards.add(cardWidget);
            }
            return ListView(
              children: eventCards,
            );
          }),
    );
  }
}

class CardWidget extends StatelessWidget {
  CardWidget(
      {this.title,
      this.description,
      this.virtual,
      this.location,
      this.imageLink,
      this.help1,
      this.help2,
      this.help3,
      this.date,
      this.inHouse});

  final String title;
  final String description;
  final String virtual;
  final String location;
  final String imageLink;
  final String help1, help2, help3;
  final String date;
  final String inHouse;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      color: Color(0xF2FFFFFF),
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18)),
            child: Image(
              image: NetworkImage(imageLink),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                ),
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  margin: EdgeInsets.all(7),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Virtual🔎: $virtual",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Link/Location🔗: $location",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "In society Premises: $inHouse",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Date and Time⏲: $date",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  margin: EdgeInsets.all(7),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Description:",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "$description...",
                          style: TextStyle(fontSize: 16),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Material(
                      color: Color(0xFF3E4685),
                      borderRadius: BorderRadius.circular(20),
                      elevation: 6,
                      child: MaterialButton(
                        height: 0,
                        onPressed: () {
                          print(loggedInUser.uid);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventInfo(
                                type: virtual,
                                eventDescription: description,
                                eventTitle: title,
                                imageLink: imageLink,
                                location: location,
                                help2: help2,
                                help1: help1,
                                help3: help3,
                                date: date,
                                inHouse: inHouse,
                              ),
                            ),
                          );
                        },
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: Icon(
                          Icons.arrow_right_alt_sharp,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

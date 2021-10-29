import 'package:flutter/material.dart';

class EventInfo extends StatelessWidget {
  EventInfo(
      {@required this.type,
      @required this.eventDescription,
      @required this.eventTitle,
      @required this.imageLink,
      @required this.location,
      this.help3,
      this.help2,
      this.help1,
      @required this.date,
      this.inHouse,
      this.currentUserEmail});

  final String eventTitle;
  final String eventDescription;
  final String type;
  final String location;
  final String imageLink;
  final String help1, help2, help3;
  final String date;
  final String inHouse;
  final currentUserEmail;

  Widget getWidget1(help1) {
    if (help1 != null) {
      return HelpCard(
        help: help1,
      );
    } else {
      return HelpCard(
        help: "No help required",
      );
    }
  }

  Widget getWidget2(help2) {
    if (help2 != null) {
      return HelpCard(
        help: help2,
      );
    }
  }

  Widget getWidget3(help3) {
    if (help3 != null) {
      return HelpCard(
        help: help3,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f8fe),
      appBar: AppBar(
        backgroundColor: Color(0xFF3E4685),
        title: Text(eventTitle),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xfff3f8fe),
        elevation: 10,
        onTap: (i) {
          if (i == 0) {
            Navigator.pop(context);
          } else if (i == 1) {
            Navigator.pushNamed(context, "add_event_screen");
          } else if (i == 2) {
            Navigator.pushNamed(context, "chat_screen");
          }
        },
        selectedItemColor: Color(0xFF3E4685),
        currentIndex: 0,

        // backgroundColor: Colors.purple,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add Event"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat")
        ],
      ),
      body: ListView(
        children: [
          Card(
            elevation: 6,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            margin: EdgeInsets.all(20),
            child: Image(
              image: NetworkImage(imageLink),
            ),
          ),
          Card(
            color: Color(0xF2FFFFFF),
            elevation: 6,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Text(
                    eventTitle,
                    style: TextStyle(fontSize: 35),
                  ),
                ),
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Description:",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          eventDescription,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Virtual🔎: $type",
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
                          "In society premises: $inHouse",
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
                SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Help Required",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          color: Color(0xFF3E4685),
                          child: getWidget1(help1),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          color: Color(0xFF3E4685),
                          child: getWidget2(help2),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          color: Color(0xFF3E4685),
                          child: getWidget3(help3),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}

class HelpCard extends StatelessWidget {
  HelpCard({this.help});

  final String help;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 13),
      child: Text(
        help,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

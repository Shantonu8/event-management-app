import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:design_event_management_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:status_alert/status_alert.dart';

int currentIndex = 1;
final _firestore = FirebaseFirestore.instance;
User loggedInUser;
final _auth = FirebaseAuth.instance;

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  String imageLink;
  String title;
  String description;
  String location;
  String required1;
  String required2;
  String required3;
  bool virtual;
  String date;
  bool type;

  @override
  void initState() {
    super.initState();
    virtual = false;
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  setSelectedRadio(bool value) {
    setState(() {
      virtual = value;
    });
  }

  setSelectedRadio2(bool value) {
    setState(() {
      type = value;
    });
  }

  void showAlert() {
    return StatusAlert.show(
      context,
      duration: Duration(seconds: 2),
      title: 'Event Added Successfully',
      configuration: IconConfiguration(icon: Icons.done),
    );
  }

  void showIncompleteAlert() {
    return StatusAlert.show(
      context,
      duration: Duration(seconds: 2),
      title: 'Please fill all the required fields!',
      configuration: IconConfiguration(icon: Icons.dangerous),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff3f8fe),
        appBar: AppBar(
          backgroundColor: Color(0xFF3E4685),
          title: Text("Add Events"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xfff3f8fe),
          elevation: 10,
          onTap: (i) {
            if (i == 0) {
              Navigator.pop(context);
            } else if (i == 1) {
            } else if (i == 2) {
              Navigator.pushNamed(context, "chat_screen");
            }
          },
          selectedItemColor: Color(0xFF3E4685),
          currentIndex: 1,
          // backgroundColor: Colors.purple,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Add Event",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: "Chat",
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 9.0),
                child: Text(
                  "Create an Event",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                clipBehavior: Clip.antiAlias,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: "🔗 Link to Image*",
                    ),
                    onChanged: (value) {
                      imageLink = value;
                    },
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
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: "📌 Event Title*",
                    ),
                    onChanged: (value) {
                      title = value;
                    },
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
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: "💬 Description*",
                    ),
                    onChanged: (value) {
                      description = value;
                    },
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
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 10),
                      child: Text(
                        "Is the event virtual❓",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      child: RadioListTile(
                        value: true,
                        groupValue: virtual,
                        activeColor: Color(0xFF3E4685),
                        onChanged: (value) {
                          setSelectedRadio(value);
                        },
                        title: Text("Yes"),
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
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      child: RadioListTile(
                        value: false,
                        groupValue: virtual,
                        activeColor: Color(0xFF3E4685),
                        onChanged: (value) {
                          setSelectedRadio(value);
                          print(virtual);
                        },
                        title: Text("No"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                clipBehavior: Clip.antiAlias,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 10),
                      child: Text(
                        "Is the event inside the society premises❓",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      child: RadioListTile(
                        value: true,
                        groupValue: type,
                        activeColor: Color(0xFF3E4685),
                        onChanged: (value) {
                          setSelectedRadio2(value);
                        },
                        title: Text("Yes"),
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
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      child: RadioListTile(
                        value: false,
                        groupValue: type,
                        activeColor: Color(0xFF3E4685),
                        onChanged: (value) {
                          setSelectedRadio2(value);
                          print(type);
                        },
                        title: Text("No"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                clipBehavior: Clip.antiAlias,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: "🖇 Link/Location*",
                    ),
                    onChanged: (value) {
                      location = value;
                    },
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
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: "⌛ Date and Time*",
                    ),
                    onChanged: (value) {
                      date = value;
                    },
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
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12),
                      child: Text(
                        "Required Help",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: TextField(
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: "Required Help 1",
                          ),
                          onChanged: (value) {
                            required1 = value;
                          },
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
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: TextField(
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: "Required Help 2",
                          ),
                          onChanged: (value) {
                            required2 = value;
                          },
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
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: TextField(
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: "Required Help 3",
                          ),
                          onChanged: (value) {
                            required3 = value;
                          },
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
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 365,
                  height: 55,
                  child: Material(
                    color: Color(0xFF3E4685),
                    borderRadius: BorderRadius.circular(20),
                    elevation: 6,
                    child: MaterialButton(
                        height: 0,
                        onPressed: () {
                          print(imageLink);
                          print(title);
                          print(description);
                          print(location);
                          print(required1);
                          print(required2);
                          print(required3);
                          print(virtual);

                          if (imageLink == null) {
                            showIncompleteAlert();
                            return;
                          } else if (title == null) {
                            showIncompleteAlert();
                            return;
                          } else if (description == null) {
                            showIncompleteAlert();
                            return;
                          } else if (location == null) {
                            showIncompleteAlert();
                            return;
                          } else if (virtual == null) {
                            showIncompleteAlert();
                            return;
                          } else if (date == null) {
                            showIncompleteAlert();
                            return;
                          } else if (type == null) {
                            showIncompleteAlert();
                            return;
                          } else {
                            _firestore.collection('events').add({
                              'title': title,
                              'description': description,
                              'virtual': virtual,
                              'link/location': location,
                              'imagelink': imageLink,
                              'required1': required1,
                              'required2': required2,
                              'required3': required3,
                              'owner': loggedInUser.email,
                              'date': date,
                              'type': type
                            });
                            showAlert();
                            Navigator.popAndPushNamed(context, "event_screen");
                          }
                        },
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: Text(
                          "Create Event",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
}

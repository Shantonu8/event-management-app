import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:design_event_management_app/screens/event_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class YEET extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetUserName("x730zeWJAAVMV6YgnEoLIJPCDhd2");
  }
}

class GetUserName extends StatelessWidget {
  final String firebaseUID;

  GetUserName(this.firebaseUID);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(firebaseUID).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text("Full Name: ${data['name']}");
        }

        return Text("loading");
      },
    );
  }
}

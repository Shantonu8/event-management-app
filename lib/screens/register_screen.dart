import 'package:flutter/material.dart';
import 'package:design_event_management_app/constants.dart';
import 'package:design_event_management_app/componenets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:status_alert/status_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// final _firestore = FirebaseFirestore.instance;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showSpinner = false;
  final inputTextController = TextEditingController();
  final inputTextController2 = TextEditingController();
  final inputTextController3 = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String newEmail;
  String newPassword;
  String displayName;

  void showAlert(statement) {
    return StatusAlert.show(
      context,
      duration: Duration(seconds: 2),
      title: statement,
      configuration: IconConfiguration(icon: Icons.dangerous),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xfff3f8fe),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: Container(
                    child: Image.asset("images/applogo.png"),
                  ),
                ),
              ),
              // TextField(
              //   controller: inputTextController3,
              //   onChanged: (value) {
              //     displayName = value;
              //     // print(displayName);
              //   },
              //   textAlign: TextAlign.center,
              //   decoration: kTextFieldDecoration.copyWith(hintText: "Name"),
              // ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                clipBehavior: Clip.antiAlias,
                color: Colors.white,
                child: TextField(
                  controller: inputTextController,
                  onChanged: (value) {
                    newEmail = value;
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  decoration: kTextFieldDecoration.copyWith(hintText: "Email"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                clipBehavior: Clip.antiAlias,
                color: Colors.white,
                child: TextField(
                  controller: inputTextController2,
                  onChanged: (value) {
                    newPassword = value;
                  },
                  obscureText: true,
                  textAlign: TextAlign.center,
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: "Password"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RoundedButton(
                  color: Color(0xff636FCE),
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                      inputTextController.clear();
                      inputTextController2.clear();
                    });

                    if (newPassword.length <= 6 || newPassword == null) {
                      showAlert(
                          "Please input a password that is longer than 6 characters");
                    } else {
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: newEmail, password: newPassword);
                        // _firestore.collection('users').add({
                        //   "email": newEmail,
                        //   "name": displayName,
                        // });
                        if (newUser != null) {
                          print(newUser);
                          Navigator.pushNamed(context, "event_screen");
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                        showAlert("Something went wrong, please try again!");
                        setState(() {
                          showSpinner = false;
                        });
                      }
                      newPassword = null;
                      newEmail = null;
                    }
                  },
                  title: "Register"),
            ],
          ),
        ),
      ),
    );
  }
}

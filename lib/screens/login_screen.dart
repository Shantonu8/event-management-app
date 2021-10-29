import 'package:flutter/material.dart';
import 'package:design_event_management_app/constants.dart';
import 'package:design_event_management_app/componenets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:status_alert/status_alert.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  final inputTextController = TextEditingController();
  final inputTextController2 = TextEditingController();
  String password;
  String email;

  void showAlert() {
    return StatusAlert.show(
      context,
      duration: Duration(seconds: 2),
      title: "An error occurred, please try again!",
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
                    email = value;
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
                    password = value;
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
                  color: Color(0xFF3E4685),
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                      inputTextController.clear();
                      inputTextController2.clear();
                    });
                    try {
                      final loggedUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (loggedUser != null) {
                        Navigator.pushNamed(context, "event_screen");
                        print(loggedUser);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                      setState(() {
                        showSpinner = false;
                      });
                      showAlert();
                    }
                    password = null;
                    email = null;
                  },
                  title: "Login"),
            ],
          ),
        ),
      ),
    );
  }
}

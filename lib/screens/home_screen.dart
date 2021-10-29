import 'package:flutter/material.dart';
import 'package:design_event_management_app/componenets/rounded_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f8fe),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset("images/applogo.png"),
                    height: 60,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 300),
                  repeatForever: true,
                  text: ['eEVENT'],
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 42.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48,
            ),
            RoundedButton(
                color: Color(0xFF3E4685),
                onPressed: () {
                  Navigator.pushNamed(context, "login_screen");
                },
                title: "Login"),
            RoundedButton(
                color: Color(0xff636FCE),
                onPressed: () {
                  Navigator.pushNamed(context, "register_screen");
                },
                title: "Register")
          ],
        ),
      ),
    );
  }
}

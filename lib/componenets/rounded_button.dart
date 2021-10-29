import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final Function onPressed;
  final String title;

  RoundedButton(
      {@required this.color, @required this.onPressed, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Material(
        elevation: 4,
        color: color,
        borderRadius: BorderRadius.circular(40),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200,
          height: 53,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

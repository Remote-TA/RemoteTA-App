import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function onPress;
  RoundedButton({this.text, this.color, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPress,
          minWidth: MediaQuery.of(context).size.width / 1.5,
          height: 42.0,
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

const kInputOutlineColor = Color.fromARGB(255, 108, 92, 231);
const kSignUpButtonColor = Color.fromARGB(255, 108, 92, 231);
const kAppBarBackgroundColor = Color.fromARGB(255, 116, 185, 255);
const kLinkColor = Color.fromARGB(255, 232, 67, 147);
const kSmallDescriptionColor = Color.fromARGB(255, 162, 155, 254);

const kInputDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kInputOutlineColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kInputOutlineColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
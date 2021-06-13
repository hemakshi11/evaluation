import 'package:flutter/material.dart';

const kContainerColor = Color(0xffF5F5F5);

const kContainerCircularBorders = BorderRadius.all(Radius.circular(20));
const kContainerButtonColor = Colors.white12;
const kTeal = Color(0xff009688);

// const kSnackBar = SnackBar(content: Text('SnackBar'));
const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  filled: true,
  fillColor: Colors.white54,
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      borderSide: BorderSide(color: kTeal, width: 1)),
  hintText: 'Enter your Email',
  hintStyle: TextStyle(
    color: Colors.black54,
    fontSize: 15.0,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
    borderSide: BorderSide(color: kTeal, width: 0.0),
  ),
);

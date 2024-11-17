import 'package:flutter/material.dart';

const Google_Maps_API_Key = "AIzaSyCL0yYOnRI0L_Aobqv4eaP7eK2NbQZi5cY";
final kTextFieldTextStyle = TextStyle(
  color: Colors.grey.shade500,
  fontSize: 20,
);

final kInputTextStyle = TextStyle(
  color: Colors.grey,
  fontSize: 17,
);

final kDefaultBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(30),
  borderSide: BorderSide(
    color: Colors.grey.shade400,
    width: 1,
  ),
);

final kFocusBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(30),
  borderSide: BorderSide(
    color: Colors.black, // Color on focus
    width: 2,
  ),
);

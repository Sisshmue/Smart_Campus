import 'package:flutter/material.dart';

import '../const.dart';

class TextArea extends StatelessWidget {
  final String? hint;
  final Color? fillColor;
  final Function(String)? onChange;
  final bool? showText;
  TextArea(
      {required this.hint,
      required this.fillColor,
      required this.onChange,
      required this.showText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange!,
      obscureText: showText!,
      style: kInputTextStyle,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: hint!,
        hintStyle: kTextFieldTextStyle,
        filled: true,
        fillColor: fillColor!,
        //Default border
        enabledBorder: kDefaultBorderStyle,
        //Focused border
        focusedBorder: kFocusBorderStyle,
      ),
    );
  }
}

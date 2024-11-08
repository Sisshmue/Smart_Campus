import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String? buttonName;
  final Function()? onTouch;
  LoginButton({required this.buttonName, required this.onTouch});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTouch!,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(30)),
        child: Center(child: Text(buttonName!)),
      ),
    );
  }
}

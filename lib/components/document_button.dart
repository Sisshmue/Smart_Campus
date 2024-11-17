import 'package:flutter/material.dart';

class DocumentPageButton extends StatelessWidget {
  final String? buttonName;
  final Function()? whenTapped;
  DocumentPageButton({required this.buttonName, this.whenTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: whenTapped!,
      child: Container(
        width: 235,
        height: 97,
        decoration: BoxDecoration(
          color: Color(0xFF272EBC),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonName!,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

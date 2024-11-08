import 'package:flutter/material.dart';

class GoogleSingUpButton extends StatelessWidget {
  final String? img;
  final String? buttonName;
  final Function()? onClick;
  GoogleSingUpButton(
      {required this.img, required this.buttonName, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick!,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              width: 50,
              height: 50,
              child: Image.asset(img!),
            ),
            Container(
              padding: EdgeInsets.all(5),
              width: 150,
              height: 50,
              child: Center(child: Text(buttonName!)),
            ),
          ],
        ),
      ),
    );
  }
}

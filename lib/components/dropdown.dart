import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final ValueChanged<String?> onDocumentSelected;
  const DropDown({super.key, required this.onDocumentSelected});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? selectedValue; // Variable to hold the selected value
  Function(String)? whenChanged;

  final List<String> items = [
    'Transcript (English)',
    'Transcript (Thai)',
    'Certificate of Student Status (Eng)',
    'Certificate of Student Status (Thai)',
    'Certificate of using English as medium of instruction'
  ]; // List of dropdown items

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text('Select Document'),
        style: TextStyle(fontSize: 13, color: Colors.black),
        value: selectedValue,
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue;
            print(selectedValue);
            widget.onDocumentSelected(newValue);
          });
        },
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 13),
            ),
          );
        }).toList(),
      ),
    );
  }
}

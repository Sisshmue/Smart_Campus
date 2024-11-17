import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/dropdown.dart';
import 'IOSCustomRadioLog.dart';

class CustomRadioDialog extends StatefulWidget {
  @override
  State<CustomRadioDialog> createState() => _CustomRadioDialogState();
}

class _CustomRadioDialogState extends State<CustomRadioDialog> {
  String? selectedOptions;
  String? reason;
  String? phoneNum;
  String? schoolEmail;
  String? selectedDoc;
  bool _areFieldsComplete() {
    return selectedOptions != null &&
        reason != null &&
        reason!.isNotEmpty &&
        phoneNum != null &&
        phoneNum!.isNotEmpty &&
        schoolEmail != null &&
        schoolEmail!.isNotEmpty &&
        selectedDoc != null;
  }

  void _handleSubmit() async {
    if (!_areFieldsComplete()) {
      if (Platform.isIOS) {
        showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
                  title: Text('Incomplete Fields'),
                  content: Text('Please complete all fields'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'))
                  ],
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Incomplete Fields'),
                  content: Text('Please complete all fields'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'))
                  ],
                ));
      }
    } else {
      try {
        await FirebaseFirestore.instance.collection('DocReq').add({
          'receiving_type': selectedOptions,
          'reason': reason,
          'phone_no': phoneNum,
          'school_email': schoolEmail,
          'selected_doc': selectedDoc,
          'time stamp': Timestamp.now(),
        });
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Request submitted successfully')));
      } catch (e) {
        print('Error saving request: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? IOSCustomRadioDialog(
            selectedOptions: selectedOptions,
            onOptionChanged: (value) {
              setState(() {
                selectedOptions = value;
              });
            },
            reason: reason,
            onReasonChanged: (value) {
              setState(() {
                reason = value;
              });
            },
            phoneNum: phoneNum,
            onPhoneNumChanged: (value) {
              setState(() {
                phoneNum = value;
              });
            },
            schoolEmail: schoolEmail,
            onSchoolEmailChanged: (value) {
              setState(() {
                schoolEmail = value;
              });
            },
            onDocumentSelected: (value) {
              setState(() {
                selectedDoc = value;
              });
            },
            onSubmit: _handleSubmit,
            onCancel: () {
              Navigator.of(context).pop();
            })
        : AlertDialog(
            icon: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.highlight_off_rounded)),
            elevation: 10,
            shadowColor: Colors.lightBlueAccent,
            backgroundColor: Color(0xFFE9EAF8),
            title: Text(
              'Document Request',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        'Receiving Type',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '*',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text(
                      'taken by yourself',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    leading: Radio<String?>(
                        value: "taken by yourself",
                        groupValue: selectedOptions,
                        onChanged: (String? value) {
                          setState(() {
                            selectedOptions = value;
                            print(selectedOptions);
                          });
                        }),
                  ),
                  ListTile(
                    title: Text(
                      'taken by the authorized person',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    leading: Radio<String?>(
                        value: "taken by the authorized person",
                        groupValue: selectedOptions,
                        onChanged: (String? value) {
                          setState(() {
                            selectedOptions = value;
                            print(selectedOptions);
                          });
                        }),
                  ),
                  ListTile(
                    title: Text(
                      'postage',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    leading: Radio<String?>(
                        value: "postage",
                        groupValue: selectedOptions,
                        onChanged: (String? value) {
                          setState(() {
                            selectedOptions = value;
                            print(selectedOptions);
                          });
                        }),
                  ),
                  ListTile(
                    title: Text(
                      'download PDF Files',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    leading: Radio<String?>(
                        value: "download PDF Files",
                        groupValue: selectedOptions,
                        onChanged: (String? value) {
                          setState(() {
                            selectedOptions = value;
                            print(selectedOptions);
                          });
                        }),
                  ),

                  // only for debugging purpose
                  // Padding(
                  //   padding: EdgeInsets.all(16),
                  //   child: Text("Selected Option: $selectedOptions"),
                  // ),

                  Text(
                    'The document will be downloaded after the payment is completed',
                    style: TextStyle(color: Colors.red, fontSize: 10),
                  ),
                  Row(
                    children: [
                      Text(
                        'Reason for request',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text("*", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  Container(
                    width: 300,
                    height: 35,
                    child: TextField(
                      onChanged: (value) {
                        reason = value;
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(top: 1, right: 1, left: 10),
                          filled: true,
                          fillColor: Color(0xFFD9D9D9),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Row(
                    children: [
                      Text(
                        'Current Phone Number',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text("*", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  Container(
                    width: 300,
                    height: 35,
                    child: TextField(
                      onChanged: (value) {
                        phoneNum = value;
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(top: 1, right: 1, left: 10),
                          filled: true,
                          fillColor: Color(0xFFD9D9D9),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        'School email',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text("*", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  Container(
                    width: 300,
                    height: 35,
                    child: TextField(
                      onChanged: (value) {
                        schoolEmail = value;
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(top: 1, right: 1, left: 10),
                          filled: true,
                          fillColor: Color(0xFFD9D9D9),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        'Select Document',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text("*", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  DropDown(
                    onDocumentSelected: (value) {
                      setState(() {
                        selectedDoc = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: _handleSubmit, child: Text('Request'))
            ],
          );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IOSCustomRadioDialog extends StatefulWidget {
  final String? selectedOptions;
  final Function(String?) onOptionChanged;
  final String? reason;
  final Function(String?) onReasonChanged;
  final String? phoneNum;
  final Function(String?) onPhoneNumChanged;
  final String? schoolEmail;
  final Function(String?) onSchoolEmailChanged;
  final Function()? onSubmit;
  final Function()? onCancel;
  final Function(String?) onDocumentSelected;

  IOSCustomRadioDialog({
    required this.selectedOptions,
    required this.onOptionChanged,
    required this.reason,
    required this.onReasonChanged,
    required this.phoneNum,
    required this.onPhoneNumChanged,
    required this.schoolEmail,
    required this.onSchoolEmailChanged,
    required this.onSubmit,
    required this.onCancel,
    required this.onDocumentSelected,
  });

  @override
  _IOSCustomRadioDialogState createState() => _IOSCustomRadioDialogState();
}

class _IOSCustomRadioDialogState extends State<IOSCustomRadioDialog> {
  int _selectedPickerIndex = 0;

  final List<String> _documents = [
    'Transcript (English)',
    'Transcript (Thai)',
    'Certificate of Student Status (Eng)',
    'Certificate of Student Status (Thai)',
    'Certificate of using English as medium of instruction'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CupertinoAlertDialog(
        title: Text('Document Request', style: TextStyle(fontSize: 16)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('Receiving Type', style: TextStyle(fontSize: 16)),
                  Text('*', style: TextStyle(color: Colors.red)),
                ],
              ),
              ListTile(
                title:
                    Text('taken by yourself', style: TextStyle(fontSize: 13)),
                leading: CupertinoRadio<String?>(
                  value: "taken by yourself",
                  groupValue: widget.selectedOptions ?? "",
                  onChanged: widget.onOptionChanged,
                ),
              ),
              ListTile(
                title: Text('received by the authorized person',
                    style: TextStyle(fontSize: 13)),
                leading: CupertinoRadio<String?>(
                  value: "received by the authorized person",
                  groupValue: widget.selectedOptions ?? "",
                  onChanged: widget.onOptionChanged,
                ),
              ),
              ListTile(
                title: Text('postage', style: TextStyle(fontSize: 13)),
                leading: CupertinoRadio<String?>(
                  value: "postage",
                  groupValue: widget.selectedOptions ?? "",
                  onChanged: widget.onOptionChanged,
                ),
              ),
              ListTile(
                title:
                    Text('download PDF files', style: TextStyle(fontSize: 13)),
                leading: CupertinoRadio<String?>(
                  value: "download PDF files",
                  groupValue: widget.selectedOptions ?? "",
                  onChanged: widget.onOptionChanged,
                ),
              ),
              Text(
                'The document will be downloaded after the payment is completed',
                style: TextStyle(color: Colors.red, fontSize: 10),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Select Document',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text("*", style: TextStyle(color: Colors.red)),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Reason for request',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text("*", style: TextStyle(color: Colors.red)),
                ],
              ),
              CupertinoTextField(
                onChanged: widget.onReasonChanged,
                decoration: BoxDecoration(
                  color: Color(0xFFC8C3C3),
                  borderRadius: BorderRadius.circular(10),
                ),
                placeholder: 'Reason for Request',
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Current Phone Number',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text("*", style: TextStyle(color: Colors.red)),
                ],
              ),
              CupertinoTextField(
                onChanged: widget.onPhoneNumChanged,
                decoration: BoxDecoration(
                  color: Color(0xFFC8C3C3),
                  borderRadius: BorderRadius.circular(10),
                ),
                placeholder: 'Phone Number',
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'School email',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text("*", style: TextStyle(color: Colors.red)),
                ],
              ),
              CupertinoTextField(
                onChanged: widget.onSchoolEmailChanged,
                decoration: BoxDecoration(
                  color: Color(0xFFC8C3C3),
                  borderRadius: BorderRadius.circular(10),
                ),
                placeholder: 'School Email',
              ),
              SizedBox(
                height: 150,
                child: CupertinoPicker(
                  itemExtent: 32.0,
                  scrollController: FixedExtentScrollController(
                    initialItem: _selectedPickerIndex,
                  ),
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      _selectedPickerIndex = index;
                    });
                    widget.onDocumentSelected(_documents[index]);
                  },
                  children: _documents.map((String document) {
                    return Center(
                      child: Text(
                        document,
                        style: TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Text(
                'Selected Document: ${_documents[_selectedPickerIndex]}',
                style: TextStyle(fontSize: 15, color: Colors.blue),
              ),
            ],
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: widget.onSubmit,
            child: Text('Request'),
          ),
          CupertinoDialogAction(
            onPressed: widget.onCancel,
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

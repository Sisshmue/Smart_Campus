import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/document_button.dart';
import 'custom_dialog.dart';
import 'document_guide_page.dart';
import 'history_page.dart';

class DocReqHomePage extends StatefulWidget {
  @override
  State<DocReqHomePage> createState() => _DocReqHomePageState();
}

class _DocReqHomePageState extends State<DocReqHomePage> {
  // show alert box to for request new document
  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomRadioDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Document Request Page'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DocumentPageButton(
                  buttonName: 'Document Guide',
                  whenTapped: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DocumentGuidePage();
                    }));
                  },
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DocumentPageButton(
                  buttonName: 'History',
                  whenTapped: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HistoryPage();
                    }));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DocumentPageButton(
                  buttonName: 'Request new document',
                  whenTapped: () {
                    showCustomDialog(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

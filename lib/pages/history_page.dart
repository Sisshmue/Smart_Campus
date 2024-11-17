import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request History'),
      ),
      body: Column(
        children: [
          // const Padding(
          //   padding: EdgeInsets.all(8.0),
          //   child: Text(
          //     'History',
          //     style: TextStyle(
          //       fontSize: 24,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(16.0), // Margin around the table
              padding: const EdgeInsets.all(8.0), // Padding inside the border
              decoration: BoxDecoration(
                color: Colors.grey[300], // Background color for the container
                borderRadius: BorderRadius.circular(16.0), // Rounded corners
                border: Border.all(
                    color: Colors.grey, width: 1.0), // Border color and width
              ),
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('DocReq').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No requests found.'));
                  }

                  // DateFormat instance for "day-month-year" format
                  final DateFormat dateFormat = DateFormat('dd MMM yyyy');

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 20,
                      headingRowHeight: 50,
                      dataRowHeight: 50,
                      headingRowColor:
                          MaterialStateProperty.all(Color(0xFFA0D3B5)),
                      dataRowColor:
                          MaterialStateProperty.all(Color(0xFFD9D9D9)),
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Request No.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Date',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Document status',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      rows: snapshot.data!.docs.asMap().entries.map((entry) {
                        int index = entry.key + 1;
                        DocumentSnapshot doc = entry.value;

                        return DataRow(
                          cells: [
                            DataCell(Text(
                              '$index',
                              style: const TextStyle(fontSize: 14),
                            )),
                            DataCell(Text(
                              dateFormat.format(
                                  (doc['time stamp'] as Timestamp).toDate()),
                              style: const TextStyle(fontSize: 14),
                            )),
                            const DataCell(Text(
                              'Ready to pick up',
                              style: TextStyle(fontSize: 14),
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

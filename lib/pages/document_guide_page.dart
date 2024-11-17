import 'package:flutter/material.dart';

class DocumentGuidePage extends StatelessWidget {
  const DocumentGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> documents = [
      {'title': 'ALL-IN_ONE', 'image': 'images/allinonereq.jpg'},
      {'title': 'VISA RENEW', 'image': 'images/visarenew.jpg'},
      {'title': 'APPLY VISA', 'image': 'images/applyvisa.jpg'},
      {'title': 'CANCEL VISA', 'image': 'images/cancelvisa.jpg'},
      {'title': '90DAYS REPORT', 'image': 'images/90days.jpg'},
      {'title': 'RE-ENTRY', 'image': 'images/reentry.jpg'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Document Guide'),
      ),
      body: Column(
        children: [
          // const Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: Text(
          //     'Document Guide',
          //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          //   ),
          // ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImage(
                          imagePath: documents[index]['image']!,
                          title: documents[index]['title']!,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage(documents[index]['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        documents[index]['title']!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imagePath;
  final String title;

  const FullScreenImage(
      {required this.imagePath, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(imagePath, fit: BoxFit.contain),
      ),
    );
  }
}

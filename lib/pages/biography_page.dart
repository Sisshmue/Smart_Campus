import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_campus_mobile_app/services/auth_service.dart';
import 'package:http/http.dart' as http;

class BiographyPage extends StatefulWidget {
  const BiographyPage({super.key});

  @override
  State<BiographyPage> createState() => _BiographyPageState();
}

class _BiographyPageState extends State<BiographyPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchStudentData();
  }

  final _authService = AuthService();
  String? name;
  String? stu_id;
  String? major;
  String? advisor;

  Future<void> _fetchStudentData() async {
    // Simulate getting the current user's name
    name =
        await _authService.getCurrentUserName(); // Replace with actual service
    final response = await http.get(Uri.parse(
        'https://campus-backend-sqdp.onrender.com/api/students/?populate[courses][populate]=schedules&populate=advisor'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['data'] is List) {
        // If `data` is a list, search for the matching name
        for (var student in responseData['data']) {
          if (student['name'] == name) {
            setState(() {
              stu_id = student['student_id'];
              major = student['major'];
              advisor = student['advisor']['advisor_name'];
            });
            return; // Exit once the student is found
          }
        }
        print("No matching student found.");
      } else {
        print("Unexpected data format.");
      }
    } else {
      throw Exception('Failed to load students');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Biography",
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFFD9D9D9),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<String?>(
                future: _authService
                    .getCurrentUserImg(), // Assuming this returns Future<String>
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while waiting for the image URL
                    return const CircleAvatar(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    // Handle error state
                    return const CircleAvatar(
                      child: Icon(Icons.error),
                    );
                  } else if (snapshot.hasData) {
                    // Display the image once the URL is retrieved
                    return CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(snapshot.data!),
                    );
                  } else {
                    // Handle cases where no data is available
                    return const CircleAvatar(
                      child: Icon(Icons.person),
                    );
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              name == null || stu_id == null || major == null
                  ? const CircularProgressIndicator(
                      color: Color(0xFFD9D9D9),
                    ) // Loading indicator
                  : Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name!,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          stu_id!,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          major!,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          'Ajarn ${advisor!}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}

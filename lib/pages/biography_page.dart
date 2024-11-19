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
    super.initState();
    _fetchStudentData();
  }

  final _authService = AuthService();
  String? name;
  String? stu_id;
  String? major;
  String? advisor;
  String? schoolName;

  Future<void> _fetchStudentData() async {
    name = await _authService.getCurrentUserName();
    final response = await http.get(Uri.parse(
        'https://campus-backend-sqdp.onrender.com/api/students/?populate[courses][populate]=schedules&populate=advisor'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['data'] is List) {
        for (var student in responseData['data']) {
          if (student['name'] == name) {
            setState(() {
              stu_id = student['student_id'];
              major = student['major'];
              schoolName = student['school_name'];
              advisor = student['advisor']['advisor_name'];
            });
            return;
          }
        }
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
          "Student Biography",
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffD9D9D9),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture Section
              FutureBuilder<String?>(
                future: _authService.getCurrentUserImg(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  } else if (snapshot.hasError) {
                    return const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.error, color: Colors.black, size: 40),
                    );
                  } else if (snapshot.hasData) {
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(snapshot.data!),
                      backgroundColor: Colors.grey[300],
                    );
                  } else {
                    return const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.black, size: 40),
                    );
                  }
                },
              ),
              const SizedBox(height: 30),
              // Information Cards Section
              name == null || stu_id == null || major == null
                  ? const CircularProgressIndicator(
                      color: Colors.black,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoCard("Name", name!),
                        const SizedBox(height: 20),
                        _buildInfoCard("Student ID", stu_id!),
                        const SizedBox(height: 20),
                        _buildInfoCard("Major", major!),
                        const SizedBox(height: 20),
                        _buildInfoCard("School", schoolName!),
                        const SizedBox(height: 20),
                        _buildInfoCard("Advisor", 'Ajarn ${advisor!}'),
                      ],
                    ),
              const SizedBox(height: 40),
              // Motivational Footer Section
              Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            "$label:",
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

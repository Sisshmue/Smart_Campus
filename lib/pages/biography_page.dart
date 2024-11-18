// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:smart_campus_mobile_app/services/auth_service.dart';
// import 'package:http/http.dart' as http;
//
// class BiographyPage extends StatefulWidget {
//   const BiographyPage({super.key});
//
//   @override
//   State<BiographyPage> createState() => _BiographyPageState();
// }
//
// class _BiographyPageState extends State<BiographyPage> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _fetchStudentData();
//   }
//
//   final _authService = AuthService();
//   String? name;
//   String? stu_id;
//   String? major;
//   String? advisor;
//   String? schoolName;
//
//   Future<void> _fetchStudentData() async {
//     // Simulate getting the current user's name
//     name =
//         await _authService.getCurrentUserName(); // Replace with actual service
//     final response = await http.get(Uri.parse(
//         'https://campus-backend-sqdp.onrender.com/api/students/?populate[courses][populate]=schedules&populate=advisor'));
//
//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       if (responseData['data'] is List) {
//         // If `data` is a list, search for the matching name
//         for (var student in responseData['data']) {
//           if (student['name'] == name) {
//             setState(() {
//               stu_id = student['student_id'];
//               major = student['major'];
//               schoolName = student['school_name'];
//               advisor = student['advisor']['advisor_name'];
//             });
//             return; // Exit once the student is found
//           }
//         }
//         print("No matching student found.");
//       } else {
//         print("Unexpected data format.");
//       }
//     } else {
//       throw Exception('Failed to load students');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Biography",
//           style: GoogleFonts.inter(
//             textStyle: const TextStyle(
//               color: Colors.black,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: true,
//         backgroundColor: const Color(0xFFD9D9D9),
//         iconTheme: const IconThemeData(
//           color: Colors.black,
//         ),
//       ),
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               FutureBuilder<String?>(
//                 future: _authService
//                     .getCurrentUserImg(), // Assuming this returns Future<String>
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     // Show a loading indicator while waiting for the image URL
//                     return const CircleAvatar(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else if (snapshot.hasError) {
//                     // Handle error state
//                     return const CircleAvatar(
//                       child: Icon(Icons.error),
//                     );
//                   } else if (snapshot.hasData) {
//                     // Display the image once the URL is retrieved
//                     return CircleAvatar(
//                       radius: 45,
//                       backgroundImage: NetworkImage(snapshot.data!),
//                     );
//                   } else {
//                     // Handle cases where no data is available
//                     return const CircleAvatar(
//                       child: Icon(Icons.person),
//                     );
//                   }
//                 },
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               name == null || stu_id == null || major == null
//                   ? const CircularProgressIndicator(
//                       color: Color(0xFFD9D9D9),
//                     ) // Loading indicator
//                   : Column(
//                       // crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           name!,
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         Text(
//                           stu_id!,
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         Text(
//                           major!,
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         Text(
//                           schoolName!,
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         Text(
//                           'Ajarn ${advisor!}',
//                           style: TextStyle(fontSize: 15),
//                         ),
//                       ],
//                     )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:smart_campus_mobile_app/services/auth_service.dart';
// import 'package:http/http.dart' as http;
//
// class BiographyPage extends StatefulWidget {
//   const BiographyPage({super.key});
//
//   @override
//   State<BiographyPage> createState() => _BiographyPageState();
// }
//
// class _BiographyPageState extends State<BiographyPage> {
//   @override
//   void initState() {
//     super.initState();
//     _fetchStudentData();
//   }
//
//   final _authService = AuthService();
//   String? name;
//   String? stu_id;
//   String? major;
//   String? advisor;
//   String? schoolName;
//
//   Future<void> _fetchStudentData() async {
//     name = await _authService.getCurrentUserName();
//     final response = await http.get(Uri.parse(
//         'https://campus-backend-sqdp.onrender.com/api/students/?populate[courses][populate]=schedules&populate=advisor'));
//
//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       if (responseData['data'] is List) {
//         for (var student in responseData['data']) {
//           if (student['name'] == name) {
//             setState(() {
//               stu_id = student['student_id'];
//               major = student['major'];
//               schoolName = student['school_name'];
//               advisor = student['advisor']['advisor_name'];
//             });
//             return;
//           }
//         }
//         print("No matching student found.");
//       } else {
//         print("Unexpected data format.");
//       }
//     } else {
//       throw Exception('Failed to load students');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           "Biography",
//           style: GoogleFonts.montserrat(
//             fontWeight: FontWeight.bold,
//             fontSize: 24,
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFFD9D9D9),
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.black),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//           child: SingleChildScrollView(
//             child: Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   FutureBuilder<String?>(
//                     future: _authService.getCurrentUserImg(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const CircleAvatar(
//                           radius: 55,
//                           child: CircularProgressIndicator(),
//                         );
//                       } else if (snapshot.hasError) {
//                         return const CircleAvatar(
//                           radius: 55,
//                           child: Icon(Icons.error, size: 50),
//                         );
//                       } else if (snapshot.hasData) {
//                         return CircleAvatar(
//                           radius: 55,
//                           backgroundImage: NetworkImage(snapshot.data!),
//                         );
//                       } else {
//                         return const CircleAvatar(
//                           radius: 55,
//                           child: Icon(Icons.person, size: 50),
//                         );
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   name == null || stu_id == null || major == null
//                       ? const CircularProgressIndicator(
//                           color: const Color(0xFFD9D9D9),
//                         )
//                       : Card(
//                           color: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           elevation: 10,
//                           child: Padding(
//                             padding: const EdgeInsets.all(20),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   name!,
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 26,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.blueAccent,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Text(
//                                   'Student ID: $stu_id',
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Text(
//                                   'Major: $major',
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Text(
//                                   'School: $schoolName',
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Text(
//                                   'Advisor: $advisor',
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.greenAccent,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

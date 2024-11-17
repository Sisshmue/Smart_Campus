import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_campus_mobile_app/pages/doc_req_home_page.dart';
import 'package:smart_campus_mobile_app/pages/map_page.dart';
import 'package:smart_campus_mobile_app/services/auth_service.dart';
import 'events_home_page.dart';
import 'package:http/http.dart' as http;
import 'calendar_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchStudentData();
  }

  final _authService = AuthService();
  String? name;
  String? stu_id;

  Future<void> _fetchStudentData() async {
    // Simulate getting the current user's name
    name =
        await _authService.getCurrentUserName(); // Replace with actual service
    final response = await http.get(Uri.parse(
        'https://campus-backend-sqdp.onrender.com/api/students/?populate[courses][populate]=schedules'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['data'] is List) {
        // If `data` is a list, search for the matching name
        for (var student in responseData['data']) {
          if (student['name'] == name) {
            setState(() {
              stu_id = student['student_id'];
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
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: IconButton(
              icon: Icon(Icons.menu), // Use a custom icon or modify its style
              onPressed: () {
                Scaffold.of(context)
                    .openDrawer(); // Open the drawer when the icon is tapped
              },
              tooltip: 'Open Navigation Drawer',
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
              ListTile(
                title: Text('Log out'),
                onTap: () {
                  _authService.signOut();
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
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
                          radius: 30,
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
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name ?? 'Loading'),
                      Text(stu_id ?? 'Loading...'),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // this is for map
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const MapPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin =
                              Offset(1.0, 0.0); // Start from the right
                          const end = Offset.zero; // End at the center
                          const curve = Curves.easeInOut;

                          // Define the animation
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          // Slide transition
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 160,
                    height: 160,
                    child: Image.asset('images/map.png'),
                  ),
                ),
                const SizedBox(
                  width: 35,
                ),

                //this is for news
                GestureDetector(
                  child: SizedBox(
                    width: 160,
                    height: 160,
                    child: Image.asset('images/Newspage.png'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            EventsHomePage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.1, 0.0); // Start from the left
                          const end = Offset.zero; // End at the center
                          const curve = Curves.ease;

                          // Define the animation
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          // Slide transition
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // this is for document request
                GestureDetector(
                  child: SizedBox(
                    width: 160,
                    height: 160,
                    child: Image.asset('images/documentReq.png'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            DocReqHomePage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.1, 0.0); // Start from the left
                          const end = Offset.zero; // End at the center
                          const curve = Curves.ease;

                          // Define the animation
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          // Slide transition
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 35,
                ),

                // this is for class schedule

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const CalendarPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin =
                              Offset(1.0, 0.0); // Start from the right
                          const end = Offset.zero; // End at the center
                          const curve = Curves.easeInOut;

                          // Define the animation
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          // Slide transition
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 160,
                    width: 160,
                    child: Image.asset('images/schedule.png'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_campus_mobile_app/services/auth_service.dart';
import 'events_home_page.dart';

import 'calendar_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                "Let's explore \nsomething new",
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    width: 160,
                    height: 160,
                    child: Image.asset('images/map.png'),
                  ),
                ),
                const SizedBox(
                  width: 35,
                ),
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
                            const EventsHomePage(),
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

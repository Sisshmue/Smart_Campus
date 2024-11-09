import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'chat_page.dart';
import 'contact_page.dart';
import 'home_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int selectedIndex = 0;

  final List<Widget> page = [
    HomePage(),
    ChatPage(),
    ContactPage(),
  ];

  void _ontabChange(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      home: Scaffold(
        bottomNavigationBar: Container(
          color: const Color(0xFFD9D9D9),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 15,
            ),
            child: GNav(
              backgroundColor: Color(0xffD9D9D9),
              activeColor: Colors.white,
              color: Colors.black,
              tabBackgroundColor: Colors.grey.shade800,
              padding: EdgeInsets.all(16),
              onTabChange: _ontabChange,
              gap: 8,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.smart_toy_outlined,
                  text: "Bot",
                ),
                GButton(
                  icon: Icons.account_circle_rounded,
                  text: "Contact",
                ),
              ],
            ),
          ),
        ),
        body: page[selectedIndex],
      ),
    );
  }
}

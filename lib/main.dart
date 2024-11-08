import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smart_campus_mobile_app/screen/auth_screen.dart';
import 'package:smart_campus_mobile_app/screen/chat_screen.dart';
import 'package:smart_campus_mobile_app/screen/contact_page.dart';
import 'package:smart_campus_mobile_app/screen/home_page.dart';
import 'firebase_options.dart';

//final navigatorKey = GlobalKey<NavigatorState>();

// Siss Hmue main method
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await FirebaseApi().initNotification();
//   FirebaseFirestore.instance.settings = const Settings(
//     persistenceEnabled: true,
//   );
//   runApp(MultiProvider(
//     providers: [ChangeNotifierProvider(create: (_) => EventButtonProvider())],
//     child: Demo(),
//   ));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AuthPage(),
  ));
}

//I added this widget in navigation_screen.dart
//Siss Hmue Demo
// class Demo extends StatefulWidget {
//   const Demo({super.key});
//
//   @override
//   State<Demo> createState() => _DemoState();
// }
//
// class _DemoState extends State<Demo> {
//   int selectedIndex = 0;
//
//   final List<Widget> page = [
//     const HomePage(),
//     ChatScreen(),
//     const ContactPage()
//   ];
//
//   void _ontabChange(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       // home: HomePage(),
//       home: Scaffold(
//         bottomNavigationBar: Container(
//           color: const Color(0xFFD9D9D9),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(
//               vertical: 20.0,
//               horizontal: 15,
//             ),
//             child: GNav(
//               backgroundColor: Color(0xffD9D9D9),
//               activeColor: Colors.white,
//               color: Colors.black,
//               tabBackgroundColor: Colors.grey.shade800,
//               padding: EdgeInsets.all(16),
//               onTabChange: _ontabChange,
//               gap: 8,
//               tabs: const [
//                 GButton(
//                   icon: Icons.home,
//                   text: "Home",
//                 ),
//                 GButton(
//                   icon: Icons.smart_toy_outlined,
//                   text: "Bot",
//                 ),
//                 GButton(
//                   icon: Icons.account_circle_rounded,
//                   text: "Contact",
//                 ),
//               ],
//             ),
//           ),
//         ),
//         body: page[selectedIndex],
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_campus_mobile_app/provider/event_button_provider.dart';
import 'package:smart_campus_mobile_app/screen/auth_screen.dart';
import 'package:smart_campus_mobile_app/screen/events_home_page.dart';
import 'components/flutter_api.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotification();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => EventButtonProvider())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      navigatorKey: navigatorKey,
      routes: {
        '/EventsScreen': (context) => EventsHomePage(),
      },
    );
  }
}

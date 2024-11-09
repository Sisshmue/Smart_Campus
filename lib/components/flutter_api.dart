import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:smart_campus_mobile_app/main.dart';

class FirebaseApi {
  //create instances of FirebaseMessaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  //Function to initialise notification
  Future<void> initNotification() async {
    //request permission from user
    await _firebaseMessaging.requestPermission();

    //fetch the FCM token for this device
    final FCMToken = await _firebaseMessaging.getToken();

    //print the token
    if (FCMToken != null) {
      print("Token: $FCMToken");
    } else {
      print("Failed to retrieve FCM token.");
    }

    initPushNotification();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed('/EventsScreen');
  }

  //for the background
  Future initPushNotification() async {
    //handle notification if the app is closed or open
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    //attach each listener when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}

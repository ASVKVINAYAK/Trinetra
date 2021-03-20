import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trinetra/constants.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trinetra',
      theme: darkTheme,
      home: MessageHandler(),
    );
  }
}

class MessageHandler extends StatefulWidget {
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  // final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  StreamSubscription iosSubscription;

  @override
  void initState() {
    super.initState();
    initalizeFCM();
    // _saveDeviceToken();
  }

  @override
  void dispose() {
    if (iosSubscription != null) iosSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }

  /// Get the token, save it to the database for current user
  _saveDeviceToken() async {
    // Get the token for this device
    String fcmToken = await _fcm.getToken();
    log(fcmToken);
  }

  initalizeFCM() async {
    NotificationSettings settings;
    settings = await _fcm.getNotificationSettings();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.notDetermined) {
      print('User didnt get permission request');
      settings = await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    } else {
      print('User declined or has not accepted permission');
      return;
    }

    _saveDeviceToken();

    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    // if (initialMessage?.data['type'] == 'chat') {}
    log(initialMessage?.data?.toString() ?? 'No initial message');

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['type'] == 'chat') {
        // Navigator.pushNamed(context, '/chat',
        //   arguments: ChatArguments(message));
      }
    });

    //
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      /// Down here is code for flutter local notification so `import package flutter_local_notification:`
      //   RemoteNotification notification = message.notification;
      //   AndroidNotification android = message.notification?.android;

      //   // If `onMessage` is triggered with a notification, construct our own
      //   // local notification to show to users using the created channel.
      //   if (notification != null && android != null) {
      //     FlutterLocalNotifications.show(
      //         notification.hashCode,
      //         notification.title,
      //         notification.body,
      //         NotificationDetails(
      //             NotificationDetailsAndroid(
      //               "0",
      //               "New Message",
      //               message.notification.body,
      //               icon: android?.smallIcon,
      //               enableVibration: true,
      //               importance: Importance.High,
      //             ),
      //             NotificationDetailsIOS()));
      //   }
    });
  }
}

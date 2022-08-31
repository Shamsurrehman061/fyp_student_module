import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


import 'Authentication/auth.dart';
import 'Landing/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Notifications/notification_service.dart';


Future<void> backgroundHandler(RemoteMessage message)async {
  NotificationService.display(message);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    NotificationService.initialize();
    //foreground messages
    FirebaseMessaging.onMessage.listen((message){
      NotificationService.display(message);
    });


    //termination state
    FirebaseMessaging.onMessageOpenedApp.listen((message){
      NotificationService.initialize();
      NotificationService.display(message);
    });

  }




  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'COMSIANS CART',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: LandingPage(auth: Auth(),),
    );
  }
}
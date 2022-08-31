import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class NotificationService{


  static final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();




  static void initialize(){
    final InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings(""),
    );



    notificationsPlugin.initialize(initializationSettings);
  }


  static void display(RemoteMessage message)async{


    NotificationDetails details =const NotificationDetails(
      android: AndroidNotificationDetails(
        "notification",
        "notification details",
        importance: Importance.max,
        priority: Priority.high,
        color: Colors.black,
      ),
    );



    notificationsPlugin.show(
        1,
        message.notification!.title,
        message.notification!.body,
        details,
    );

  }





}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  String msg = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  Future getData()async{
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final data =await FirebaseDatabase.instance.ref().child("Approve User").child(uid).get();

    Map val = data.value as Map;

   setState((){
     msg = val['msg'];
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Notifications"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children:
            [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Expanded(child: Padding(padding:const EdgeInsets.all(10.0) ,child: Text(msg, style: TextStyle(fontSize: 18, color: Colors.black),))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

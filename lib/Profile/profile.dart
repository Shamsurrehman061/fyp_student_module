import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  String name = "";
  String regNo = "";
  String password = "";
  String route = "";
  String email = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  Future getData() async{
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final data = await FirebaseDatabase.instance.ref().child("Approve User").child(uid).get();

    Map val = data.value as Map;

    setState(() {
      name = val["Name"];
      regNo = val["Registeration No"];
      password = val["password"];
      route = val["route"];
      email = val["Email"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Student Information"),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Center(
          child: Column(
            children: [
              Text("Name : " + name),
              Text("Roll No : " + regNo),
              Text("Email : " + email),
              Text("Routes : " + route),
              Text("Password : " + password),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../Authentication/auth.dart';
import 'my_Login.dart';


class SelectRoutes extends StatefulWidget {
  const SelectRoutes({Key? key, required this.regNo, required this.name, required this.email, required this.confirmPassword, required this.password}) : super(key: key);

  final String name;
  final String regNo;
  final String email;
  final String password;
  final String confirmPassword;

  @override
  _SelectRoutesState createState() => _SelectRoutesState();
}

class _SelectRoutesState extends State<SelectRoutes>{

  bool isLoading = false;

  final db = FirebaseDatabase.instance.ref().child("Bus Routes");
  final dbb = FirebaseDatabase.instance.ref().child("User");
  String result = "";
  bool isSelected = true;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:const Text("Select Route"),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: FirebaseAnimatedList(
                  defaultChild:const Center(child: CircularProgressIndicator(strokeWidth: 1.5, color: Colors.black,),),
                  query: db,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation animation, int index){

                    final val = snapshot.key.toString();

                    if(isSelected)
                      {
                        result = val;
                        isSelected = false;
                      }
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
                          child: RadioListTile(
                            title: Text(val!),
                            groupValue: result,
                            value: val,
                            onChanged: (value){
                              setState(() {
                                result = val;
                              });
                            },),
                        ),
                      ],
                    );
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize:const Size(200, 50),
                ),
                onPressed:create, child: isLoading ?
              const CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 1,
              ) : const Text("Submit"),),
            ],
          ),
        ),
      ),
    );
  }

  Future<AlertDialog?> create() async{

   String? token =await FirebaseMessaging.instance.getToken();

    setState(() {
      isLoading = true;
    });

    try{
      dbb.child(widget.name).set({
        "Name": widget.name,
        "Email": widget.email,
        "password": widget.password,
        "Registeration No": widget.regNo,
        "Confirm Password" : widget.confirmPassword,
        "route" : result,
        "token" : token,
      });

      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        isLoading = false;
      });

      showDialog(
          context: context,
          builder: (BuildContext context){
            return  AlertDialog(
              title:const Text("Request Submitted"),
              content:const Text("Make sure the information you entered is correct. We will send you a verification email to verify your account"),
              actions: [
                ElevatedButton(
                  onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyLogin(auth: Auth(),)));
              }, child:const Text("Ok"))],
            );
          });
    }
    catch(e)
    {
      print(e.toString());
    }
  }
}

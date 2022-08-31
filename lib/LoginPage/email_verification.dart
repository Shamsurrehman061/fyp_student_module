import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_record_bus/HomePage/home_page.dart';

import '../Authentication/auth.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool isEmailVerified = false;
  bool verifyEmail = true;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified)
      {
        sendVerificationEmail();
        timer = Timer.periodic(const Duration(seconds: 3), (_) => checkEmail());
      }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  Future checkEmail()async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState((){
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async{
    try{
      final user =  FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState((){
        verifyEmail = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        verifyEmail = true;
      });
    }
    catch(e)
    {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) => isEmailVerified ? HomePage(auth: Auth()) : Scaffold(
    appBar: AppBar(
      title: const Text("Email Verification"),
    ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text("A verification email has been sent to your email", textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0),)),

          const SizedBox(
            height: 20.0,
          ),

          ElevatedButton.icon(onPressed: verifyEmail ? sendVerificationEmail : null,
            icon: const Icon(Icons.email), label: const Text("Resend email"),
            style: ElevatedButton.styleFrom(minimumSize:const Size.fromHeight(50.0)),),

          const SizedBox(
            height: 20.0,
          ),

          ElevatedButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          }, child:const Text("Cancel"), style: ElevatedButton.styleFrom(minimumSize:const Size(180,50), ))
        ],
      ),
    ),
  );

  }


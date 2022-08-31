import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {


  final TextEditingController _forgotPasswordController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  String get email => _forgotPasswordController.text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Forgot password"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: _forgotPasswordController,
                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return "* Required";
                  }
                  else if(!RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value))
                  {
                    return "Enter correct email";
                  }
                  else
                  {
                    return null;
                  }
                },
              ),

              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(onPressed:() =>  resetPassword, child:const Text("Send reset link")),
            ],
          ),
        ),
      ),
    );
  }

   resetPassword() async{
    print(email);
    if(_form.currentState!.validate())
    {
        await auth.sendPasswordResetEmail(email: email);
    }
  }
}

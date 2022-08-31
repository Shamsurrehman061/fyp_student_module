// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:student_record_bus/LoginPage/register_page.dart';


import '../Authentication/auth.dart';
import 'forgot_password.dart';


class MyLogin extends StatefulWidget {
  const MyLogin({Key? key, required this.auth}) : super(key: key);

  final Auth auth;
  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  bool isLoading = false;
  bool passHidden = true;

  @override
  Widget build(BuildContext context){

    login() async{
      await widget.auth.signInWithEmailAddress(_email, _password).catchError((e){
        showDialog(
            context: context,
            builder: (BuildContext context){
              return  AlertDialog(
                title:const Text("Sign In Failed"),
                content:const Text("Enter correct credentials"),
                actions: [
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child:const Text("Ok")),
                ],
              );
            });
      });
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration:const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
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
                controller: _emailController,
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 30,
              ),
              TextFormField(
                obscureText: passHidden,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(passHidden ? Icons.visibility : Icons.visibility_off),
                    onPressed: togglePass,
                  ),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                controller: _passwordController,
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return "* Required";
                  }
                  else if(value.length < 6)
                  {
                    return "Password must be greater than 6 digits";
                  }
                  else
                  {
                    return null;
                  }
                },
              ),

              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const ForgotPass()));
                      },
                      child: const Text("forgot password?", style: TextStyle(color: Colors.indigo),)),
                ],
              ),


              // ignore: prefer_const_constructors
              SizedBox(
                height: 40,
              ),

              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: ()async{
                  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                  if(_form.currentState!.validate())
                    {
                      setState(() {
                        isLoading = true;
                      });


                      login();
                      await Future.delayed(const Duration(seconds: 5));
                      setState(() {
                        isLoading = false;
                      });
                    }
                },
                child: isLoading ?const SizedBox(
                  height: 16.0,
                  width: 16.0,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1.5,
                  ),
                ) : const Text("sign In"),
                style: ElevatedButton.styleFrom(
                  minimumSize:const Size(350, 50),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const MyRegister())),
                  child:const Text("don't have account? Create account", style: TextStyle(fontSize: 18,),)),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void togglePass(){
    setState(() {
      passHidden = !passHidden;
    });
  }

}
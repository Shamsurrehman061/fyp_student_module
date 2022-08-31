
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:email_auth/email_auth.dart';
import 'package:student_record_bus/LoginPage/select_route.dart';
import '../Authentication/auth.dart';
import 'my_Login.dart';



class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {


  final databaseReference = FirebaseDatabase.instance.ref().child("Bus Routes");
  EmailAuth emailAuth = EmailAuth(sessionName: "TEXT SESSION");


  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _regController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String get _name => _nameController.text;
  String get _reg => _regController.text;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  String get _confirmPassword => _confirmPasswordController.text;
  String get otp => otpController.text;

  bool isHiddenPass = true;
  bool isHiddenConf = true;
  bool isLoading = false;






  @override
  Widget build(BuildContext context){

    var confirmPassword;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyLogin(auth: Auth(),)));
          },
          icon:const Icon(Icons.arrow_back),
        ),
        title:const Text("Registeration"),
        centerTitle: true,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              children: [
                TextFormField(
                  decoration:const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: "Name",
                  ),
                  controller: _nameController,
                  validator: (value){
                    if(value!.isEmpty)
                    {
                      return "* Required";
                    }
                    else if(!RegExp(r'^[a-z A-z]+$').hasMatch(value))
                    {
                      return "Enter correct name";
                    }
                    else
                    {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  decoration:const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: "Registeration No",
                  ),
                  controller: _regController,
                  validator: (value){
                    if(value!.isEmpty)
                    {
                      return "* Required";
                    }
                    else if(!RegExp(r'^[a-z]').hasMatch(value))
                    {
                      return "Enter correct name";
                    }
                    else
                    {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  decoration:const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: "Email",
                  ),
                  controller: _emailController,
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
                  height: 25,
                ),
                TextFormField(
                  obscureText: isHiddenPass,
                  controller: _passwordController,
                  validator: (value){
                    confirmPassword = value;
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
                  decoration: InputDecoration(
                    border:const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(isHiddenPass ? Icons.visibility : Icons.visibility_off),
                      onPressed: Pass,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: isHiddenConf,
                  validator: (value){
                    if(value!.isEmpty)
                    {
                      return "* Required";
                    }
                    else if(value.length < 6)
                    {
                      return "Password must be greater than 6 digits";
                    }
                    else if(value != confirmPassword)
                    {
                      return "Password must be same";
                    }
                    else
                    {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border:const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: "Confirm Password",
                    suffixIcon: IconButton(
                      icon: Icon(isHiddenConf ? Icons.visibility : Icons.visibility_off),
                      onPressed: confirmPass,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize:const Size(360.0, 50.0)
                  ),
                  onPressed: () async{
                    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                    if(_form.currentState!.validate())
                    {
                      setState(() {
                        isLoading = true;
                      });
                      await Future.delayed(const Duration(seconds: 5));
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SelectRoutes(
                            name: _name,email: _email, password: _password,
                            confirmPassword: _confirmPassword, regNo: _reg,)));
                    }
                  },
                  child:isLoading ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1.5,
                      )) : const Text('Select Route'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void change(String value) {
    setState(() {
    });
  }

  void Pass() {
    setState(() {
      isHiddenPass = !isHiddenPass;
    });
  }

  void confirmPass() {
    setState(() {
      isHiddenConf = !isHiddenConf;
    });
  }
}

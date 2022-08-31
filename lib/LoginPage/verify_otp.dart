import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';


class VerifyOtp extends StatefulWidget {
  const VerifyOtp({Key? key}) : super(key: key);


  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {

  EmailAuth emailAuth = EmailAuth(sessionName: "TEXT SESSION");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailAuth = EmailAuth(sessionName: "TEXT SESSION");
  }

  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  String get otp => otpController.text;

  bool isLoading = false;
  String email = "fascinatingswitzerland@gmail.com";

  void sendOtp() async{

    emailAuth.sessionName = "send otp";
    bool res = await emailAuth.sendOtp(recipientMail: email);
    if(res)
    {
      print("OTP send");
    }
    else
    {
      print("OTP not send");
    }
  }

  void verifyOtp() {
    bool res =  emailAuth.validateOtp(recipientMail: email, userOtp: otp);
     if(res)
     {
       print("email is valid");
     }
     else
     {
       print("email is inValid");
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Otp"),
      ),

      body: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children:
            [
              TextFormField(
                decoration: InputDecoration(
                  contentPadding:const EdgeInsets.symmetric(horizontal: 10.0),
                  suffixIcon: TextButton(onPressed: sendOtp, child:const Text("send OTP")),
                ),
                textAlign: TextAlign.justify,
                controller: otpController,
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return "* Required";
                  }
                  else if(!RegExp(r'^[0-9]+$').hasMatch(value))
                  {
                    return "Enter Valid OTP";
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize:const Size(360.0, 45.0)
                ),
                onPressed: () async{
                  if(_form.currentState!.validate())
                  {
                    setState(() {
                      isLoading = true;
                    });
                    await Future.delayed(const Duration(seconds: 5));
                    setState(() {
                      isLoading = false;
                    });

                    verifyOtp();
                  }
                },
                child:isLoading ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1.5,
                    )) : const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

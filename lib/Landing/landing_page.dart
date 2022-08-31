import 'package:flutter/material.dart';
import '../Authentication/auth.dart';
import '../LoginPage/email_verification.dart';
import '../LoginPage/my_Login.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key, required this.auth}) : super(key: key);

  final Auth auth;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.auth.onAuthStateChange,
        builder: (BuildContext context, snapshot){


          if(snapshot.connectionState == ConnectionState.active)
            {
              Users? user = snapshot.data as Users?;
              if(user != null)
                {
                  return EmailVerification();
                }
              else
                {
                  return MyLogin(auth: Auth(),);
                }
            }
          else
            {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
    });
  }
}

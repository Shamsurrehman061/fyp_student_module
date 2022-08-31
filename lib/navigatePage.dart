import 'package:flutter/material.dart';

import 'Authentication/auth.dart';
import 'Feedback/feedback.dart';
import 'HomePage/home_page.dart';

class NavigatePage extends StatefulWidget {
  const NavigatePage({Key? key}) : super(key: key);

  @override
  State<NavigatePage> createState() => _NavigatePageState();
}

class _NavigatePageState extends State<NavigatePage> {
  int _selectedIndex = 0;

  static List<Widget> list = [
    HomePage(auth: Auth(),),
    const FeedBack(),
  ];

  void navigateTo(int index)
  {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: list.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items:const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home,),
            label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.feedback_rounded,),
            label: "Feedback",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: navigateTo,
        backgroundColor: Colors.blue[600],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
    ),
    );
  }
}

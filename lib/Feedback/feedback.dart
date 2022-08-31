import 'package:flutter/material.dart';

class FeedBack extends StatelessWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title:const Text("Feedback"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue[400]!,
                Colors.blue[600]!,
                Colors.blue[700]!,
                Colors.blue[800]!,
              ],
            ),
          ),
        ),
      ),
      body:const Center(
        child: Text("Feedback"),
      ),
    );
  }
}

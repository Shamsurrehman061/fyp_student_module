import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:student_record_bus/BusSchedule/bus_list.dart';

import '../Authentication/auth.dart';
import '../HomePage/home_page.dart';


class RoutList extends StatefulWidget {
  const RoutList({Key? key}) : super(key: key);

  @override
  _RoutListState createState() => _RoutListState();
}

class _RoutListState extends State<RoutList> {
  
  final db = FirebaseDatabase.instance.ref().child("Bus Routes");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context, PageTransition(child: HomePage(auth: Auth(),), type: PageTransitionType.leftToRight));
        }, icon:const Icon(Icons.arrow_back),),
        title:const Text("Routes List"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FirebaseAnimatedList(
          defaultChild: Center(child: CircularProgressIndicator(strokeWidth: 1.5, color: Colors.black,),),
          query: db,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation animation, int index){

            final key = snapshot.key.toString();

            Map val = snapshot.value as Map;
            final initialPoint = val["Initial Point"];
            final terminationPoint = val["Destination Point"];

            return GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => BusList(path: key,)));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        initialPoint,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Text("->"),
                      ),
                      Text(
                        terminationPoint,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

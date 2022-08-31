import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:page_transition/page_transition.dart';
import 'package:student_record_bus/track_buses/track_buses_stations.dart';


import '../Authentication/auth.dart';
import '../HomePage/home_page.dart';




class TrackBuses extends StatefulWidget {
  const TrackBuses({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  State<TrackBuses> createState() => _TrackBusesState();
}

class _TrackBusesState extends State<TrackBuses> {
  final db = FirebaseDatabase.instance.ref().child("Bus Routes");

  @override
  Widget build(BuildContext context){

    final dbb = db.child(widget.path).child("Buses");

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context, PageTransition(child: HomePage(auth: Auth(),), type: PageTransitionType.leftToRight));
        }, icon: Icon(Icons.arrow_back)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue[400]!,
                  Colors.blue[600]!,
                  Colors.blue[700]!,
                  Colors.blue[800]!,
                ]
            ),
          ),
        ),
        title:const Text("Bus List"),
        centerTitle: true,
        toolbarHeight: 90,
      ),

      body: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 20.0),
        child: FirebaseAnimatedList(
          query: dbb,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,Animation animation ,int index){

            final data = snapshot.key.toString();

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.indigo.shade200,
                    borderRadius: BorderRadius.circular(20.0)
                ),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrackBusesStations(busNo: data, path: widget.path,)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ListTile(
                      leading: Text(
                        "Bus No : " + data,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      trailing: const Icon(Icons.location_on_outlined),
                    ),
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
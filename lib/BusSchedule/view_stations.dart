

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_record_bus/BusSchedule/time_line_panel.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../map/view_root.dart';
import 'bus_list.dart';

class Stations extends StatefulWidget {

  const Stations({Key? key,required this.busNo, this.path}) : super(key: key);
  final String? path;
  final String busNo;

  @override
  _StationsState createState() => _StationsState();
}

class _StationsState extends State<Stations> {


  List<LatLng> latLng = [];

  final db = FirebaseDatabase.instance.ref().child("Bus Routes");

  bool flag = false;


  @override
  Widget build(BuildContext context) {
    final reference = db.child(widget.path!).child("Buses").child(widget.busNo!).child("Stations");

    return Scaffold(

      appBar: AppBar(
        leading: IconButton(icon:const Icon(Icons.arrow_back), onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (builder) => BusList(path: widget.path,)));
        },),
        centerTitle: true,
        title:const Text("Stations"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: FirebaseAnimatedList(
          defaultChild: const Center(child: CircularProgressIndicator()),
          query: reference,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,Animation animation, int index){

            Map value = snapshot.value as Map;
            String loc = snapshot.key.toString();
            String latitude = value['latitude'];
            String longitude = value['longitude'];
            double lati = double.parse(latitude);
            double long = double.parse(longitude);

            latLng.add(LatLng(lati, long));

            return  TimelineTile(
              isFirst: flag == false ? true : false,
              indicatorStyle:const IndicatorStyle(color: Colors.indigo),
              endChild: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: BusTimingPanel(
                  onPress: (){
                  },
                  departureTime: value['departure time'],
                  arrivalTime: value['arrival time'],
                  location: value['location'],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

   route() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewRoot(busNo: widget.busNo, latLng: latLng, path: widget.path!,)));
  }
}

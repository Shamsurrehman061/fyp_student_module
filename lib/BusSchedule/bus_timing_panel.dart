import 'package:flutter/material.dart';

class TimingPanel extends StatelessWidget {
  const TimingPanel({required Key key,  required this.arrivalTime, required this.departureTime, required this.location}) : super(key: key);

  final String location;
  final String arrivalTime;
  final String departureTime;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(left: 50.0, top: 20.0),
      child: Container(
        decoration:const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding:const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(location, style: const TextStyle(fontSize: 20),),
              Text("${arrivalTime == null ? "" : "Arrival time $arrivalTime"} " "\nDeparture time : $departureTime", style: const TextStyle(fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }
}
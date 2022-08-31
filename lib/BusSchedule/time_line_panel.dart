import 'package:flutter/material.dart';
class BusTimingPanel extends StatefulWidget{
  const BusTimingPanel(
      {Key? key,
      required this.arrivalTime,
      required this.departureTime,
      required this.location,
      required this.onPress})
      : super(key: key);

  final String arrivalTime;
  final String departureTime;
  final String location;
  final VoidCallback onPress;

  @override
  _BusTimingPanelState createState() => _BusTimingPanelState();
}
class _BusTimingPanelState extends State<BusTimingPanel>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Card(
        elevation: 0,
        child: SizedBox(
          height: 130,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.location,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Departure time : " + widget.departureTime,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Arrival time : " + widget.arrivalTime,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 100.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
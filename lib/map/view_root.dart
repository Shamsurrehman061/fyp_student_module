import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../secrets.dart';

class ViewRoot extends StatefulWidget {
  const ViewRoot({Key? key, required this.path, required this.busNo, required this.latLng}) : super(key: key);

  final String path;
  final String busNo;
  final List<LatLng> latLng;

  @override
  _ViewRootState createState() => _ViewRootState();
}

class _ViewRootState extends State<ViewRoot> {

  GoogleMapController? mapController;
  List<Marker> listMarker = <Marker>[];
  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  String latitude = "";
  String longitude = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async{
      FirebaseDatabase.instance.ref().child("Bus").child(widget.busNo).onValue.listen((event){
        _getPoints();
      });
    });
  }
  _getPoints() async{
    final initialPoints =await FirebaseDatabase.instance.ref().child("Bus").child(widget.busNo).get();
    Map data = initialPoints.value as Map;
    setState((){
      latitude = data['Latitude'];
      longitude = data['Longitude'];
    });
    double latii = double.parse(latitude);
    double longg = double.parse(longitude);
    getsMarker(latii, longg, "peshawar");
  }

  getsMarker(double fLati, double fLong, String location){
    Marker initialPointMarker = Marker(
      markerId: MarkerId(location),
      position: LatLng(fLati, fLong),
      icon:  BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueYellow,
      ),
    );
    setState((){
      listMarker.add(initialPointMarker);
    });
  }

  _createPolylines(
      double startLatitude,
      double startLongitude,
      double destinationLatitude,
      double destinationLongitude,
      ) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Secrets.kApiKey, // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      // travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
  }

  getData()async{
    for(int i=0; i < widget.latLng.length; i++)
    {
      print(widget.latLng[i].latitude);
      double lati = widget.latLng[i].latitude;
      double long = widget.latLng[i].longitude;
      log.d(lati, long);
      getMarker(lati, long, "$i");
    }
  }

  getMarker(double fLati, double fLong, String location) async{
    Marker initialPointMarker = Marker(
      markerId: MarkerId(location),
      position: LatLng(fLati, fLong),
      icon: BitmapDescriptor.defaultMarker,
    );
    setState((){
      listMarker.add(initialPointMarker);
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: GoogleMap(
        markers: listMarker.map((e) => e).toSet(),
        onMapCreated: (controller){
          mapController = controller;
        },
        initialCameraPosition:const CameraPosition(
          target: LatLng(34.16, 73.22),
          zoom: 10,
        ),
        polylines: Set<Polyline>.of(polylines.values),
      ),
    );
  }
}
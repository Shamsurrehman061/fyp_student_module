import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../Authentication/auth.dart';
import '../BusSchedule/bus_list.dart';
import '../BusSchedule/root_list.dart';
import '../Notifications/notification.dart';
import '../Profile/profile.dart';
import '../track_buses/route_track.dart';
import '../track_buses/track_bus.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.auth}) : super(key: key);

  final Auth auth;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String regNo = "";
  String name = "";
  String firstLetter = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchEmail();
  }

   fetchEmail() async
  {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final data = await FirebaseDatabase.instance.ref().child("Approve User").child(uid).get();

    Map values = data.value as Map;
    setState(() {
      regNo = values['Registeration No'];
      name = values['Name'];
      firstLetter = name[0];
    });
  }

  final db = FirebaseDatabase.instance.ref().child("User");



  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 120,
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
                ]
            ),
          ),
        ),
        foregroundColor: Colors.white,
        title: const Text("Home Page",
        style: TextStyle(fontWeight: FontWeight.bold,
        fontSize: 28,
        ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications,color: Colors.white,), onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const Notifications()));
          },
            iconSize: 30,
          ),
        ],
      ),
      drawer: Drawer(
        elevation: 0,
        child: ListView(
          children:  [
              DrawerHeader(
              padding: EdgeInsets.zero,
              decoration:const BoxDecoration(
              ),
              child: UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text(firstLetter, style:const TextStyle(fontSize: 20),),
                ),
              accountName:  Text(regNo, style:const TextStyle(fontSize: 20),),
              accountEmail: Text(name , style:const TextStyle(fontSize: 20),),

            ),
            ),

            ListTile(
              title:const Text("Profile",  style: TextStyle(fontSize: 20),),
              leading:const Icon(Icons.person, color: Colors.black,),
              onTap: profile,
            ),

            const Divider(),
             ListTile(
              title:const Text("Log out",  style: TextStyle(fontSize: 20),),
              leading:const Icon(Icons.logout, color: Colors.black,),
               onTap: () async
               {
                 await widget.auth.signOut();
               },
            ),
          ],
        ),
      ),


      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Center(
          child: Column(
            children: [

              InkWell(
                onTap: busSchedule,
                child: Container(
                  height: 200.0,
                  width: 350.0,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Column(
                    children: [
                      Container(
                        height : 150,
                        width: 250,
                        child: Image.asset("assets/bus.png",color: Colors.white,),
                      ),
                      const Text("Bus Schedule", style: TextStyle(fontSize: 25, color: Colors.white),),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20.0,
              ),

              InkWell(
                onTap: trackLocation,
                child: Container(
                  height: 200.0,
                  width: 350.0,
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Column(
                    children: [
                      Container(
                        height : 150,
                        width: 250,
                        child: Image.asset("assets/location.svg.png",color: Colors.white,),
                      ),
                      const Text("Live Track", style: TextStyle(fontSize: 25, color: Colors.white),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


   goto() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  BusList()));
  }

  profile(){
    Navigator.push(context, PageTransition(child:const Profile(), type: PageTransitionType.rightToLeft));
  }
   busSchedule() {

    Navigator.push(context, PageTransition(child: const RoutList(), type: PageTransitionType.rightToLeft));
  }

  void trackLocation() {
    Navigator.push(context, PageTransition(child:const RouteTrack(), type: PageTransitionType.rightToLeft));
  }

}

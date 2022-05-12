import 'package:desktop/add/employee.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../add/chauffeur.dart';
import '../add/route.dart';
import '../add/vehicule.dart';
import '../add/voyage.dart';

class NavBar extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(accountName: const Text("Admin"), accountEmail: const Text("Admin@gmail.com"), decoration: BoxDecoration(
        color: Colors.orange[100],
    )),
          ListTile(
           leading: const Icon(Icons.travel_explore),
           title: const Text('Voyage'),
           onTap:()=>Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Voyage(
                              )),
                        ),
          ), 
          ListTile(
           leading: Icon(Icons.person_add),
           title: Text('Chauffeur'),
           onTap:()=>Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Chauffeur(
                              )),
                        ),
          ) ,
           ListTile(
           leading:const  Icon(Icons.person_add),
           title: const Text('Employee'),
           onTap:()=>Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Employee(
                              )),
                        ),
          ) ,
          ListTile(
           leading: const Icon(Icons.add_location_alt ),
           title: const Text('Route'),
           onTap:()=>Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Route_class(
                              )),
                        ),
          ) ,
          ListTile(
           leading: const Icon(Icons.bus_alert),
           title:const  Text('Vehicule'),
           onTap:()=>Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Vehicule(
                              )),
                        ),
          ) ,
         
         
          const Divider(
            thickness: 1,
          ),
           ListTile(
           leading: const Icon(Icons.settings),
           title: const Text('Settings'),
           onTap:() {},
          ) ,
           ListTile(
           leading:const  Icon(Icons.logout),
           title:const  Text('Logout'),
           onTap:() => FirebaseAuth.instance.signOut(),
          ) ,
        ],
      ),
    );
  }
}
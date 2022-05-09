import 'package:desktop/add/employee.dart';
import 'package:desktop/add/presence.dart';
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
          UserAccountsDrawerHeader(accountName: Text("Admin"), accountEmail: const Text("Admin@gmail.com"), decoration: BoxDecoration(
        color: Colors.orange[100],
    )),
          ListTile(
           leading: Icon(Icons.travel_explore),
           title: Text('Voyage'),
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
           leading: Icon(Icons.person_add),
           title: Text('Employee'),
           onTap:()=>Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Employee(
                              )),
                        ),
          ) ,
          ListTile(
           leading: Icon(Icons.add_location_alt ),
           title: Text('Route'),
           onTap:()=>Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Route_class(
                              )),
                        ),
          ) ,
          ListTile(
           leading: Icon(Icons.bus_alert),
           title: Text('Vehicule'),
           onTap:()=>Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Vehicule(
                              )),
                        ),
          ) ,
         
          Divider(
            thickness: 1,
          ),
           ListTile(
           leading: Icon(Icons.settings),
           title: Text('Settings'),
           onTap:() {},
          ) ,
           ListTile(
           leading: Icon(Icons.logout),
           title: Text('Logout'),
           onTap:() => FirebaseAuth.instance.signOut(),
          ) ,
        ],
      ),
    );
  }
}
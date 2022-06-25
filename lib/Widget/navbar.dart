import '/add/employee.dart';
import 'package:flutter/material.dart';
import '../add/chauffeur.dart';
import '../add/route.dart';
import '../add/vehicule.dart';
class NavBar extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(accountName: const Text("Navigation"), decoration: BoxDecoration(
        color: Color(0xFF1E2F97),
    )),
         
           ListTile(
           leading:const  Icon(Icons.person_add_alt),
           title: const Text('Employee'),
           onTap:()=>Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Employee(
                              )),
                        ),
          ) ,
           ListTile(
           leading: const Icon(Icons.person_add),
           title: const Text('Driver'),
           onTap:()=>Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Chauffeur(
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
           leading: const Icon(Icons.directions_car),
           title:const  Text('Vehicle'),
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
             
        ],
      ),
    );
  }
}
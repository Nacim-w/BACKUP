import 'package:flutter/material.dart';
import '../add/report.dart';
import '../add/voyage.dart';
class NavBar extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(accountName: const Text("Navigation"), decoration: BoxDecoration(
        color: Color(0xFF1E2F97),
    )),
                                          const SizedBox(height: 10),
          ListTile(
           leading: const Icon(Icons.travel_explore),
           title: const Text('Journey'),
           onTap:()=>Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Voyage(
                              )),
                        ),
          ), 
         
         
          
         
        
          ListTile(
           leading: const Icon(Icons.report_problem),
           title:const  Text('Report'),
           onTap:()=>Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Report_class(
                              )),
                        ),
          ) ,

           
        ],
      ),
    );
  }
}
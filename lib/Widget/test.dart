import 'dart:html';
import 'package:desktop/add/presence.dart';
import 'package:flutter/material.dart';
 class HomeScreen extends StatelessWidget {
   @override 
    Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('REST API'),
    ),
  body:FutureBuilder<List>(
    builder: (context, snapshot){

      if(snapshot .connectionState== ConnectionState.waiting){
        return Center(child : CircularProgressIndicator());
      }
      if(snapshot.hasError){
        return Center(child: Text("error"),);
      }
        return ListView.separated(
          itemBuilder: (context , index){
              return Container(
                height: 100.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child:Row(children: [
                  Expanded(flex: 1 ,child: Text('1')),
                  Expanded(flex: 2 ,child: Text('1')),
                  Expanded(flex: 3 , child: Text('1')),
                ]),
              );
          }
          ,separatorBuilder: (context,index)
          {
            return Divider(thickness: 0.5,height: 0.5,);
          },itemCount: snapshot.data.length ?? 0);
    } ,
    
    ),
  );

    }
 }
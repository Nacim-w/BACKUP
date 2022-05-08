import 'dart:convert';

import 'package:desktop/Widget/navbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Presence extends StatefulWidget {

   final String text;
  const Presence({Key key, this.text})
   : super(key:key );

  @override
  _presenceState createState() => _presenceState();

}


class _presenceState extends State<Presence> {


 
  // to define variables ///
Future getAllPresence()async{
    String selectedPresence="'"+widget.text+"'";
var response = await http.get(Uri.parse("http://192.168.1.7/faith/presence.php?test=$selectedPresence"),headers: {"Accept":"application/json"});
var jsonBody = response.body;
var jsonData = json.decode(jsonBody);
setState(() {
  dataPresence=jsonData;

});
print(jsonData);

}
@override
  void initState() {
    super.initState();
    getAllPresence();
  }
  // to define variables ///
    List dataPresence=List();

    // Clean up the controller when the widget is disposed.

  

  @override
  Widget build(BuildContext context) {
    // ui of data page
    return WillPopScope(

      // to call _requestPop function
        child: Scaffold(
          resizeToAvoidBottomInset: false,
            drawer: NavBar(),
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text( "New Data"),
              centerTitle: true,
            ),

            // ui of name textfield, direction textfield and image
            body: SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Column(
                                children: <Widget>[

                 ElevatedButton(
                          child: Text('send form'), onPressed: () {
                      try{
                      getAllPresence();
                      }
                      catch(e)
                      {
                               print("exception: ${e.toString()}");
                      }
                      FocusScope.of(context).unfocus();            },),
                                ]
              ),
            )
            ));
  }

}

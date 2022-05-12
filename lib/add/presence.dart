import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:desktop/Widget/navbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:draggable_fab/draggable_fab.dart';



class Presence extends StatefulWidget {

   final String text;
  const Presence({Key key, this.text})
   : super(key:key );

  @override
  _presenceState createState() => _presenceState();

}


class _presenceState extends State<Presence> {


 
  // to define variables ///
String result="" ;

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
MaterialColor kPrimaryColor = const MaterialColor(
  (0xFFFFE0B2),
  const <int, Color>{
    50: const Color(0xFFFFE0B2),
    100: const Color(0xFFFFE0B2),
    200: const Color(0xFFFFE0B2),
    300: const Color(0xFFFFE0B2),
    400: const Color(0xFFFFE0B2),
    500: const Color(0xFFFFE0B2),
    600: const Color(0xFFFFE0B2),
    700: const Color(0xFFFFE0B2),
    800: const Color(0xFFFFE0B2),
    900: const Color(0xFFFFE0B2),
  },
);
  

  @override
  Widget build(BuildContext context) {
    // ui of data page
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: kPrimaryColor,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        ),

      ),
      home : Scaffold(
          resizeToAvoidBottomInset: false,
            drawer: NavBar(),
            appBar: AppBar(
              actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Show Snackbar',
              onPressed: () {
                      getAllPresence();
            },
          ),
        ],
              title: Text( "Liste De Présence "),
              centerTitle: true,
            ),
           

            floatingActionButton: DraggableFab( 
            child :FloatingActionButton(
              // code to save data
              child: Icon(Icons.nfc),
              backgroundColor: Colors.orange[100],
              onPressed:(){ _tagRead(context);},
            ),
            ),

            // ui of name textfield, direction textfield and image
            body: FutureBuilder<List>(
    builder: (context, snapshot){
        return ListView.separated(
          itemBuilder: (context , index){
              return Container(
                height: 100.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child:Row(children: [
                  Expanded(flex: 5 ,child: Text(dataPresence[index]['tagid'])),
                  Expanded(flex: 2 ,child: Text(dataPresence[index]['matricule'])),
                  Expanded(flex: 2 , child: Row(
                    children:[
                     Container(
                  width:60.0,
                  height:40.0,
                  decoration: BoxDecoration(color: (dataPresence[index]['Presence'] == "Present") ? Colors.green : Colors.red[400],
                   borderRadius: BorderRadius.circular(10.0),
                   ),
                   child: Center(child: Text(dataPresence[index]['Presence']),
                ),
                     ),
                ]
                  ),
                  ),
                ]
                ),
              );
          }
          ,separatorBuilder: (context,index)
          {
            return Divider(thickness: 0.5,height: 0.5,);
          },itemCount: dataPresence.length);
    } ,
    
    ),
            
            
            
            
            
            
            
            
           
              ),
            );
        
  }

void _tagRead(context) {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result="";

      final Isodep = IsoDep.from(tag);
      if (Isodep == null) {
        print('Tag is not compatible with Isodep.');
        return;
      }
      result = Isodep.identifier.toString();
      result="'"+result+"'";
      NfcManager.instance.stopSession();
            
              Flushbar(
                  message:  'TAG Identifier',
                  duration:  Duration(seconds: 2),
                  messageColor:Colors.white,
                  backgroundColor:Colors.green
                ).show(context);
            try{
          
	  var response = await http.put(Uri.parse("http://192.168.1.7/faith/updateemployee.php?test=$result"),headers: {"Accept":"application/json"});
     getAllPresence();
    print(result);
	var jsonBody = response.body;
var jsonData = json.decode(jsonBody);
setState(() {
  dataPresence=jsonData;

});
print(jsonData);
  }
  catch (e) {

       print("exception: ${e.toString()}");
  }
    });
  }




}

import 'dart:async';
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:desktop/Widget/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:draggable_fab/draggable_fab.dart';



class Presence extends StatefulWidget {

   final String text;
   
    final value;
  const Presence({Key key,  this.text , this.value})
   : super(key:key );

  @override
  _presenceState createState() => _presenceState();

}


class _presenceState extends State<Presence> {


 
  // to define variables ///
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
      @override

String result="" ;

Future getAllPresence()async{
    String selectedPresence="'"+widget.text+"'";
var response = await http.get(Uri.parse("http://172.16.48.37/faith/presence.php?test=$selectedPresence"),headers: {"Accept":"application/json"});
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
    List dataPresence=[];

    // Clean up the controller when the widget is disposed.
MaterialColor kPrimaryColor = const MaterialColor(
  (0xFF1E2F97),
  const <int, Color>{
    50: const Color(0xFF1E2F97),
    100: const Color(0xFF1E2F97),
    200: const Color(0xFF1E2F97),
    300: const Color(0xFF1E2F97),
    400: const Color(0xFF1E2F97),
    500: const Color(0xFF1E2F97),
    600: const Color(0xFF1E2F97),
    700: const Color(0xFF1E2F97),
    800: const Color(0xFF1E2F97),
    900: const Color(0xFF1E2F97),
  },
);
  

  @override
  Widget build(BuildContext context) {
    // ui of data page
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: kPrimaryColor,
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        ),

      ),
      home : Scaffold(
          resizeToAvoidBottomInset: false,
            drawer: NavBar(),
            appBar: AppBar(
              actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_location_rounded),
              tooltip: 'Show Snackbar',
              onPressed: () {
                      getCurrentLocation();
            },
          ),
        ],
              title: const Text( "Presence"),
              centerTitle: true,
            ),
           

            floatingActionButton: DraggableFab( 
            child :FloatingActionButton(
              // code to save data
              child: const Icon(Icons.nfc),
              backgroundColor: kPrimaryColor,
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child:Row(children: [
                  Expanded(flex: 5 ,child: Text(dataPresence[index]['name'])),
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
            return const Divider(thickness: 0.5,height: 0.5,);
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
                  duration:  const Duration(seconds: 2),
                  messageColor:Colors.white,
                  backgroundColor:Colors.green
                ).show(context);
            try{
          
	  var response = await http.put(Uri.parse("http://172.16.48.37/faith/updateemployee.php?test=$result"),headers: {"Accept":"application/json"});
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

Future getCurrentLocation() async {
    try {

      var location = await _locationTracker.getLocation();
            if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }
      String car=(widget.value);
      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) async {
      
              
          final response =  await http.post
    (Uri.parse("http://172.16.48.37/faith/location.php"),
     body: {
      "id":   1.toString(),
      "latitude": newLocalData.latitude.toString(),
      "longitude": newLocalData.longitude.toString(),
      "vehicule": car,

	     });     
       print(response.body);   
      
      
      }
      );

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
 }



}

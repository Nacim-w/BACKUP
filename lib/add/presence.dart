import 'dart:convert';

import 'package:desktop/Widget/navbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';


class Presence extends StatefulWidget {

   final String text;
  const Presence({Key key, this.text})
   : super(key:key );

  @override
  _presenceState createState() => _presenceState();

}


class _presenceState extends State<Presence> {


 
  // to define variables ///
ValueNotifier<dynamic> result = ValueNotifier(null);

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
              actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Show Snackbar',
              onPressed: () {
                      getAllPresence();
            },
          ),
        ],
              
              backgroundColor: Colors.blue,
              title: Text( "New Data"),
              centerTitle: true,
            ),

            // ui of name textfield, direction textfield and image
            body: ListView.builder(
              itemCount: dataPresence.length,
              itemBuilder: (context,index){
                return 
                ListTile(
                leading: Text(dataPresence[index]['tagid']),
                title:Text(dataPresence[index]['matricule']),
                trailing: Text(  dataPresence[index]['Presence']),
                );
            }
            ),


                 /* ElevatedButton(
                          child: Text('send form'), onPressed: () {
                      try{
                      getAllPresence();
                      }
                      catch(e)
                      {
                               print("exception: ${e.toString()}");
                      }
                      FocusScope.of(context).unfocus();            },),
                               */
              ),
            );
        
  }

void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {

      final Isodep = IsoDep.from(tag);
      if (Isodep == null) {
        print('Tag is not compatible with Isodep.');
        return;
      }
      result.value = Isodep.identifier.toString();
      NfcManager.instance.stopSession();

            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(duration: const Duration(seconds: 1) ,content: Text('Tag scanned ')));
            try{
          
	  final response = await http.post
    (Uri.parse("http://192.168.1.7/faith/insertemployee.php"),
     body: {
      "id":   1.toString(),
	     });
       print(response.body);
	}
  catch (e) {

       print("exception: ${e.toString()}");
  }
          
    });
  }




}

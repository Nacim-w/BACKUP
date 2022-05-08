import 'dart:convert';
import 'package:desktop/Widget/navbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';


class Employee extends StatefulWidget {
  @override
  _employeeState createState() => _employeeState();
}

class _employeeState extends State<Employee> {
  

  Future getAllRoute()async{
var response = await http.get(Uri.parse("http://192.168.1.7/faith/viewallroute.php"),headers: {"Accept":"application/json"});
var jsonBody = response.body;
var jsonData = json.decode(jsonBody);
setState(() {
  dataRoute=jsonData;

});
print(jsonData);
}

  // to define variables ///
    ValueNotifier<dynamic> result = ValueNotifier(null);
  final _matriculeController = TextEditingController();
List dataRoute=List();
String selectedRoute;
@override
  void initState() {
    super.initState();
    getAllRoute();
  }


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _matriculeController.dispose();

    super.dispose();
  }

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
              actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Show Snackbar',
            onPressed: () {
              getAllRoute();
            },
          ),
        ],
            ),

            // ui of name textfield, direction textfield and image
            body: SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  

                  // ui of name textfield
                  TextField(
                    controller: _matriculeController,
                    decoration: InputDecoration(labelText: "Matricule"),
                    onChanged: (text) {
                      setState(() {
                      });
                    },
                  ),
                 DropdownButton(value: selectedRoute,
                isExpanded: true, //make true to take width of parent widget
                 underline: Container(),
                  hint : Text('select Route'),
                  items: dataRoute.map((list){
                    return DropdownMenuItem<String>(
                      child: Text(list['route']),
                      value: list['route'].toString(),                    
                      );
                  },).toList(),
                  onChanged: (value){
                    setState(() {
                      selectedRoute= value;
                    });
                  },
                  ),
                  ElevatedButton(
                          child: Text('send form'), onPressed: () {
                      _tagRead();
                     
                      FocusScope.of(context).unfocus();            },), 
                ],
              ),
            )));
  }


 Future<List> vehicles() async {
   

}
void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
            if(_matriculeController.text!="" && selectedRoute!=null  ){
      final Isodep = IsoDep.from(tag);
      if (Isodep == null) {
        print('Tag is not compatible with Isodep.');
        return;
      }
      result.value = Isodep.identifier.toString();
      NfcManager.instance.stopSession();

            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(duration: const Duration(seconds: 1) ,content: Text('voyage Ajouter')));
            try{
          
	  final response = await http.post
    (Uri.parse("http://192.168.1.7/faith/insertemployee.php"),
     body: {
      "id":   1.toString(),
      "matricule": _matriculeController.text,
      "tagid":result.value,
      "route":selectedRoute,

	     });
       print(response.body);
	}
  catch (e) {

       print("exception: ${e.toString()}");
  }
          }
          else{
        ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(duration: const Duration(seconds: 2) ,content: Text('Please fill up the empty field')));
      FocusScope.of(context).unfocus();
      }            
     

    });
  }

}

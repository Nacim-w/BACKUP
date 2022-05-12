import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
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
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _matriculeController.dispose();

    super.dispose();
  }

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

      // to call _requestPop function
        home: Scaffold(
          resizeToAvoidBottomInset: false,
            drawer: NavBar(),
            appBar: AppBar(
              title: Text( "Employee"),
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
                  
                          SizedBox(height: 30),

                  // ui of name textfield
                  TextField(
                    controller: _matriculeController,
                    decoration: InputDecoration(labelText: "Donnez Matricule"),
                    onChanged: (text) {
                      setState(() {
                      });
                    },
                  ),
                      SizedBox(height: 50),

                 DropdownButton(value: selectedRoute,
                isExpanded: true, //make true to take width of parent widget
                 underline: Container(),
                 isDense: true,
                  hint : Text('Select Route'),
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
                                        SizedBox(height: 30),

                  ElevatedButton(
                          child: Text('Ajouter'), onPressed: () {
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

           Flushbar(
                  message:  'Employee Ajouter',
                  duration:  const Duration(seconds: 2),
                  messageColor:Colors.white,
                  backgroundColor:Colors.green                  
                ).show(context);
                      FocusScope.of(context).unfocus();
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
            Flushbar(
                  message:  'Please fill up the empty field',
                  duration:  Duration(seconds: 2),
                  messageColor:Colors.white,
                  backgroundColor:Colors.red                 
                ).show(context);
                      FocusScope.of(context).unfocus();
        
      }            
     

    });
  }

}

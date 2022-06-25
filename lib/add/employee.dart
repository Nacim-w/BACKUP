import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import '../Widget/navbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
var response = await http.get(Uri.parse("http://172.16.48.37/faith/viewallroute.php"),headers: {"Accept":"application/json"});
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
  final _nameController = TextEditingController();
    final _cinController = TextEditingController();


List dataRoute=[];
String selectedRoute;
@override
  void initState() {
    super.initState();
    getAllRoute();
  }
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
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _matriculeController.dispose();
    _nameController.dispose();
    _cinController.dispose();

    super.dispose();
  }

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

      // to call _requestPop function
        home: Scaffold(
          resizeToAvoidBottomInset: false,
            drawer: NavBar(),
            appBar: AppBar(
              title: const Text( "Employee"),
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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  
                          const SizedBox(height: 30),

                  // ui of name textfield
                 TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText:"Full Name" ,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                hintStyle: const TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
                    onChanged: (text) {
                      setState(() {
                      });
                    },
                  ),            
                  const SizedBox(height: 30),
                       
                  TextField(
                    controller: _matriculeController,
                    decoration: InputDecoration(
                      labelText:"Serial Number" ,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                hintStyle: const TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
                    onChanged: (text) {
                      setState(() {
                      });
                    },
                  ),

              const SizedBox(height: 30),
                       
                  TextField(
                    controller: _cinController,
                    decoration: InputDecoration(
                      labelText:"CIN" ,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                hintStyle: const TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
                    onChanged: (text) {
                      setState(() {
                      });
                    },
                  ),    

                  const SizedBox(height: 30),

                 DropdownButton2(value: selectedRoute,
                isExpanded: true, //make true to take width of parent widget
                 underline: Container(),
                 isDense: true,
                  hint : const Text('Select Route'),
                  items: dataRoute.map((list){
                    return DropdownMenuItem<String>(
                      child: Text(list['route']),
                      value: list['id'].toString(),                    
                      );
                  },).toList(),
                   buttonHeight: 65,
          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
          ),
                  onChanged: (value){
                    setState(() {
                       selectedRoute= value ;

                    });
                  },
                   dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
                  ),
                                        const SizedBox(height: 30),

                  ElevatedButton(
                    style: ButtonStyle(
                       minimumSize: MaterialStateProperty.all(Size(125, 50)),

              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0),
                )
              )
            ),
                          child: const Text('Submit'), onPressed: () {
                      _tagRead();
                     
                      FocusScope.of(context).unfocus();            },), 
                ],
              ),
            )));
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
                  message:  'Employee Submitted',
                  duration:  const Duration(seconds: 2),
                  messageColor:Colors.white,
                  backgroundColor:Colors.green                  
                ).show(context);
                      FocusScope.of(context).unfocus();
            try{
	  final response = await http.post
    (Uri.parse("http://172.16.48.37/faith/insertemployee.php"),
     body: {
      "id":   1.toString(),
      "name":_nameController.text,
      "route_id":selectedRoute,
      "matricule": _matriculeController.text,
      "tagid":result.value,
      "cin":_cinController.text,

	     });
       print(response.body);
	}
  catch (e) {

       print("exception: ${e.toString()}");
  }
          }
          else{
            Flushbar(
                  message:  'Not Submitted',
                  duration:  const Duration(seconds: 2),
                  messageColor:Colors.white,
                  backgroundColor:Colors.red                 
                ).show(context);
                      FocusScope.of(context).unfocus();
        
      }            
     

    });
  }

}

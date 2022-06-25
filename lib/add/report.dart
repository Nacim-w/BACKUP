import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:desktop/Widget/navbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Report_class extends StatefulWidget {
  @override
  _reportState createState() => _reportState();
}

class _reportState extends State<Report_class> {
  // to define variables ///
  final _textController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _textController.dispose();
    super.dispose();
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
    List dataVehicule=[];

Future getAllVehicule()async{
var response = await http.get(Uri.parse("http://172.16.48.37/faith/viewallvehicule.php"),headers: {"Accept":"application/json"});
var jsonBody = response.body;
var jsonData = json.decode(jsonBody);
setState(() {
  dataVehicule=jsonData;

});
print(jsonData);
}
  // to define variables ///

String selectedVehicule;
@override
  void initState() {
    super.initState();
    getAllVehicule();
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
              title: const Text( "Report"),
              centerTitle: true,
            ),

            // ui of report textfield, report textfield and image
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  
                          const SizedBox(height: 30),

                  // ui of report textfield
                  TextField(
                      keyboardType: TextInputType.multiline,
                          maxLines: null,
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText:"Report" ,
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

                 DropdownButton2(value: selectedVehicule,
                isExpanded: true, //make true to take width of parent widget
                 underline: Container(),
                 isDense: true,
                  hint : const Text('Select Vehicle'),
                  items: dataVehicule.map((list){
                    return DropdownMenuItem<String>(
                      child: Text(list['type']),
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
                       selectedVehicule= value ;

                    });
                  },
                   dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
                  ),

                  // ui of report textfield
               
                                      const SizedBox(height: 50),

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
                      if(_textController.text!=""){
                      reports();
                       Flushbar(
                  message:  "Reported",
                  duration:  const Duration(seconds: 1),
                  messageColor:Colors.white,
                  backgroundColor:Colors.green
                ).show(context);
                      FocusScope.of(context).unfocus();            
                      }
                      else{
                       Flushbar(
                  message:  'Please fill up the empty field',
                  duration:  const Duration(seconds: 2),
                  messageColor:Colors.white,
                  backgroundColor:Colors.red,
                  
                ).show(context);
                      FocusScope.of(context).unfocus();
                      }


                      },
                      ),
                ],
              ),
            )));
  }


 Future<List> reports() async {
    try{
          
	  final response = await http.post
    (Uri.parse("http://172.16.48.37/faith/insertreport.php"),
     body: {
      "id":   1.toString(),
      "report": _textController.text,
      "vehicule_id":selectedVehicule,
	     });
       print(response.body);
	}
  catch (e) {

       print("exception: ${e.toString()}");
  }
}
}

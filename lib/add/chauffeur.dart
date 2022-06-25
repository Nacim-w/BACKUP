import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Widget/navbar.dart';


class Chauffeur extends StatefulWidget {
  @override
  _chauffeurState createState() => _chauffeurState();
}

class _chauffeurState extends State<Chauffeur> {
  // to define variables ///
  final _codeController = TextEditingController();
  final _cinController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _codeController.dispose();
    _cinController.dispose();
    _lastnameController.dispose();
    _addressController.dispose();
    _firstnameController.dispose();
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
              title: const Text( "Driver"),
              centerTitle: true,
            ),

            // ui of name textfield, direction textfield and image
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  
                    const SizedBox(height: 30),

                  // ui of first name textfield
                 

                TextFormField(
                    controller: _firstnameController,
                    decoration: InputDecoration(
                      labelText:"First Name" ,
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
                    },
                  ),

                      const SizedBox(height: 30),

                      TextField(
                    controller: _lastnameController,
                    decoration: InputDecoration(
                      labelText:"Last Name" ,
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
                    },
                  )
                  
                  ,const SizedBox(height: 30),

                  // ui of cin textfield
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
                    },
                  ),
                  const SizedBox(height: 30),

                  // ui of Code textfield
                   TextField(
                    controller: _codeController,
                    decoration: InputDecoration(
                      labelText:"Code" ,
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



                  // ui of address textfield
                  TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText:"Address" ,
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
                    },
                  ),
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
                          child: const Text('Submit'),
                          onPressed: () {
                         if(_codeController.text!=""
                         && _cinController.text!=""
                         &&_firstnameController.text!=""
                         &&_lastnameController.text!=""
                         && _addressController.text!=""){
                      chauffeurs();
                      Flushbar(
                  message:  'Driver Submitted',
                  duration:  const Duration(seconds: 1),
                  messageColor:Colors.white,
                  backgroundColor:Colors.green                  
                ).show(context);
                         }
                         else{
                         Flushbar(
                  message:  'Please fill up the empty field',
                  duration:  const Duration(seconds: 2),
                  messageColor:Colors.white,
                  backgroundColor:Colors.red                 
                ).show(context);
                      }
                      FocusScope.of(context).unfocus();            },
                           ),
                ],
              ),
            )));
  }


 Future<List> chauffeurs() async {
    try{
          
	  final response = await http.post
    (Uri.parse("http://172.16.48.37/faith/insertchauffeur.php"),
     body: {
      "id":   1.toString(),
      "code": _codeController.text,
      "cin": _cinController.text,
      "first_name": _firstnameController.text,
      "last_name": _lastnameController.text,
      "address": _addressController.text,
	     });
       print(response.body);
	}
  catch (e) {

       print("exception: ${e.toString()}");
         }
}

}



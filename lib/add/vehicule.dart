import 'package:another_flushbar/flushbar.dart';
import 'package:desktop/Widget/navbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Vehicule extends StatefulWidget {
  @override
  _vehiculeState createState() => _vehiculeState();
}

class _vehiculeState extends State<Vehicule> {

  // to define variables ///
  final _nameController = TextEditingController();
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
    _nameController.dispose();
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
              title: Text( "Vehicule"),
              centerTitle: true,
            ),
            // ui of name textfield, direction textfield and image
            body: SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  
                      SizedBox(height: 30),

                  // ui of name textfield
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: "Donnez Nom"),
                    onChanged: (text) {
                      setState(() {
                      });
                    },
                  ),
                  
                  
                  // ui of direction textfield
               
                          SizedBox(height: 50),

                    ElevatedButton(
                          child: Text('Ajouter'), onPressed: () {
                      if(_nameController.text!=""){
                      vehicules();
                      Flushbar(
                  message:  'Vehicule Ajouter',
                  duration:  Duration(seconds: 1),
                   messageColor:Colors.white,
                  backgroundColor:Colors.green                 
                ).show(context);
                      FocusScope.of(context).unfocus();   }
                      else{
                         Flushbar(
                  message:  'Please fill up the empty field',
                  duration:  Duration(seconds: 2),
                  messageColor:Colors.white,
                  backgroundColor:Colors.red                  
                ).show(context);
                      FocusScope.of(context).unfocus();
                      }
                               },
                               ), 
                ],
              ),
            )));
  }


 Future<List> vehicules() async {
    try{
          
	  final response = await http.post
    (Uri.parse("http://192.168.1.7/faith/insertvehicule.php"),
     body: {
      "id":   1.toString(),
      "name": _nameController.text,
	     });
       print(response.body);
	}
  catch (e) {

       print("exception: ${e.toString()}");
  }

}

}

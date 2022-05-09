import 'package:another_flushbar/flushbar.dart';
import 'package:desktop/Widget/navbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Route_class extends StatefulWidget {
  @override
  _routeState createState() => _routeState();
}

class _routeState extends State<Route_class> {
  // to define variables ///
  final _routeController = TextEditingController();
 
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _routeController.dispose();
    super.dispose();
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
              title: Text( "Route"),
              centerTitle: true,
            ),

            // ui of route textfield, route textfield and image
            body: SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  
                          SizedBox(height: 30),

                  // ui of route textfield
                  TextField(
                    controller: _routeController,
                    decoration: InputDecoration(labelText: "Donnez Route"),
                    onChanged: (text) {
                      setState(() {
                      });
                    },
                  ),

                  // ui of route textfield
               
                                      SizedBox(height: 50),

                   ElevatedButton(
                          child: Text('Ajouter'), onPressed: () {
                      if(_routeController.text!=""){
                      routes();
                       Flushbar(
                  message:  "Route Ajouter",
                  duration:  Duration(seconds: 1),
                ).show(context);
                      FocusScope.of(context).unfocus();            
                      }
                      else{
                       Flushbar(
                  message:  'Please fill up the empty field',
                  duration:  Duration(seconds: 2),
                ).show(context);
                      FocusScope.of(context).unfocus();
                      }


                      },
                      ),
                ],
              ),
            )));
  }


 Future<List> routes() async {
    try{
          
	  final response = await http.post
    (Uri.parse("http://192.168.1.7/faith/insertroute.php"),
     body: {
      "id":   1.toString(),
      "route": _routeController.text,
	     });
       print(response.body);
	}
  catch (e) {

       print("exception: ${e.toString()}");
  }

}
}

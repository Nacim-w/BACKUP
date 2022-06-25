import 'package:another_flushbar/flushbar.dart';
import '../Widget/navbar.dart';
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
              title: const Text( "Route"),
              centerTitle: true,
            ),

            // ui of route textfield, route textfield and image
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  
                          const SizedBox(height: 30),

                  // ui of route textfield
                  TextField(
                    controller: _routeController,
                    decoration: InputDecoration(
                      labelText:"Route" ,
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

                  // ui of route textfield
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
                      if(_routeController.text!=""){
                      routes();
                       Flushbar(
                  message:  "Route  Submitted",
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


 Future<List> routes() async {
    try{
          
	  final response = await http.post
    (Uri.parse("http://172.16.48.37/faith/insertroute.php"),
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

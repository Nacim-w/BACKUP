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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ui of data page
    return WillPopScope(

      // to call _requestPop function
        child: Scaffold(
          resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text( "New Data"),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              // code to save data
              child: Icon(Icons.save),
              backgroundColor: Colors.blue,
            ),

            // ui of route textfield, route textfield and image
            body: SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  

                  // ui of route textfield
                  TextField(
                    controller: _routeController,
                    decoration: InputDecoration(labelText: "route"),
                    onChanged: (text) {
                      setState(() {
                      });
                    },
                  ),

                  // ui of route textfield
               
            
                   ElevatedButton(
                          child: Text('send form'), onPressed: () {
                      routes();
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(duration: const Duration(seconds: 1) ,content: Text('Route Ajouter')));
                      FocusScope.of(context).unfocus();            },),
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

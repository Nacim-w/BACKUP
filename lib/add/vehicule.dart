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

 
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
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
            ),
            floatingActionButton: FloatingActionButton(
              // code to save data
              child: Icon(Icons.save),
              backgroundColor: Colors.blue,
            ),

            // ui of name textfield, direction textfield and image
            body: SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  

                  // ui of name textfield
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: "name"),
                    onChanged: (text) {
                      setState(() {
                      });
                    },
                  ),
                  
                  
                  // ui of direction textfield
               

                    ElevatedButton(
                          child: Text('send form'), onPressed: () {
                      if(_nameController.text!=""){
                      vehicules();
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(duration: const Duration(seconds: 1) ,content: Text('Vehicule Ajouter')));
                      FocusScope.of(context).unfocus();   }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(duration: const Duration(seconds: 2) ,content: Text('Please fill up the empty field')));
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
      "name": _nameController,
	     });
       print(response.body);
	}
  catch (e) {

       print("exception: ${e.toString()}");
  }

}

}

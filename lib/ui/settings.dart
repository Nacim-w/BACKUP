import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  // to define variables ///
  final _nameController = TextEditingController();
  final _cincontroller = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _cincontroller.dispose();

    super.dispose();
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
                  TextField(
                    controller: _cincontroller,
                    decoration: InputDecoration(labelText: "Cin"),
                    onChanged: (text) {
                    },
                  ),
                   ElevatedButton(
                          child: Text('send form'),
                          onPressed: () {
                      tests();
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(duration: const Duration(seconds: 1) ,content: Text('test Ajouter')));
                      FocusScope.of(context).unfocus();            },
                           ),
                ],
              ),
            )));
  }


 Future<List> tests() async {
    try{
          
	  final response = await http.post
    (Uri.parse("http://192.168.1.7/faith/inserttest.php"),
     body: {
      "id":   1.toString(),
      "name": _nameController.text,
      "cin": _nameController.text,
	     });
       print(response.body);
	}
  catch (e) {

       print("exception: ${e.toString()}");
  }

}

}

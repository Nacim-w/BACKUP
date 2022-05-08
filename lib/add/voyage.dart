import 'dart:convert';
import 'package:desktop/add/presence.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Widget/navbar.dart';


class Voyage extends StatefulWidget {
  @override
  voyageState createState() => voyageState();
}

class voyageState extends State<Voyage> {
  Future getAllChauffeur()async{
var response = await http.get(Uri.parse("http://192.168.1.7/faith/viewallchauffeur.php"),headers: {"Accept":"application/json"});
var jsonBody = response.body;
var jsonData = json.decode(jsonBody);
setState(() {
  dataChauffeur=jsonData;

});
print(jsonData);
}

Future getAllRoute()async{
var response = await http.get(Uri.parse("http://192.168.1.7/faith/viewallroute.php"),headers: {"Accept":"application/json"});
var jsonBody = response.body;
var jsonData = json.decode(jsonBody);
setState(() {
  dataRoute=jsonData;

});
print(jsonData);
}Future getAllVehicule()async{
var response = await http.get(Uri.parse("http://192.168.1.7/faith/viewallvehicule.php"),headers: {"Accept":"application/json"});
var jsonBody = response.body;
var jsonData = json.decode(jsonBody);
setState(() {
  dataVehicule=jsonData;

});
print(jsonData);
}
  // to define variables ///
    List dataChauffeur=List();
    List dataRoute=List();
    List dataVehicule=List();

  String selectedChauffeur;
  String selectedRoute;
  String selectedVehicule;


  @override
  void initState() {
    super.initState();
    getAllChauffeur();
    getAllVehicule();
    getAllRoute();
  }

  @override
  Widget build(BuildContext context) {
    // ui of data page
    return WillPopScope(


      // to call _requestPop function
        child: Scaffold(
          drawer: NavBar(),
          resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text( "New Data"),
              centerTitle: true,
            ),
            /*floatingActionButton: FloatingActionButton(
              // code to save data
              child: Icon(Icons.save),
              backgroundColor: Colors.blue,
            ),*/

            // ui of vehicule textfield, route textfield and chauffeur
            body: SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  // ui of chauffeur textfield
                DropdownButton(value: selectedChauffeur,
                isExpanded: true, //make true to take width of parent widget
                 underline: Container(),
                  hint : Text('select Chauffeur'),
                  items: dataChauffeur.map((list){
                    return DropdownMenuItem<String>(
                      child: Text(list['name']),
                      value: list['name'].toString(),                    
                      );
                  },).toList(),
                  onChanged: (value){
                    setState(() {
                      selectedChauffeur= value;
                    });
                  },
                  ),
                  // ui of vehicule textfield
               DropdownButton(value: selectedVehicule,
                  hint : Text('select Vehicule'),
                  isExpanded: true, //make true to take width of parent widget
                  underline: Container(),
                  items: dataVehicule.map((list){
                    return DropdownMenuItem<String>(
                      child: Text(list['name']),
                      value: list['name'].toString(),                    
                      );
                  },).toList(),
                  onChanged: (value){
                    setState(() {
                      selectedVehicule= value;
                    });
                  },
                  ),

                  // ui of route textfield
                  DropdownButton(value: selectedRoute,
                  isExpanded: true, //make true to take width of parent widget
                  underline: Container(),
                  hint : Text('select route'),
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
                
                  
                   ElevatedButton(
                          child: Text('send form'), onPressed:() {
                      
                       if(selectedChauffeur!=null && selectedRoute!=null && selectedVehicule!=null ){
                         voyages();
                            ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(duration: const Duration(seconds: 1) ,content: Text('voyage Ajouter')));

                         Navigator.push(
                           
                          context,
                          MaterialPageRoute(

                              builder: (context) => Presence(text: selectedRoute)
                              ),
                        );                        
                          }
                          else{
                        ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(duration: const Duration(seconds: 2) ,content: Text('Please fill up the empty field')));
                      FocusScope.of(context).unfocus();
                      }            
                      
                      
                      
                            },),
                ],
              ),
            )));
  }


 Future<List> voyages() async {
    try{
          
	  final response = await http.post
    (Uri.parse("http://192.168.1.7/faith/insertvoyage.php"),
     body: {
      "id":   1.toString(),
      "vehicule": selectedVehicule,
      "chauffeur": selectedChauffeur,
	    "route": selectedRoute,
	     });
       print(response.body);
	}
  catch (e) {

       print("exception: ${e.toString()}");
  }

}
}

import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:desktop/add/presence.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import '../Widget/navbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


class Voyage extends StatefulWidget {
  @override
  voyageState createState() => voyageState();
}

class voyageState extends State<Voyage> {
  Future getAllChauffeur()async{
var response = await http.get(Uri.parse("http://192.168.1.4/faith/viewallchauffeur.php"),headers: {"Accept":"application/json"});
var jsonBody = response.body;
var jsonData = json.decode(jsonBody);
setState(() {
  dataChauffeur=jsonData;

});
//print(jsonData);
}

Future getAllRoute()async{
var response = await http.get(Uri.parse("http://192.168.1.4/faith/viewallroute.php"),headers: {"Accept":"application/json"});
var jsonBody = response.body;
var jsonData = json.decode(jsonBody);
setState(() {
  dataRoute=jsonData;

});
//print(jsonData);
}Future getAllVehicule()async{
var response = await http.get(Uri.parse("http://192.168.1.4/faith/viewallvehicule.php"),headers: {"Accept":"application/json"});
var jsonBody = response.body;
var jsonData = json.decode(jsonBody);
setState(() {
  dataVehicule=jsonData;

});
//print(jsonData);
}


  // to define variables //
    List dataChauffeur=[];
    List dataRoute=[];
    List dataVehicule=[];

   String selectedChauffeur;
   String selectedRoute;
   String selectedVehicule;
   String selectedLocation;


  @override
  void initState() {
    super.initState();
    getAllChauffeur();
    getAllVehicule();
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
          drawer: NavBar(),
          resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text( "Voyage"),
              centerTitle: true,
            ),
            /*floatingActionButton: FloatingActionButton(
              // code to save data
              child: Icon(Icons.save),
              backgroundColor: Colors.blue,
            ),*/

            // ui of vehicule textfield, route textfield and chauffeur
            body: Center(
              child: Column(
                children: <Widget>[
                  // ui of chauffeur textfield
                 const SizedBox(height: 50),
                DropdownButton2(value: selectedChauffeur,
                isExpanded: true, //make true to take width of parent widget
                isDense: true,
                 underline: Container(),
                  hint : Row(
            children: const [
              Icon(
                Icons.person,
                size: 25,
                color:Colors.black45,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  '  Select Chaffeur',
                ),
              ),
            ],
          ),
                  items: dataChauffeur.map((list){
                    return DropdownMenuItem<String>(
                      child: Text(list['name']),
                      value: list['name'].toString(),                    
                      );
                  },).toList(), buttonHeight: 50,
                   buttonWidth: 350,
          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
          ),
                  onChanged: (value){
                    setState(() {
                      selectedChauffeur= value ;
                    });
                  },
                  ),
                  // ui of vehicule textfield
                  const SizedBox(height: 50),
               DropdownButton2(value: selectedVehicule,
                  isDense: true,
                  hint : Row(
            children: const [
              Icon(
                Icons.directions_car,
                size: 25,
                color:Colors.black45,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  '  Select Vehicule',
                ),
              ),
            ],
          ),
                  isExpanded: true, //make true to take width of parent widget
                  underline: Container(),
                  items: dataVehicule.map((list){
                    return DropdownMenuItem<String>(
                      child: Text(list['type']),
                      value: list['type'].toString(),                    
                      );
                  },).toList(), buttonHeight: 50,
                   buttonWidth: 350,
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
                  ),
                  const SizedBox(height: 50),
                  // ui of route textfield
                  DropdownButton2(value: selectedRoute,
                  isDense: true,
                  isExpanded: true, //make true to take width of parent widget
                  underline: Container(),
                  hint : Row(
            children: const [
              Icon(
                Icons.location_on,
                size: 25,
                color:Colors.black45,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  '  Select Route',
                ),
              ),
            ],
          ),
                  items: dataRoute.map((list){
                    return DropdownMenuItem<String>(
                      child: Text(list['route']),
                      value: list['id'].toString(),                    
                      );
                  },).toList(),
                   buttonHeight: 50,
                   buttonWidth: 350,
          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
          ),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
                  onChanged: (value){
                    setState(() {
                      selectedRoute= value ;
                    });
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
                          child: const Text('Start'), onPressed:() {
                      
                       if(selectedChauffeur!=null && selectedRoute!=null && selectedVehicule!=null ){
                         voyages();
                             Flushbar(
                  message:  'Voyage Ajouter',
                  duration:  const Duration(seconds: 1),
                ).show(context);

                         Navigator.push(
                           
                          context,
                          MaterialPageRoute(

                              builder: (context) => Presence(text: selectedRoute)
                              ),
                        );                        
                          }
                          else{
                        ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(duration: Duration(seconds: 2) ,content: Text('Please fill up the empty field')));
                      }            
                      
                      

                            },),
                            
                ],
              ),
            )));

            
  }


 Future<List> voyages() async {
    try{
          
	  final response = await http.post
    (Uri.parse("http://192.168.1.4/faith/insertvoyage.php"),
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

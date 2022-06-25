import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'Widget/navbar.dart';



class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/car.png");
    return byteData.buffer.asUint8List();
  }


  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) async{
    final response = await http.post
    (Uri.parse("http://172.16.48.37/faith/location.php"),
     body: {
      "id":   1.toString(),
      "latitude": newLocalData.latitude.toString(),
      "longitude": newLocalData.longitude.toString(),

	     });
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getCurrentLocation() async {
    try {

      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }
      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(newLocalData.latitude, newLocalData.longitude),
              tilt: 0,
              zoom: 18.00)));
          updateMarkerAndCircle(newLocalData, imageData);
        }
      }
      
      );

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
 }

  @override
  void dispose() {
      _locationSubscription?.cancel();
    _controller.dispose();
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
    return MaterialApp(
       debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: kPrimaryColor,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        ),

      ),

    home: Scaffold(
                  drawer: NavBar(),
      appBar: AppBar(
              title: const Text( "Map"),),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initialLocation,
        markers: Set.of((marker != null) ? [marker] : []),
        circles: Set.of((circle != null) ? [circle] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },

      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching),
          onPressed: () {
            getCurrentLocation();
          }),
    ),);
  }

}

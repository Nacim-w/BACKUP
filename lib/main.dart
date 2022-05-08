import 'package:desktop/Widget/login_widget.dart';
import 'package:desktop/add/voyage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MainPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>Scaffold(
    body : StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Voyage();
        } else {
          return LoginWidget();
        }
      }
    ),
  );

}

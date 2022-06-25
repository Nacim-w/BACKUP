import 'dart:convert';
import 'package:admin_panel/add/employee.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../components/background.dart';

class LoginWidget extends StatefulWidget{
  @override
  _LoginWidgetState  createState() => _LoginWidgetState();
}
class _LoginWidgetState extends State<LoginWidget>{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
@override
  void dispose() {
  emailController.dispose();
  passwordController.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "LEONI",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2661FA),
                  fontSize: 36
                ),
                textAlign: TextAlign.left,
              ),
            ),

            SizedBox(height: size.height * 0.03),

            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email"
                ),
              ),
            ),

            SizedBox(height: size.height * 0.03),

            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child:  TextField(
                controller: passwordController,
                decoration:  InputDecoration(
                  labelText: "Password"
                ),
                obscureText: true,
              ),
            ),

            
            SizedBox(height: size.height * 0.05),

            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: login,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding:  EdgeInsets.all(0),
                child: Container(
                  
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient:   LinearGradient(
                      colors: [
                        Color.fromARGB(255, 5, 155, 255),
                        Color.fromARGB(255, 41, 98, 255)
                      ]
                    )
                  ),
                  padding:  EdgeInsets.all(0),
                  child:  Text(
                    "LOGIN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),

           
          ],
        ),
      ),
    );
  }



Future login() async {
    var response = await http.post(Uri.parse("http://172.16.48.37/faith/login.php"),
     body: {
      "email": emailController.text,
      "password": passwordController.text,
    });
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    print(jsonBody);
     if (jsonData == "Success") {
      Flushbar(
        duration:  const Duration(seconds: 1),
        message:'Login Successful',
        messageColor:Colors.white,
        backgroundColor:Colors.green      ).show(context);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Employee(),),);
    }   else Flushbar(
                  message:  'Invalid Credentials',
                  duration:  const Duration(seconds: 2),
                  messageColor:Colors.white,
                  backgroundColor:Colors.red                  
                ).show(context); 
  }



}
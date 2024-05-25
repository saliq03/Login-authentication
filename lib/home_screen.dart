import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_tutorial/login.dart';
import 'package:login_tutorial/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("Home"),
       backgroundColor: Colors.blue,
       actions: [
         TextButton(onPressed: () async {

           var pref=await SharedPreferences.getInstance();
           pref.setBool(SSplashScreen.KEYLOGIN,false);
           Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>LoginScreen()));
         }, child: Text("Log out",style: TextStyle(color: Colors.white),))
       ],
     ),
     body: SizedBox(
       height: double.infinity,
     width: double.infinity,
     child: Image.asset("assets/images/bg.jpg"),
   ) ,
   );
  }

}
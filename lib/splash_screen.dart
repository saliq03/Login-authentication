

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_tutorial/database/db_helper.dart';
import 'package:login_tutorial/home_screen.dart';
import 'package:login_tutorial/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState()=>SSplashScreen();
}

class SSplashScreen extends State<SplashScreen>{
  static const String KEYLOGIN="loginkey";
  DbHelper dbhelper=DbHelper();
  @override
  void initState() {
    super.initState();
   dbhelper.mydatabase;
    Timer(Duration(seconds: 2),(){
    navigate();
    });

  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
       width: double.infinity,
       height: double.infinity,
       color: Colors.blue,
       child: Center(
         child: Text("Sdemy",style: TextStyle(color: Colors.red,fontSize: 70,fontWeight: FontWeight.bold),),
       ),
     ),
   );
  }

  Future<void> navigate() async {
    var pref= await SharedPreferences.getInstance();
    var isLogged=pref.getBool(KEYLOGIN);
    if(isLogged!=null){
      if(isLogged){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    }
  }
}

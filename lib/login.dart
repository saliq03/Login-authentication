

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_tutorial/database/db_helper.dart';
import 'package:login_tutorial/database/login_model.dart';
import 'package:login_tutorial/home_screen.dart';
import 'package:login_tutorial/signup.dart';
import 'package:login_tutorial/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget{

  State<LoginScreen> createState()=> _LoginScreen();
}
class _LoginScreen extends State<LoginScreen>{
  var usernameController=TextEditingController();
  var passwordController=TextEditingController();
  final _loginformkey=GlobalKey<FormState>();
  bool hideShowpassword =true;
  Icon passwordvisibility=Icon(Icons.visibility_off);
  DbHelper dbHelper=DbHelper();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("Sdemy"),
     ),
     body:Form(
       key:  _loginformkey,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           SizedBox(
             height: MediaQuery.of(context).size.width*0.5,
             width: 500,
               child: Image.asset("assets/images/bg.jpg")),

           Padding(
             padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
             child: TextFormField(
               controller: usernameController,
               decoration: InputDecoration(
                 prefixIcon: Icon(Icons.person),
                 hintText: "username",
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                 )
               ),
               validator: (value){
                 if(value!.isEmpty){
                   return 'enter username';
                 }

                 else{
                   return 'enter valid username';
                 }

               },
             ),
           ),

           Padding(
             padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
             child: TextFormField(
               controller: passwordController,
               obscureText: hideShowpassword,
               decoration: InputDecoration(
                   prefixIcon: Icon(Icons.lock),
                   suffixIcon: IconButton(onPressed:(){
                     if(hideShowpassword==true){
                       hideShowpassword=false;
                       passwordvisibility=Icon(Icons.visibility);
                     }
                     else{
                       hideShowpassword=true;
                       passwordvisibility=Icon(Icons.visibility_off);
                     }
                     setState(() {});
                   }, icon: passwordvisibility),
                   hintText: "password",
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10),
                   )
               ),
               validator: (value){
                 if(value!.isEmpty){
                   return 'enter password';
                 }
                 else{
                   return 'enter correct password';
                 }

               },
             ),
           ),

           Container(
             height: 55,
             width: MediaQuery.of(context).size.width*0.8,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(8),
               color: Colors.deepPurple),
             child: TextButton(onPressed: (){
                  Login();
             },
                 child: Text("LOGIN",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
           ),

           Row(mainAxisAlignment: MainAxisAlignment.center,
             children: [
             Text("Don't have an account?"),
              TextButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
              }, child: Text("SIGNUP"))],)
         ],

       ),
     ),
   );
  }

  Future<void> Login() async {
    var pref=await SharedPreferences.getInstance();


    Future<LoginModel?> Model=dbHelper.getData(usernameController.text.toString());
    Model.then((model){
      if(model!=null) {
        if (model!.password == passwordController.text.toString()) {
          pref.setBool(SSplashScreen.KEYLOGIN, true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
        else{
          _loginformkey.currentState!.validate();
          usernameController.clear();
          passwordController.clear();
        }
      }
      else{
        _loginformkey.currentState!.validate();
        usernameController.clear();
        passwordController.clear();
      }
    });

  }

}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_tutorial/database/login_model.dart';
import 'package:login_tutorial/login.dart';
import 'package:login_tutorial/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database/db_helper.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget{

  State<SignupScreen> createState()=> _SignupScreen();
}
class _SignupScreen extends State<SignupScreen> {
  DbHelper dbHelper = DbHelper();

  var usernamecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var confirmpasswordcontroller = TextEditingController();
  final _userformkey = GlobalKey<FormState>();
  int flag=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sdemy"),
      ),
      body: Form(
        key: _userformkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Register",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),
            Text("New Account",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: TextFormField(
                controller: usernamecontroller,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: "username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator:(value){
                  if(value!.isEmpty){
                    return "enter username";
                  }
                  // else if(validateusername()==true){
                  //   return 'Username already exist';
                  // }
                  else{
                    // return null;
                    return 'Username already exist';
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: TextField(
                controller: passwordcontroller,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: TextField(
                controller: confirmpasswordcontroller,
                // obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Confirm password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),
            ),
            Container(
              height: 55,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.deepPurple),
              child: TextButton(onPressed: () async {
                if (passwordcontroller.text.toString() ==
                    confirmpasswordcontroller.text.toString() && passwordcontroller.text.toString()!='') {
                  signup();
                }
                else{
                  passwordcontroller.clear();
                  confirmpasswordcontroller.clear();
                }
              },
                  child: Text("SIGN UP", style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),)),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }, child: Text("Login"))
              ],)
          ],
        ),
      ),
    );
  }

  Future<void> signup() async {
    int res = 0;
    var pref = await SharedPreferences.getInstance();
    var result = dbHelper.Insert(new LoginModel(
        usernamecontroller.text.toString(),
        passwordcontroller.text.toString()));
    if (result != 0) {
      // signing in logic
      try {
        LoginModel newuser = LoginModel(usernamecontroller.text.toString(),
            passwordcontroller.text.toString());
        Future<LoginModel?> Model = dbHelper.getData(
            usernamecontroller.text.toString());
        Model.then((model) async {
          if (model == null && usernamecontroller.text!='') {
            pref.setBool(SSplashScreen.KEYLOGIN, true);
            res = await dbHelper.Insert(newuser);
            print(res);
            if (res == 0) {
              print("user not registered");
            }
            else {
              _displaySnakbar(context, " User registered sucussfully");
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }
          }
          else {
           _userformkey.currentState!.validate();
           usernamecontroller.clear();
          }
        });
      }
      catch (e) {
        print("error occured while insert: $e");
      }
    }
  }

  // bool? validateusername() {
  //   Future<LoginModel?> Model = dbHelper.getData(
  //       usernamecontroller.text.toString());
  //   Model.then((model) async {
  //     if (model!=null) {
  //       return true;
  //     }
  //   });
  //  return false;
  // }
}
void _displaySnakbar(BuildContext context, String message) {
  final snackbar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

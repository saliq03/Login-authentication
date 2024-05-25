import 'dart:async';
import 'dart:io';

import 'package:login_tutorial/database/login_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{

  String TableName='LoginTable';
  String  UserName='username';
  String Password='password';

  static Database? _database;
   Future<Database?> get mydatabase async {
    if(_database!=null){
      print('database already created');
      return _database;
    }
    print('creating database');
    _database=await InitializeDatabase();
    print('data base created $_database');
    return _database;
    }

    InitializeDatabase() async {
     print("initializing database");

  Directory directory=await getApplicationDocumentsDirectory();
  String path=directory.path+'/loginapp.db';
  print("path");
  var db = openDatabase(path, version: 1, onCreate: _CreateDB);
  return db;
  }

  _CreateDB(Database db, int version) async {
     print("i am in create db");
   // await db.execute('CREATE TABLE $TableName($UserName TEXT PRIMARY KEY ,$Password TEXT)');
    try {
      await db.execute('CREATE TABLE $TableName($UserName TEXT ,$Password TEXT)');
      print("Table created successfully");
    } catch (e) {
      print("Error creating table: $e");
    }
  }

 Future<int> Insert(LoginModel data)async{
     var db=await _database;
     var result= await db!.insert(TableName, data.toMap());
     return result;
  }

  Future<LoginModel?> getData(String username)async{
    var db= _database;
    List<Map<String, dynamic>>result=await db!.query(TableName,where: '$UserName=?',whereArgs: [username]);
    if(result.isNotEmpty){
      return LoginModel.fromMap(result[0]);
    }
    return null;

  }

}

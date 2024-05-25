class LoginModel{
  String username;
  String password;
  LoginModel(this.username,this.password);

  String get pwd => password;


  Map<String,String> toMap(){
    var map=Map<String,String>();
    map['username']=username;
    map['password']=password;
    return map;
  }

 factory LoginModel.fromMap(Map<String,dynamic> map){
     return new LoginModel(
         map['username'],
         map['password']
     );
  }
}
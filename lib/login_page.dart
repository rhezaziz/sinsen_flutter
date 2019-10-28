import 'package:flutter/material.dart';
import 'home_page.dart';
import 'validasi.dart';
//import 'package:login/home_page.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Validasi{
  final formKey = GlobalKey<FormState>();

  String emailInput = '';
  String passwordInput = '';

  @override
  Widget build(context) {
    
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            SizedBox(height: 100.0),
            Image.asset('asset/logosinsen.png', width: 70.0 , height: 70.0,
        ),
            SizedBox(height: 40.0),
            email(),
            SizedBox(height: 10.0),
            password(),
            SizedBox(height: 24.0),
            loginButton(),
          ],
        )
      ),
    );

  }
  


    //
      Widget email(){
        return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Masukkan Email',
         contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: validasiEmail,
      onSaved: (String value){
        emailInput = value;
      },
    );
  }
  

   
      Widget password(){
        return TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Masukkan Password',
       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
       border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: validasiPassword,
      onSaved: (String value){
        passwordInput = value;
      },
    );
  }
  // 
     Widget loginButton(){
       return Padding(
         padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            if (formKey.currentState.validate()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
          
          formKey.currentState.save();
  
            }
          },
          color: Colors.lightBlueAccent,
          child: Text('Login', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
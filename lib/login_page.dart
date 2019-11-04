import 'dart:convert';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'validasi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'network_util.dart';
//import 'package:login/home_page.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> with Validasi {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  final formKey = GlobalKey<FormState>();

  String emailInput = '';
  String passwordInput = '';
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    final response = await http.post(BaseUrl.login,
        body: {"nim": emailInput, "password": passwordInput});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];

    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
      });
      print(pesan);
    } else {
      print(pesan);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(height: 100.0),
                  Image.asset(
                    'asset/logosinsen.png',
                    width: 70.0,
                    height: 70.0,
                  ),
                  SizedBox(height: 40.0),
                  emailVoid(),
                  SizedBox(height: 10.0),
                  passwordVoid(),
                  SizedBox(height: 24.0),
                  loginButton(),
                ],
              )),
        );
        break;
      case LoginStatus.signIn:
        // return HomePage();
        return HomePage();
        break;
    }
  }

  //
  Widget emailVoid() {
    return TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
        labelText: 'NIM',
        hintText: 'Masukkan NIM',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (e) {
        if (e.isEmpty) {
          return "Tolong Masukkan NIM";
        }
      },
      onSaved: (e) => emailInput = e,
    );
  }

  Widget passwordVoid() {
    return TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: _secureText,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Masukkan Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        suffixIcon: IconButton(
          onPressed: showHide,
          icon: Icon(_secureText ? Icons.visibility_off : Icons.visibility),
        ),
      ),
      validator: (e) {
        if (e.isEmpty) {
          return "Tolong Masukkan Password";
        }
      },
      onSaved: (e) => passwordInput = e,
    );
  }

  //
  Widget loginButton() {
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
            check();
          },
          color: Colors.lightBlueAccent,
          child: Text('Login', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

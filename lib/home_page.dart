import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  @override
  _HomePage createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {
  
  String barcode = "";

@override
  initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final foto = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50.0),
        child: CircleAvatar(
          radius: 72.0,
          backgroundColor: Colors.transparent,
          
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        'Selamat Datang',
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

    final salam = Padding(
    
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      
      child: Text(
        'Lakukan absen dengan cara mudah dengan melakukan klik button di bawah lalu scan QR yang diberikan dosen',
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );
    final loginButton = Padding(
      //padding: EdgeInsets.symmetric(vertical: 145.0),
      padding: EdgeInsets.symmetric(vertical: 50.0),
      child: Material(
        borderRadius: BorderRadius.circular(50.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: scan,
            //  Navigator.of(context).pushNamed(HomePage.tag);
            
                              
            
          
          color: Colors.white,
          child: Text('SCAN QR', style: TextStyle(color: Colors.lightBlueAccent)),
        ),
      ),
      
    );

   final test = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        '$barcode',
        style: TextStyle(fontSize: 15.0, color: Colors.white),
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ]),
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[foto, welcome, salam , loginButton , test],
      ),
    );
    
    return Scaffold(
      body: body,
    );
  }
    
Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = '');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}


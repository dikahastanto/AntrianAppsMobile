import 'package:flutter/material.dart';
import 'dart:async';
import 'Login.dart';
import 'Daftar.dart';
import 'HomeApp.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() =>runApp(new SplashScreen());

class SplashScreen extends StatelessWidget {
  String username;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Antrian Apss",
        home: new Home(),
        routes: <String,WidgetBuilder>{
          '/Login': (BuildContext) => new Login(),
          '/Daftar': (BuildContext) => new Daftar(),
          '/Home': (BuildContext) => new HomeApp(),
        }
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void pref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if(sharedPreferences.getBool("status") == true){
//        print(sharedPreferences.get('username'));
//        print(sharedPreferences.get('nama_lengkap'));
        Navigator.pushReplacement(context, new MaterialPageRoute(
            builder: (BuildContext context) => new HomeApp()
        )
        );
    }else{
      Navigator.of(context).pushReplacementNamed("/Login");
//      print(sharedPreferences.get('username'));
    }
    
  }

//  void navigationPage(){
//      if(pref !=null){
////        Navigator.of(context).pushReplacementNamed("/Login");
//      }else{
//
//        print(object)
//
//      }
//  }

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, pref);
  }


  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Image.asset("img/queue.png",width: 100.0,),
//              new Padding(padding: new EdgeInsets.only(top: 255.0)),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Padding(padding: new EdgeInsets.only(top: 65.0)),
                    new CircularProgressIndicator()
                  ],
                )
              ],
          ),
        )
      )

    );
  }
}

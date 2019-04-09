import 'package:flutter/material.dart';
import 'Daftar.dart';
import 'Constants.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'HomeApp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:antrian_apss/HomeApp.dart';
import 'LupaPassword.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formLogin = GlobalKey<FormState>();
  TextEditingController controllerusername = new TextEditingController();
  TextEditingController controllerpassword = new TextEditingController();

  var url = masterurl+'userlogin1';

  String username="",
        msg="",
      nama_lengkap="";

  Future<List> _login() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

      final response = await http.post(
          url,
          body: {
            "username" : controllerusername.text,
            "password" : controllerpassword.text
          });

      var result = json.decode(response.body);
      String pesan_eror = result['pesan'];

      if(result['user']==null){
        setState(() {
//          print(msg = pesan_eror);
        _alertdialog(pesan_eror + ' !');
        });
      }else {

        setState(() {
          username = result['user']['username'];
          nama_lengkap = result['user']['nama_lengkap'];
          String email =result['user']['email'];
          sharedPreferences.setString("username", username);
          sharedPreferences.setString("nama_lengkap", nama_lengkap);
          sharedPreferences.setString("email", email);
          sharedPreferences.setBool("status", true);

        });

        Navigator.pushReplacement(context, new MaterialPageRoute(
            builder: (BuildContext context) => new HomeApp()
        )
        );


      }

    return result;

  }

  void _alertdialog(String str) {
    if (str.isEmpty) return;

    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
        str,
        style: new TextStyle(fontSize: 20.0),
      ),
      actions: <Widget>[
        new RaisedButton(
          color: Colors.blueAccent,
          child: new Text(
            "Ok",
            style: new TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: new Center(
            child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            new Form(
                key: _formLogin,
                child: new Container(
                  padding: new EdgeInsets.only(left: 40.0, right: 40.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new CircleAvatar(
                        radius: 85.0,
                        backgroundColor: Colors.white,
                        backgroundImage: new AssetImage(
                          "img/queue2.png",
                        )
                      ),
                      new Padding(padding: new EdgeInsets.only(top: 20.0)),
                      new Text(
                        "Aplikasi Antrian",
                        style: new TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                      new Padding(padding: new EdgeInsets.only(top: 20.0)),
                      new TextFormField(
                        controller: controllerusername,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Username Tidak Boleh Kosong";
                          }
                        },
                        decoration: new InputDecoration(
                          icon: Icon(
                            Icons.account_circle,
                            color: appbarcolor,
                          ),
                          fillColor: Colors.white,
                          hintText: "Username",
                          labelText: "Username",
                        ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.only(top: 20.0),
                      ),
                      new TextFormField(
                        controller: controllerpassword,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password Tidak Boleh Kosong";
                          }
                        },
                        obscureText: true,
                        decoration: new InputDecoration(
                          icon: Icon(
                            Icons.vpn_key,
                            color: appbarcolor,
                          ),
                          fillColor: Colors.white,
                          hintText: "Password",
                          labelText: "Password",
                        ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.only(top: 30.0),
                      ),
                      ButtonTheme(
                        minWidth: 400.0,
                        height: 55.0,
                        child: new RaisedButton(
                            child: new Text(
                              "Login",
                              style: new TextStyle(fontSize: 20.0),
                            ),
                            onPressed: () {
                              if (_formLogin.currentState.validate()) {
                                _login();
                              }
                            },
                            color: appbarcolor,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0))),
                      ),
                      new Padding(
                        padding: new EdgeInsets.only(top: 30.0),
                      ),

                      new Center(
                         child: new Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text("Tidak Punya akun? "),
                              new GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(new MaterialPageRoute(
                                      builder: (BuildContext context)=>new Daftar()
                                  )
                                  );
                                },
                                child: new Text(" Daftar Disini"),
                              )
                            ],
                          )
                      ),

                      new Padding(
                        padding: new EdgeInsets.only(top: 30.0),
                      ),

                      new Center(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text("Lupa Password? "),
                              new GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(new MaterialPageRoute(
                                      builder: (BuildContext context)=>new LupaPassword()
                                  )
                                  );
                                },
                                child: new Text(" Klik Disini"),
                              )
                            ],
                          )
                      )

                    ],
                  ),
                ))
          ],
        )));
  }
}

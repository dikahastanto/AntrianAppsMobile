import 'package:flutter/material.dart';
import 'package:antrian_apss/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:antrian_apss/Login.dart';

class LupaPassword extends StatefulWidget {
  @override
  _LupaPasswordState createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {

  final _registerkey = GlobalKey<FormState>();
  final _registerkey1 = GlobalKey<FormState>();
  TextEditingController controlleremail = new TextEditingController();
  TextEditingController controllerkode = new TextEditingController();
  TextEditingController controllerpassword = new TextEditingController();
  TextEditingController controllernewpassword = new TextEditingController();
  String email;

  void kirimkode() async{

    setState(() {
      email = controlleremail.text;
    });

    var url = masterurl + "sendverfemail";

    final response = await http.post(url,body: {
      "email" : email
    });
    
    var result = json.decode(response.body);
    
    _snackbar(result['pesan'], Icons.check, Colors.greenAccent);

  }

  void _snackbar(String str, IconData icon, Color color) {
    if (str.isEmpty) return;

    _scaffoldState.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Row(
        children: <Widget>[
          new Text(
            str,
            style: new TextStyle(fontSize: 20.0),
          ),
          new Padding(padding: new EdgeInsets.only(left: 20.0)),
          new Icon(icon)
        ],
      ),
      duration: new Duration(seconds: 3), // control durasi
    ));
  }

  final GlobalKey<ScaffoldState> _scaffoldState =
  new GlobalKey<ScaffoldState>();

  void resetpassword() async{

    if(controllerpassword.text != controllernewpassword.text){

      _snackbar("Ketik Ulang Password Dengan Benar !", Icons.warning, Colors.redAccent);

    }else{
      var url = masterurl + "chagedPAsswordForget";

      final response = await http.post(url,body: {
        "email" : email,
        "kode" : controllerkode.text,
        "password" :controllerpassword.text
      });

      var result = json.decode(response.body);

      if(result['pesan'] == "Berhasil Ganti Password"){
        _alertdialog("Berhasil", false);
      }else{
        _alertdialog("Gagal", true);
      }

    }

  }

  void _alertdialog(String str, bool error) {
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
            if (error == true) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => Login()));
            }
          },
        )
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldState,
        appBar: new AppBar(
          title: new Text("Lupa Password"),
          backgroundColor: appbarcolor,
        ),
        backgroundColor: bgapp,

        body: new Center(
            child: new ListView(
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.only(top: 30.0),
                ),
                new Form(
                    key: _registerkey,
                    child: new Container(
                      color: bgapp,
                      padding: new EdgeInsets.only(left: 20.0, right: 20.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          new Padding(padding: new EdgeInsets.only(top: 20.0)),
                          new TextFormField(
                            controller: controlleremail,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Masukan Email Anda";
                              }
                            },
                            decoration: new InputDecoration(
                              fillColor: Colors.red,
                              hintText: "Email",
                            ),
                          ),
                          new Padding(
                            padding: new EdgeInsets.only(top: 20.0),
                          ),


                          ButtonTheme(
                            minWidth: 400.0,
                            height: 55.0,
                            child: new RaisedButton(
                                child: new Text(
                                  "Minta Kode",
                                  style: new TextStyle(fontSize: 20.0),
                                ),
                                onPressed: () {
                                  if (_registerkey.currentState.validate()) {
                                    kirimkode();

                                  }
                                },
                                color: appbarcolor,
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0))),
                          ),

                          new Padding(
                            padding: new EdgeInsets.only(top: 30.0),
                          ),


                        ],
                      ),
                    )
                ),


                new Form(
                    key: _registerkey1,
                    child: new Container(
                      color: bgapp,
                      padding: new EdgeInsets.only(left: 20.0, right: 20.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          new Padding(padding: new EdgeInsets.only(top: 20.0)),
                          new TextFormField(
                            controller: controllerkode,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Masukan Kode";
                              }
                            },
                            decoration: new InputDecoration(
                              fillColor: Colors.red,
                              hintText: "Kode",
                            ),
                          ),
                          new Padding(
                            padding: new EdgeInsets.only(top: 20.0),
                          ),

                          new Padding(padding: new EdgeInsets.only(top: 20.0)),
                          new TextFormField(
                            controller: controllerpassword,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Masukan Password";
                              }
                            },
                            obscureText: true,
                            decoration: new InputDecoration(
                              fillColor: Colors.red,
                              hintText: "Password",
                            ),
                          ),
                          new Padding(
                            padding: new EdgeInsets.only(top: 20.0),
                          ),

                          new Padding(padding: new EdgeInsets.only(top: 20.0)),
                          new TextFormField(
                            controller: controllernewpassword,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Masukan Password Ulang";
                              }
                            },
                            obscureText: true,
                            decoration: new InputDecoration(
                              fillColor: Colors.red,
                              hintText: "Ketik Ulang Password",
                            ),
                          ),
                          new Padding(
                            padding: new EdgeInsets.only(top: 20.0),
                          ),


                          ButtonTheme(
                            minWidth: 400.0,
                            height: 55.0,
                            child: new RaisedButton(
                                child: new Text(
                                  "Reset Password",
                                  style: new TextStyle(fontSize: 20.0),
                                ),
                                onPressed: () {
                                  if (_registerkey1.currentState.validate()) {
                                    resetpassword();

                                  }
                                },
                                color: appbarcolor,
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0))),
                          ),

                          new Padding(
                            padding: new EdgeInsets.only(top: 30.0),
                          ),


                        ],
                      ),
                    ))
              ],
            ))
    );
  }
}



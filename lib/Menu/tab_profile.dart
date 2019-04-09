import 'package:flutter/material.dart';
import 'package:antrian_apss/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../GantiPassword.dart';

class TabProfile extends StatefulWidget {
  @override
  _TabProfileState createState() => _TabProfileState();
}



class _TabProfileState extends State<TabProfile> {


  final _registerkey = GlobalKey<FormState>();
  TextEditingController controllerusername;
  TextEditingController controlleremail = new TextEditingController();
  TextEditingController controllernama_lengkap = new TextEditingController();

  void get_data_user() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {

      controllerusername=new TextEditingController(
        text: sharedPreferences.getString("username")
      );
      
      controlleremail = new TextEditingController(
        text: sharedPreferences.getString("email")
      );

      controllernama_lengkap = new TextEditingController(
          text: sharedPreferences.getString("nama_lengkap")
      );

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    get_data_user();
    super.initState();
  }

  Future<List> updateuser() async{

    var url = masterurl+"updateuser/${controllerusername.text}";
    final response = await http.put(url,body:
            {
              "email" : controlleremail.text,
              "nama_lengkap" : controllernama_lengkap.text,
              "username" : controllerusername.text
            }

    );

    var result = json.decode(response.body);
    
    _alertdialog(result['message']);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString("username", result['user']['username']);
      sharedPreferences.setString("email", result['user']['email']);
      sharedPreferences.setString("nama_lengkap", result['user']['nama_lengkap']);

    });

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
        resizeToAvoidBottomPadding: false,
        body: new Center(
            child: new ListView(
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.only(top: 30.0),
                ),
                new Form(
                    key: _registerkey,
                    child: new Container(
                      padding: new EdgeInsets.only(left: 20.0, right: 20.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Padding(padding: new EdgeInsets.only(top: 20.0)),
                          new Text(
                            "Update Data User",
                            style: new TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold),
                          ),
                          new Padding(padding: new EdgeInsets.only(top: 20.0)),
                          new TextFormField(
                            enabled: false,
                            controller: controllerusername,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Username Tidak Boleh Kosong";
                              }
                            },
                            decoration: new InputDecoration(
                              fillColor: Colors.red,
                              hintText: "Username",
                            ),
                          ),
                          new Padding(
                            padding: new EdgeInsets.only(top: 20.0),
                          ),

                          new Padding(
                            padding: new EdgeInsets.only(top: 30.0),
                          ),

                          new TextFormField(
                            controller: controlleremail,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Email tidak boleh kosong";
                              }

                              if(validateEmail(value) != null){
                                return "Format Email Salah";
                              }
                            },
                            decoration: new InputDecoration(
                              fillColor: Colors.white,
                              hintText: "Email",
                            ),
                          ),

                          new Padding(
                            padding: new EdgeInsets.only(top: 30.0),
                          ),

                          new TextFormField(
                            controller: controllernama_lengkap,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Username Tidak Boleh Kosong";
                              }
                            },
                            decoration: new InputDecoration(
                              fillColor: Colors.red,
                              hintText: "Nama Lengkap",
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
                                  "Update Data",
                                  style: new TextStyle(fontSize: 20.0),
                                ),
                                onPressed: () {
                                  if (_registerkey.currentState.validate()) {

                                    updateuser();

                                  }
                                },
                                color: appbarcolor,
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0))),
                          ),
                          new Padding(
                            padding: new EdgeInsets.only(top: 30.0),
                          ),

                          ButtonTheme(
                            minWidth: 400.0,
                            height: 55.0,
                            child: new RaisedButton(
                                child: new Text(
                                  "Ganti Passord",
                                  style: new TextStyle(fontSize: 20.0),
                                ),
                                onPressed: () {
                                    Navigator.push(context, new MaterialPageRoute(
                                        builder: (BuildContext context)=>new GantiPassword()));
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
            )
        )
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
}
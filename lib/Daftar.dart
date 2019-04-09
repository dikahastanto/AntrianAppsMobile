import 'package:flutter/material.dart';
import 'package:antrian_apss/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:antrian_apss/Login.dart';
import 'VerfEmail.dart';

class Daftar extends StatefulWidget {
  @override
  _DaftarState createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {

  final _registerkey = GlobalKey<FormState>();
  TextEditingController controllerusername = new TextEditingController();
  TextEditingController controllerpassword = new TextEditingController();
  TextEditingController controlleremail = new TextEditingController();
  TextEditingController controllernama_lengkap = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Daftar Akun"),
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
                          new Image.asset(
                            "img/queue.png",
                            width: 100.0,
                          ),
                          new Padding(padding: new EdgeInsets.only(top: 20.0)),
                          new Text(
                            "Daftar Akun",
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
                              fillColor: Colors.red,
                              hintText: "Username",
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
                              fillColor: Colors.white,
                              hintText: "Password",
                            ),
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
                                  "Daftar",
                                  style: new TextStyle(fontSize: 20.0),
                                ),
                                onPressed: () {
                                  if (_registerkey.currentState.validate()) {
                                    addData();

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
                                  "Vefifikasi Akun",
                                  style: new TextStyle(fontSize: 20.0),
                                ),
                                onPressed: () {
                                  Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) => new VerfEmail())
                                  );
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

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  Future<List> addData() async{
    var url=masterurl + "createuser";

    final response = await http.post(url,body: {
      "username": controllerusername.text,
      "password" : controllerpassword.text,
      "email" : controlleremail.text,
      "nama_lengkap" : controllernama_lengkap.text
    });


    var result = json.decode(response.body);
    bool error = result['error'];
      if(error==true){

        _alertdialog(result['message'],error);

      }else{

        _alertdialog(result['message'],error);

      }


    return result;

  }

  void _alertdialog(String str,bool error) {
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
            if(error==true){
              Navigator.pop(context);
            }else{
              Navigator.pushReplacement(context, new MaterialPageRoute(
                  builder: (BuildContext context) => new Login()
              )
              );
            }
          },
        )
      ],
    );

    showDialog(context: context, child: alertDialog);
  }


}
//Future<List<Product>> getWishList() async {
//  http.Response response = await http.post(
//    MY_URL,
//    headers: {
//      HttpHeaders.acceptHeader: 'application/json',
//      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
//    },
//  );
//  if (response.statusCode == 200) {
//    List<Product> ret = List();
//    Map<String, dynamic> result;
//    try {
//      result = json.decode(response.body);
//      for (var i = 0; i < result['data'].length; i++) {
//        ret.add(Product.fromJson(result['data'][i]));
//      }
//      return ret;
//    } catch (e) {
//      return throw Exception("Json parse error");
//    }
//  } else {
//    return throw Exception("network connection failed");
//  }
//}
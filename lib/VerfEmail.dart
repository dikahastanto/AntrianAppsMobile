import 'package:flutter/material.dart';
import 'package:antrian_apss/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:antrian_apss/Login.dart';

class VerfEmail extends StatefulWidget {
  @override
  _VerfEmailState createState() => _VerfEmailState();
}

class _VerfEmailState extends State<VerfEmail> {

  final _registerkey = GlobalKey<FormState>();
  TextEditingController controllerusername = new TextEditingController();
  TextEditingController controllerkode = new TextEditingController();

  void verifikasi() async{
    var url = masterurl+"verfemail";
    final response = await http.post(url,
      body: {
        "username" : controllerusername.text,
        "token" : controllerkode.text
      }
    );

    var result = json.decode(response.body);

    if(result['pesan']=="Berhasil"){
        _alertdialog("Akun Anda Aktif. Silahkan Login", false);
    }else{
      _alertdialog(result['pesan'], true);
    }

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Verifikasi Email Akun"),
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
                            controller: controllerkode,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Kode Tidak Boleh Kosong";
                              }
                            },
                            decoration: new InputDecoration(
                              fillColor: Colors.white,
                              hintText: "Kode",
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
                                  "Verifikasi",
                                  style: new TextStyle(fontSize: 20.0),
                                ),
                                onPressed: () {
                                  if (_registerkey.currentState.validate()) {
                                    verifikasi();

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

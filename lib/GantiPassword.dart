import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:antrian_apss/Constants.dart';

class GantiPassword extends StatefulWidget {
  @override
  _GantiPasswordState createState() => _GantiPasswordState();
}

class _GantiPasswordState extends State<GantiPassword> {
  final _formpassword = GlobalKey<FormState>();
  TextEditingController controller_password_lama = new TextEditingController();
  TextEditingController controller_password_baru = new TextEditingController();
  TextEditingController controllernama_password_verf = new TextEditingController();

  void cekpassword(){
    bool error = false;
    if(controller_password_baru.text != controllernama_password_verf.text){

    }
  }

  Future<List> gantipassword() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    sharedPreferences.getString("username");

    var url = masterurl +'updatepassword';
    final response = await http.put(url,
        body: {
          'current_password': controller_password_lama.text,
          'new_password' :controller_password_baru.text,
          'username' : sharedPreferences.getString("username")
        }
    );

    var result = json.decode(response.body);
//    print(result['message']);
  if(result['error']==true){
    _snackbar(result['message'], Icons.warning, Colors.red);
  }else{
    _snackbar(result['message'], Icons.info_outline, Colors.greenAccent);
    setState(() {
      controller_password_lama.text ="";
      controller_password_baru.text="";
      controllernama_password_verf.text="";
    });
  }
  }
  final GlobalKey<ScaffoldState> _scaffoldState =
  new GlobalKey<ScaffoldState>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: new AppBar(
        title: new Text("Ubah Password"),
        backgroundColor: appbarcolor,
      ),

      body: ListView(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(top: 5.0),
          ),
          new Form(
              key: _formpassword,
              child: new Container(
                padding: new EdgeInsets.only(left: 20.0, right: 20.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Padding(padding: new EdgeInsets.only(top: 20.0)),
                    new TextFormField(
                      controller: controller_password_lama,
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Password";
                        }
                      },
                      decoration: new InputDecoration(
                        fillColor: Colors.red,
                        hintText: "Password Sekarang",
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(top: 20.0),
                    ),

                    new TextFormField(
                      obscureText: true,
                      controller: controller_password_baru,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Isi Password Baru";
                        }

                      },
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        hintText: "Password Baru",
                      ),
                    ),

                    new Padding(
                      padding: new EdgeInsets.only(top: 30.0),
                    ),

                    new TextFormField(
                      controller: controllernama_password_verf,
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Isi Password Verifikasi";
                        }
                        if(value != controller_password_baru.text){
                          return "Password Tidak Sama";
                        }
                      },
                      decoration: new InputDecoration(
                        fillColor: Colors.red,
                        hintText: "Ketik Ulang Password",
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
                            "Update Password",
                            style: new TextStyle(fontSize: 20.0),
                          ),
                          onPressed: () {
                            if (_formpassword.currentState.validate()) {

                              gantipassword();

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
          )
        ],
      ),
    );
  }
}

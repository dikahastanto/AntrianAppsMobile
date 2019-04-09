import 'package:flutter/material.dart';
import 'package:antrian_apss/Constants.dart';
import 'package:antrian_apss/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './../CekStatus.dart';
import './../AmbilNomor.dart';
import './../TampilJadwal.dart';


class TabHome extends StatelessWidget {

  void logout() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colornew,
        body: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            new Container(
              child: new Column(
                children: <Widget>[

                  new Image.asset("img/layout.png",fit: BoxFit.fitWidth),

                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context)=>new AmbilNomor()
                          )
                          );
                        },
                          child: new Column(
                            children: <Widget>[
                              new Padding(
                                  padding: new EdgeInsets.only(top: 20.0)),

                              new Container(
                                width: 90.0,
                                height: 90.0,
                                child: new Icon(Icons.confirmation_number,size: 50.0,color: Colors.white,),
                                decoration: new BoxDecoration(
                                  color: Colors.lightBlue,
                                  shape: BoxShape.circle,
                                ),
                              ),

                              new Padding(padding: new EdgeInsets.only(top: 15.0)),

                              new Text(
                                "Ambil Nomor",
                                style: new TextStyle(fontSize: 20.0),
                              ),
                              new Padding(
                                  padding: new EdgeInsets.only(
                                      left: 80.0, bottom: 20.0, right: 80.0)),
                            ],
                          ),
                      ),

                      new Container(
                        color: Colors.white,
                        width: 2.0,
                        height: 120.0,
                      ),

                      new GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context)=>new CekStatus()
                          )
                          );
                        },
                          child: new Column(
                            children: <Widget>[
                              new Padding(
                                  padding: new EdgeInsets.only(top: 20.0)),

                              new Container(
                                width: 90.0,
                                height: 90.0,
                                child: new Icon(Icons.check_circle,size: 50.0,color: Colors.white,),
                                decoration: new BoxDecoration(
                                  color: Colors.indigoAccent,
                                  shape: BoxShape.circle,
                                ),
                              ),

                              new Padding(padding: new EdgeInsets.only(top: 15.0)),

                              new Text(
                                "Cek Status",
                                style: new TextStyle(fontSize: 20.0),
                              ),
                              new Padding(
                                  padding: new EdgeInsets.only(
                                      left: 80.0, bottom: 20.0, right: 80.0)),
                            ],
                          ),
                      ),
                    ],
                  ),

                  new Container(
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          color: Colors.white,
                          width: 130.0,
                          height: 2.0,
                        ),

                        new Padding(padding: new EdgeInsets.only(left: 24.0)),

                        new Container(
                          color: Colors.white,
                          width: 130.0,
                          height: 2.0,
                        ),
                      ],
                    ),
                  ),

                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context)=>new TampilJadwal()
                          )
                          );
                        },
                          child: new Column(
                            children: <Widget>[
                              new Padding(
                                  padding: new EdgeInsets.only(top: 20.0)),

                              new Container(
                                width: 90.0,
                                height: 90.0,
                                child: new Icon(Icons.schedule,size: 50.0,color: Colors.white,),
                                decoration: new BoxDecoration(
                                  color: Colors.orangeAccent[100],
                                  shape: BoxShape.circle,
                                ),
                              ),

                              new Padding(padding: new EdgeInsets.only(top: 15.0)),

                              new Text(
                                "Jadwal",
                                style: new TextStyle(fontSize: 20.0),
                              ),
                              new Padding(
                                  padding: new EdgeInsets.only(
                                      left: 80.0, bottom: 20.0, right: 80.0)),
                            ],
                          ),
                      ),

                      new Container(
                        color: Colors.white,
                        width: 2.0,
                        height: 120.0,
                      ),

                      new GestureDetector(
                        onTap: (){
                            logout();
                            Navigator.pushReplacement(context, new MaterialPageRoute(
                                builder: (BuildContext context) => new Login()
                            )
                            );
                        },
                          child: new Column(
                            children: <Widget>[
                              new Padding(
                                  padding: new EdgeInsets.only(top: 20.0)),

                              new Container(
                                width: 90.0,
                                height: 90.0,
                                child: new Icon(Icons.exit_to_app,size: 50.0,color: Colors.white,),
                                decoration: new BoxDecoration(
                                  color: Colors.pinkAccent,
                                  shape: BoxShape.circle,
                                ),
                              ),

                              new Padding(padding: new EdgeInsets.only(top: 15.0)),

                              new Text(
                                "Logout",
                                style: new TextStyle(fontSize: 20.0),
                              ),
                              new Padding(
                                  padding: new EdgeInsets.only(
                                      left: 80.0, bottom: 20.0, right: 80.0)),
                            ],
                          ),
                      ),
                    ],
                  ),

                  new Padding(padding: new EdgeInsets.only(top: 20.0)),

                ],
              ),
            )
          ],
        )
        );
  }
}

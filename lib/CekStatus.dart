import 'package:flutter/material.dart';
import 'Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomeApp.dart';
import 'SemuaAntrian.dart';

class CekStatus extends StatefulWidget {
  @override
  _CekStatusState createState() => _CekStatusState();
}

class _CekStatusState extends State<CekStatus> {

  final GlobalKey<ScaffoldState> _scaffoldState =
  new GlobalKey<ScaffoldState>();
  var username="";
  int id=0;
  String no_panggil="A1",jam="--:--",jenis_layanan="-",jam_tampil="--:--",tgl="--:--";
  bool _button_cancle = false;

  void getdatauser() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {

      username = sharedPreferences.getString("username");

    });
  }




  Future<List> getDataAntrian() async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {

      username = sharedPreferences.getString("username");

    });

    var url = masterurl+'getnoantrianbyusernameandtgl/${username}';

    final response = await http.get(url);

    var result = json.decode(response.body);


    if(result['data_antrian']['id']==null){

      setState(() {
        id = 0;
        no_panggil = "A1";
        jam = "";
        jam_tampil = "--:--";
        jenis_layanan = "-";
        tgl = "--";
      });

    }else{

      setState(() {
        id = result['data_antrian']['id'];
        no_panggil = result['data_antrian']['no_panggil'];
        jam = result['data_antrian']['jam'];
        jam_tampil = jam.substring(11,16);
        jenis_layanan = result['data_antrian']['jenis_layanan'];
        tgl = jam.substring(0,10);

        _button_cancle = true;
        
      });

    }


  }

  @override
  void initState() {
    getDataAntrian();
    super.initState();

  }

  Future<List> cancleNoAntrian() async{

    var url = masterurl+'deletnoantrian/${id}/${tgl}';
    final response = await http.delete(url);
    var result = json.decode(response.body);

    _alertdialog(result['message']);

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
            Navigator.pushReplacement(context, new MaterialPageRoute(
                builder: (BuildContext context) => HomeApp()
            )
            );
          },
        )
      ],
    );

    showDialog(context: context, child: alertDialog);
  }


  @override
  Widget build(BuildContext context) {
    var _onPressed;
    if(_button_cancle){
      _onPressed = (){
        cancleNoAntrian();
      };
    }
    return new Scaffold(
      key: _scaffoldState,
      appBar: new AppBar(
        title: new Text("Status antrian hari ini"),
        backgroundColor: colornew,
      ),
      backgroundColor: bgapp,
      resizeToAvoidBottomPadding: false,
      body: new ListView(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(top: 0.0),
          ),
          new Container(
            padding: new EdgeInsets.only(left: 20.0, right: 20.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Padding(padding: new EdgeInsets.only(top: 20.0)),


                new Card(
                    child:new Row(
                      children: <Widget>[
                        new Padding(padding: new EdgeInsets.only(top:90.0,left: 40.0,bottom: 60.0)),

                        new Icon(Icons.local_activity,size: 100.0,color: appbarcolor,),

                        new Padding(padding: new EdgeInsets.only(left: 20.0)),

                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(no_panggil,style: new TextStyle(fontSize: 70.0),),
                            new Text(jenis_layanan,style: new TextStyle(fontSize: 25.0),),
                            new Text(jam_tampil + " WIB",style: new TextStyle(fontSize: 20.0),),
                          ],
                        ),


                      ],
                    )
                ),

                new Padding(padding: new EdgeInsets.only(top: 20.0)),

                new Text("Keterangan",style: new TextStyle(fontSize: 30.0),textAlign: TextAlign.left,),

                new Padding(padding: new EdgeInsets.only(top: 20.0)),

                new Text("1. Nomor antrian Anda",style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.left,),

                new Padding(padding: new EdgeInsets.only(top: 20.0)),

                new Text("2. Anda Akan Dilayani pada  WIB",style: new TextStyle(fontSize: 20.0),textAlign: TextAlign.left,),

                new Padding(padding: new EdgeInsets.only(top: 20.0)),

                new Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Expanded(
                        child: new ButtonTheme(
                          height: 50.0,
                          child: new RaisedButton(
                              onPressed: _onPressed,
                              child: new Text("Cancle Nomor",style: new TextStyle(fontSize: 20.0),),
                              color: appbarcolor,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0))
                          ),
                        )
                    )
                  ],
                ),

                new Padding(padding: new EdgeInsets.only(top: 20.0)),

                new Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Expanded(
                        child: new ButtonTheme(
                          height: 50.0,
                          child: new RaisedButton(
                              onPressed: (){
                                Navigator.push(context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context)=> SemuaAntrian()));
                              },
                              child: new Text("Tampilkan Semua",style: new TextStyle(fontSize: 20.0),),
                              color: appbarcolor,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0))
                          ),
                        )
                    )
                  ],
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}

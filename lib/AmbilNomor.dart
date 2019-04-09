import 'package:flutter/material.dart';
import 'dart:async';
import 'Constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'HomeApp.dart';

class AmbilNomor extends StatefulWidget {
  @override
  _AmbilNomorState createState() => _AmbilNomorState();
}

class _AmbilNomorState extends State<AmbilNomor> {
  DateTime _date = new DateTime.utc(2019, 02, 01);
//  List<String> layanan1 = ["Layanan Umum", "Konsultasi", "Cek Kesehatan"];
  List layanan = List();

  String _layanan,
      noPanggil = "--",
      jam,
      jamTampil = "--:--",
      username,
      namaLengkap;
  bool buttonSimpan = false;

  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    this.getDataLayanan();
    this.getDataUser();
  }

  void pilihLayanan(String value) {
    setState(() {
      _layanan = value;
    });
  }

  Future<String> getDataLayanan() async {
    final response =
        await http.get(Uri.encodeFull(masterurl + "/getdatalayanan"));
//    return json.decode(response.body.toString());

    var hasil = json.decode(response.body);

    setState(() {
      layanan = hasil;
    });

    return "Success";
//
//  print(layanan);
//  print(hasil[1]['nama_layanan']);
//    print(hasil[0]['nama_layanan']);
  }

  Future<Null> _selectdate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2019),
        lastDate: new DateTime(2022));

    if (picked != null && picked != _date) {
//      print("date selected: ${_date.toString()}");
      setState(() {
        _date = picked;
      });
    }
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

  Future<List> _getNoAntrian() async {
    var url = masterurl + 'getnoantrian/${_date}/${username}';
    final response = await http.get(url);

    var result = json.decode(response.body);

//    print(result);

    if (result['error'] == true) {
      _snackbar(result['msg'], Icons.warning, Colors.red);
      setState(() {
        noPanggil = "--";
        jam = '--:--';
        jamTampil = '--:--';
        buttonSimpan = false;
      });
    } else {
      _snackbar(result['msg'], Icons.info_outline, Colors.green);

      setState(() {
        noPanggil = result['data_antrian']['no_panggil'];
        jam = result['data_antrian']['jam'];
        jamTampil = jam.substring(0, 5);
        buttonSimpan = true;
      });
    }

    return result['msg'];
  }

  void getDataUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPreferences.getString("username");
      namaLengkap = sharedPreferences.getString("nama_lengkap");
    });
  }

  Future<List> simpanNoAntrian() async {
    var url = masterurl + "insertnoantrian";
//    print(_date);
    final response = await http.post(url, body: {
      "no_panggil": noPanggil,
      "username": username,
      "jenis_layanan": _layanan,
      "nama_lengkap": namaLengkap,
      "jam": _date.year.toString() +
          "-" +
          _date.month.toString() +
          "-" +
          _date.day.toString() +
          " " +
          jam
    });


    var result = json.decode(response.body);

    bool error = result['error'];
    if (error == true) {
      _alertdialog(result['message'], error);
    } else {
      _alertdialog(result['message'], error);
    }

    return result;
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
                      builder: (BuildContext context) => HomeApp()));
            }
          },
        )
      ],
    );

    showDialog(context: context, child: alertDialog);
  }


  @override
  Widget build(BuildContext context) {
    var _onPressed;
    if (buttonSimpan) {
      _onPressed = () {
        simpanNoAntrian();
      };
    }
    return new Scaffold(
      key: _scaffoldState,
      appBar: new AppBar(
        title: new Text("Ambil Nomor"),
        backgroundColor: colornew,
      ),
      backgroundColor: Colors.blueGrey[100],
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
                    child: new ListTile(
                  contentPadding: new EdgeInsets.all(20.0),
                  leading: new Icon(
                    Icons.date_range,
                    size: 50.0,
                    color: appbarcolor,
                  ),
                  title: new GestureDetector(
                    onTap: _selectdate,
                    child: new Text(
                      _date.year.toString() +
                          "-" +
                          _date.month.toString() +
                          "-" +
                          _date.day.toString(),
                      style: new TextStyle(fontSize: 20.0),
                    ),
                  ),
                )),
                new Padding(padding: new EdgeInsets.only(top: 20.0)),
                new Card(
                    child: new ListTile(
                        contentPadding: new EdgeInsets.all(20.0),
                        leading: new Icon(
                          Icons.healing,
                          size: 50.0,
                          color: appbarcolor,
                        ),
                        title: new DropdownButton(
                            value: _layanan,
                            hint: new Text("Pilih Layanan"),
                            items: layanan.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['nama_layanan']),
                                value: item['nama_layanan'].toString(),
                              );
                            }).toList(),
                            onChanged: (String value) {
                              pilihLayanan(value);
                            }))),
                new Padding(padding: new EdgeInsets.only(top: 20.0)),
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Expanded(
                        child: new ButtonTheme(
                      height: 50.0,
                      child: new RaisedButton(
                          onPressed: () {
                            _getNoAntrian();
                          },
                          child: new Text(
                            "Cek Nomor",
                            style: new TextStyle(fontSize: 20.0),
                          ),
                          color: btnColor,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0))),
                    ))
                  ],
                ),
                new Padding(padding: new EdgeInsets.only(top: 20.0)),
                new Card(
                    child: new Row(
                  children: <Widget>[
                    new Padding(
                        padding: new EdgeInsets.only(
                            top: 110.0, left: 40.0, bottom: 20.0)),
                    new Icon(
                      Icons.local_activity,
                      size: 90.0,
                      color: appbarcolor,
                    ),
                    new Column(
                      children: <Widget>[
                        new Text(
                          noPanggil,
                          style: new TextStyle(fontSize: 70.0),
                        ),
                        new Text(
                          "Jam " + jamTampil + " WIB",
                          style: new TextStyle(fontSize: 30.0),
                        )
                      ],
                    )
                  ],
                )),
                new Padding(padding: new EdgeInsets.only(top: 20.0)),
                new Text(
                  "Keterangan",
                  style: new TextStyle(fontSize: 30.0),
                  textAlign: TextAlign.left,
                ),
                new Padding(padding: new EdgeInsets.only(top: 20.0)),
                new Text(
                  "1. Nomor antrian Anda",
                  style: new TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.left,
                ),
                new Padding(padding: new EdgeInsets.only(top: 20.0)),
                new Text(
                  "2. Anda Akan Dilayani pada "+ _date.day.toString()+"-" + _date.month.toString() + "-"+ _date.year.toString() +" Jam " + jamTampil,
                  style: new TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.left,
                ),
                new Padding(padding: new EdgeInsets.only(top: 20.0)),
                new Text(
                  "3. Silahkan klik ambil nomor untuk melanjutkan",
                  style: new TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.left,
                ),
                new Padding(padding: new EdgeInsets.only(top: 20.0)),
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Expanded(
                        child: new ButtonTheme(
                      height: 50.0,
                      child: new RaisedButton(
                          onPressed: _onPressed,
                          child: new Text(
                            "Simpan",
                            style: new TextStyle(fontSize: 20.0),
                          ),
                          color: btnColor,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0))),
                    ))
                  ],
                ),
                new Padding(padding: new EdgeInsets.only(top: 20.0)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

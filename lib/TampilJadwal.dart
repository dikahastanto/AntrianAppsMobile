import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:antrian_apss/Constants.dart';

class TampilJadwal extends StatefulWidget {
  @override
  _TampilJadwalState createState() => _TampilJadwalState();
}

class _TampilJadwalState extends State<TampilJadwal> {

  Future<List> getData() async {
    var url = masterurl + "alldokter";
    final respon =
    await http.get(url);
    return json.decode(respon.body);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Jadwal Dokter"),
        backgroundColor: colornew,
      ),
      backgroundColor: bgapp,
      
      body: new Column(
        children: <Widget>[
          new Expanded(
              child:  new FutureBuilder<List>(
                builder: (context, snapshot){
                  if(snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? new ItemList(
                    list: snapshot.data,
                  )
                      : new Center(
                    child: new CircularProgressIndicator(),
                  );
                },
                future: getData(),
              ),
          )
        ],
      )
    );
  }
}

class ItemList extends StatelessWidget{
  final List list;

  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return new Container(
              padding: new EdgeInsets.all(5.0),
              child: new GestureDetector(
                onTap: (){

                },
                child: new Card(
                  child: new ListTile(
                    title: new Text(list[i]['nama'],style: new TextStyle(
                      fontSize: 25.0
                    ),),
                    leading: new Icon(Icons.account_circle,size: 60.0,),
                    subtitle: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Padding(padding: new EdgeInsets.only(top: 10.0)),
                        new Row(
                          children: <Widget>[
                            new Icon(Icons.email),
                            new Padding(padding: new EdgeInsets.only(right: 10.0)),
                            new Text(list[i]['email']),
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Icon(Icons.phone),
                            new Padding(padding: new EdgeInsets.only(right: 10.0)),
                            new Text(list[i]['no_telp']),
                          ],
                        ),

                        new Row(
                          children: <Widget>[
                            new Icon(Icons.schedule),
                            new Padding(padding: new EdgeInsets.only(right: 10.0)),
                            new Text(list[i]['tgl_jaga']),
                          ],
                        ),
                        new Padding(padding: new EdgeInsets.only(bottom: 10.0)),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
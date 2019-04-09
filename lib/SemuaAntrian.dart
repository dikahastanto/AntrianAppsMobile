import 'package:flutter/material.dart';
import 'package:antrian_apss/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'TampilJadwal.dart';

class SemuaAntrian extends StatefulWidget {
  @override
  _SemuaAntrianState createState() => _SemuaAntrianState();
}

class _SemuaAntrianState extends State<SemuaAntrian> {
  Future<List> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var username = sharedPreferences.getString("username");
    var url = masterurl + "allantrianbyusername/"+ username;
    final respon =
    await http.get(url);
    return json.decode(respon.body);

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("List Antrian"),
          backgroundColor: colornew,
        ),
        backgroundColor: bgapp,

        body: new Column(
          children: <Widget>[
            new Padding(padding: new EdgeInsets.only(top: 20.0)),
            new Text("List Antrian Anda",style: new TextStyle(fontSize: 30.0),),
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

    Future<List> cancleNoAntrian(int id,String tgl) async{

    var url = masterurl+'deletnoantrian/${id}/${tgl}';
    final response = await http.delete(url);
    var result = json.decode(response.body);

    Navigator.pushReplacement(context, new MaterialPageRoute(
        builder: (BuildContext context)=>SemuaAntrian()));

    }


    void _confirmasi(int id,String tgl) {

      AlertDialog alertDialog = new AlertDialog(
        content: new Text(
          "Apakah Anda Yakin",
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
            cancleNoAntrian(id, tgl);
            },
          ),
          new RaisedButton(
            color: Colors.blueAccent,
            child: new Text(
              "Tidak",
              style: new TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );

      showDialog(context: context, child: alertDialog);
    }
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
                    title: new Text(list[i]['no_panggil'],style: new TextStyle(
                        fontSize: 35.0
                    ),),
                    subtitle: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Padding(padding: new EdgeInsets.only(top: 10.0)),
                        new Row(
                          children: <Widget>[
                            new Icon(Icons.healing),
                            new Padding(padding: new EdgeInsets.only(right: 10.0)),
                            new Text(list[i]['jenis_layanan']),
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Icon(Icons.date_range),
                            new Padding(padding: new EdgeInsets.only(right: 10.0)),
                            new Text(list[i]['tgl']),
                          ],
                        ),

                        new Row(
                          children: <Widget>[
                            new Icon(Icons.schedule),
                            new Padding(padding: new EdgeInsets.only(right: 10.0)),
                            new Text(list[i]['jam']),
                          ],
                        ),
                        new Padding(padding: new EdgeInsets.only(bottom: 10.0)),
                      ],
                    ),
                  trailing: new GestureDetector(
                    onTap: (){
                      _confirmasi(list[i]['id'],list[i]['tgl']);
                    },
                    child: new Icon(Icons.delete,size: 40.0,),
                  ),
                  ),
                ),
              ));
        });
  }

}
import 'package:flutter/material.dart';

class TabInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset("img/queue.png",scale: 10.0,),
          new Padding(padding: new EdgeInsets.only(top: 20.0)),

          new Flexible(
            child:  new Container(
                padding: new EdgeInsets.only(left: 20.0,right: 10.0),
                child: new Text("v.1.0",
                  textAlign: TextAlign.center,
                  style: new TextStyle(fontSize: 30.0),)
            ),
          ),

          new Container(
            padding: new EdgeInsets.only(left: 20.0),
            child: new Text(
              "Tentang Aplikasi",
              style: new TextStyle(fontSize: 30.0),
            ),
          ),

          new Padding(padding: new EdgeInsets.only(top:20.0)),

          new Flexible(
            child:  new Container(
                padding: new EdgeInsets.only(left: 20.0,right: 10.0),
                child: new Text("Copyright by Dika Hastanto",
                  textAlign: TextAlign.center,
                  style: new TextStyle(fontSize: 30.0),)
            ),
          ),

          new Padding(padding: new EdgeInsets.only(top:20.0)),
          new Flexible(
            child:  new Container(
                padding: new EdgeInsets.only(left: 20.0,right: 10.0),
                child: new Text("Sistem Informasi",
                  textAlign: TextAlign.center,
                  style: new TextStyle(fontSize: 20.0),)
            ),
          ),
          new Flexible(
            child:  new Container(
                padding: new EdgeInsets.only(left: 20.0,right: 10.0),
                child: new Text("Fakultas Ilmu Komputer",
                  textAlign: TextAlign.center,
                  style: new TextStyle(fontSize: 20.0),)
            ),
          ),

          new Flexible(
            child:  new Container(
                padding: new EdgeInsets.only(left: 20.0,right: 10.0),
                child: new Text("Universitas Bandar Lampung",
                  textAlign: TextAlign.center,
                  style: new TextStyle(fontSize: 20.0),)
            ),
          ),

        ],
      ),
    );
  }
}
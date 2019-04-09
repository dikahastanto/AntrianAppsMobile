import 'package:flutter/material.dart';

class TabHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(padding: new EdgeInsets.only(top:20.0)),
            new Container(
              padding: new EdgeInsets.only(left: 20.0),
              child: new Text(
                "Bantuan Aplikasi",
                style: new TextStyle(fontSize: 30.0),
              ),
            ),

            new Padding(padding: new EdgeInsets.only(top:20.0)),
            
           new Flexible(
             child:  new Container(
                 padding: new EdgeInsets.only(left: 20.0,right: 10.0),
                 child: new Text("1. Download aplikasi Antrian Apps Dari web www.antrianapps.com",
                   style: new TextStyle(fontSize: 20.0),)
             ),
           ),
            new Padding(padding: new EdgeInsets.only(top:20.0)),
            new Flexible(
              child:  new Container(
                  padding: new EdgeInsets.only(left: 20.0,right: 10.0),
                  child: new Text("2. Install aplikasi",
                    style: new TextStyle(fontSize: 20.0),)
              ),
            ),

            new Padding(padding: new EdgeInsets.only(top:20.0)),
            new Flexible(
              child:  new Container(
                  padding: new EdgeInsets.only(left: 20.0,right: 10.0),
                  child: new Text("3. Daftar akun jika anda belum mempunyai akun",
                    style: new TextStyle(fontSize: 20.0),)
              ),
            ),

            new Padding(padding: new EdgeInsets.only(top:20.0)),
            new Flexible(
              child:  new Container(
                  padding: new EdgeInsets.only(left: 20.0,right: 10.0),
                  child: new Text("4. Login pada aplikasi",
                    style: new TextStyle(fontSize: 20.0),)
              ),
            ),

            new Padding(padding: new EdgeInsets.only(top:20.0)),
            new Flexible(
              child:  new Container(
                  padding: new EdgeInsets.only(left: 20.0,right: 10.0),
                  child: new Text("5. Pilih ambil nomor",
                    style: new TextStyle(fontSize: 20.0),)
              ),
            ),

            new Padding(padding: new EdgeInsets.only(top:20.0)),
            new Flexible(
              child:  new Container(
                  padding: new EdgeInsets.only(left: 20.0,right: 10.0),
                  child: new Text("6. Cek Status untuk melihat prediksi jam",
                    style: new TextStyle(fontSize: 20.0),)
              ),
            ),

            new Padding(padding: new EdgeInsets.only(top:20.0)),
            new Flexible(
              child:  new Container(
                  padding: new EdgeInsets.only(left: 20.0,right: 10.0),
                  child: new Text("7. Mohon bijak dalam membatalkan nomor antrian",
                    style: new TextStyle(fontSize: 20.0),)
              ),
            )
          ],
        ),
    );
  }
}
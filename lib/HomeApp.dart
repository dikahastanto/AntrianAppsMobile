import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:antrian_apss/Login.dart';
import 'package:antrian_apss/Constants.dart';
import 'package:antrian_apss/Menu/tab_help.dart' as TabHelp;
import 'package:antrian_apss/Menu/tab_profile.dart' as TabProfile;
import 'package:antrian_apss/Menu/tab_home.dart' as TabHome;
import 'package:antrian_apss/Menu/tab_info.dart' as TabInfo;

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  
  String username="";
  
  TabController controller;

  void cekUser() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

     if(sharedPreferences.getBool("status") == true){
       setState(() {
         username = sharedPreferences.get('username');
//       print(username);
       });
     }else{
       Navigator.pushReplacement(context, new MaterialPageRoute(
           builder: (BuildContext context) => new Login()
       )
       );
     }


  }

  void logout() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      sharedPreferences.setString('username','');
      sharedPreferences.setString('nama_lengkap','');
      sharedPreferences.clear();
    });

    Navigator.pushReplacement(context, new MaterialPageRoute(
        builder: (BuildContext context) => new Login()
    )
    );

  }

  @override
  void initState() {
    cekUser();
    controller = new TabController(length: 4, vsync: ScaffoldState());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: new Text("Antrian Apss",style: new TextStyle(fontSize: 20.0),),
        backgroundColor: colornew,
      ),
      body: new TabBarView(
          controller: controller,
          children: <Widget>[
            new TabHome.TabHome(),
            new TabProfile.TabProfile(),
            new TabHelp.TabHelp(),
            new TabInfo.TabInfo()
          ]
      ),

      bottomNavigationBar: new Material(
        color: bottomNavigationColor,
        child: new TabBar(
          controller: controller,
            tabs: <Widget>[
              new Tab(icon: new Icon(Icons.home),),
              new Tab(icon: new Icon(Icons.account_circle),),
              new Tab(icon: new Icon(Icons.help),),
              new Tab(icon: new Icon(Icons.info),),
            ]
        )
        ,
      ),

    );
  }
}

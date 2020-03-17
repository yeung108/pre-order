import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../functions/save_logout.dart';

class BasicDrawer extends StatefulWidget {
  @override
  _BasicDrawerState createState() => _BasicDrawerState();
}

class _BasicDrawerState extends State<BasicDrawer>  {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: new EdgeInsets.all(32.0),
        child: ListView(children: <Widget>[
          ListTile(title: Text("Home", style: TextStyle(
              color: Colors.black, fontSize: 20.0),),
            onTap: () {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              Navigator.of(context).pushReplacementNamed('/HomeScreen');
            },
          ),
          ListTile(title: Text("Settings", style: TextStyle(
              color: Colors.black, fontSize: 20.0),),
            onTap: () {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              Navigator.of(context).pushReplacementNamed('/SettingScreen');
            },
          ),
          ListTile(title: Text("Logout", style: TextStyle(
              color: Colors.black, fontSize: 20.0),),
            onTap: () {
              saveLogout();
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              Navigator.of(context).pushReplacementNamed('/LoginScreen');
            },
          ),
        ],),
      ),
    );
  }
}


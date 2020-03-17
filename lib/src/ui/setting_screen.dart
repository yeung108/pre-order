import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/functions/show_dialog_single_button.dart';
import '../common/platform/platform_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/functions/set_last_screen_route.dart';
import 'package:flutter/services.dart';
import '../common/widgets/basic_drawer.dart';
import '../blocs/setting_bloc.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setLastScreenRoute("/SettingScreen");
  }

  checkConfirmedPassword(){
    if (_newPasswordController.text != _confirmNewPasswordController.text){
      showDialogSingleButton(context, "New Passwords are not the same", "Please type the same new password twice", "OK");
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
      PlatformScaffold(
        drawer: BasicDrawer(),
        appBar:  AppBar(
          title: Text("Change Password",
            style: TextStyle(fontSize: 30.0, color: Colors.black,),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),

        backgroundColor: Colors.white,

        body: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: ListView(
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
                  child: Text("Old Password", style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold, ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: TextField(
                    controller: _oldPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Your old password',
                    ),
                    obscureText: true,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.bold, ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
                  child: Text("New Password", style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold, ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: TextField(
                    controller: _newPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Your new password',
                    ),
                    obscureText: true,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.bold, ),
                  ),
                ),

                                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
                  child: Text("Confirm New Password", style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold, ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: TextField(
                    controller: _confirmNewPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Your new password',
                    ),
                    obscureText: true,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.bold, ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
                  child: Container(height: 65.0,
                    child: RaisedButton(
                        onPressed: () {
                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                          if (checkConfirmedPassword()){
                            bloc.changePassword(context, _oldPasswordController.text, _confirmNewPasswordController.text);
                          }
                        },
                        child: Text("Change Password",
                            style: TextStyle(color: Colors.white,
                                fontSize: 22.0)
                        ),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}


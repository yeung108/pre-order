import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/functions/show_dialog_single_button.dart';
import '../common/platform/platform_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import '../common/functions/set_last_screen_route.dart';
import '../blocs/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginScreenState();
  }

}

class LoginScreenState extends State<LoginScreen> {

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setLastScreenRoute("/LoginScreen");
  }

  @override
  Widget build(BuildContext context) {
    return 
      PlatformScaffold(
        appBar:  AppBar(
          title: Text("LOGIN",
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
                Container(alignment: Alignment.topCenter,
                    child: Padding(padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 15.0),
                      child: Text("TEST Pre-Order App", style: TextStyle(fontSize: 40.0, color: Colors.black),),
                    )
                ),

                Padding(padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 78.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Login to see the pre-orders from others ',
                          style: new TextStyle(fontSize: 20.0, color: Colors.black, ),
                        ),
                      ],
                    ),
                  ),
                ),


                Text("Username", style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold, ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: TextField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      hintText: "Input your User name",
                    ),
                    style: TextStyle(fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.bold, ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
                  child: Text("Password", style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold, ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Your password, keep it secret, keep it safe.',
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
                          bloc.login(context, _userNameController.text, _passwordController.text);
                        },
                        child: Text("LOGIN",
                            style: TextStyle(color: Colors.white,
                                fontSize: 22.0)
                        ),
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}


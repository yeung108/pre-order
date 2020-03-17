import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common/platform/platform_scaffold.dart';
import '../common/functions/get_last_screen_route.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() =>  _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final int splashDuration = 2;

  startTime() async {
    var lastScreenRoute;
    await getLastScreenRoute().then((result) {
      lastScreenRoute = result;
    });
    return Timer(
        Duration(seconds: splashDuration),
            () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          Navigator.of(context).pushReplacementNamed(lastScreenRoute);
        }
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    var drawer = Drawer();

    return PlatformScaffold(drawer: drawer,
        body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              children: <Widget>[
                Expanded(child:
                Container(decoration: BoxDecoration(color: Colors.black),
                  alignment: FractionalOffset(0.5, 0.3),
                  child:
                  Text("TEST Pre-Order App", style: TextStyle(fontSize: 40.0, color: Colors.white),),
                ),
                ),
                Container(margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                  child:
                  Text("© Copyright Statement 2019", style: TextStyle(fontSize: 16.0, color: Colors.white,),
                  ),
                ),
              ],
            )
        )
    );
  }
}
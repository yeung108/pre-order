import 'package:flutter/material.dart';
import 'ui/home_screen.dart';
import 'ui/splash_screen.dart';
import 'ui/login_screen.dart';
import 'ui/setting_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Splash and Token Authentication",
      debugShowCheckedModeBanner: false,
      routes: <String,WidgetBuilder>{
        "/HomeScreen": (BuildContext context) => HomeScreen(),
        "/LoginScreen": (BuildContext context) => LoginScreen(),
        "/SettingScreen": (BuildContext context) => SettingScreen(),
      },
      home:
        SplashScreen(),
    );
  }
}

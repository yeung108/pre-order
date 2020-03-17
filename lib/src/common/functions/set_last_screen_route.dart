

import 'package:shared_preferences/shared_preferences.dart';

setLastScreenRoute(String lastScreenRoute) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  await preferences.setString("LastScreenRoute", lastScreenRoute);
}
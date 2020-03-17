

import 'package:shared_preferences/shared_preferences.dart';

getLastScreenRoute() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  try {
    String getLastScreenRoute = preferences.getString("LastScreenRoute");
    if (getLastScreenRoute.length == 0){
      return '/LoginScreen';
    } else {
      return getLastScreenRoute;
    }
  } catch (err) {
    return '/LoginScreen';
  }
}
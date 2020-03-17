

import 'package:shared_preferences/shared_preferences.dart';
import 'package:corsac_jwt/corsac_jwt.dart';

getToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  String getToken = preferences.getString("LastToken");
  try {
    var decodedToken = new JWT.parse(getToken);
    var expiredTime = new DateTime.fromMillisecondsSinceEpoch(decodedToken.expiresAt * 1000);
    // print("ExpiredTime");
    // print(expiredTime);
    // print("CURRENT TIME");
    // print(new DateTime.now());
    // print("\n");
      if (new DateTime.now().isAfter(expiredTime)) {
        throw Exception("Token Expired");
      } else {
        return getToken;
      }
  } catch (err) {
    print("this is error from get token");
    throw Exception(err.toString());
  }
}
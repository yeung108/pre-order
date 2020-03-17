

import 'package:shared_preferences/shared_preferences.dart';
import '../../models/login_model.dart';

saveCurrentLogin(Map responseJson) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  // var user;
  // if ((responseJson != null && !responseJson.isEmpty)) {
  //   user = LoginModel.fromJson(responseJson).user;
  // } else {
  //   user = "";
  // }
  // print(user);
  var token = (responseJson != null && !responseJson.isEmpty) ? LoginModel.fromJson(responseJson).token : "";

  await preferences.setString('LastToken', (token != null) ? token : "");
}
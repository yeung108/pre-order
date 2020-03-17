import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../common/functions/get_token.dart';
import '../common/functions/get_header.dart';

import '../common/functions/save_current_login.dart';
import '../common/functions/get_header.dart';
import '../common/constants/api_host.dart';
import 'package:http/http.dart' show Client;

import '../models/login_model.dart';

class SettingApiProvider {
  Client client = Client();
  final url = "$API_HOST/membershipapi/test/v1.0.0/changePassword";

  Future<LoginModel> changePassword(BuildContext context, String oldPassword, String newPassword) async {
    var token;

    Map<String, String> body = {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };

    try {
      await getToken()
      .then((result) {
        token = result;
      });
      final response = await client.post(
        url,
        headers: getAuthHeader(token),
        body: json.encode(body)
      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        if (responseJson.containsKey('token')){
          print(responseJson);
          saveCurrentLogin(responseJson);
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          Navigator.of(context).pushReplacementNamed('/HomeScreen');
          return LoginModel.fromJson(responseJson);
        } else {
          throw Exception('Failed to login');
        }
      } else {
        throw Exception('Failed to login');
      }
    } on Exception catch(error) {
      print(error);
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Navigator.of(context).pushReplacementNamed('/LoginScreen');
    }
  }
}



import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../common/functions/save_logout.dart';
import '../common/constants/api_host.dart';
import '../common/functions/get_token.dart';
import '../common/functions/get_header.dart';
import 'package:http/http.dart' show Client;

import '../models/order_model.dart';

class OrderApiProvider {
  Client client = Client();
  final url = "$API_HOST/membershipapi/test/v1.0.0/getOrder";
  final getOrderStatusOptionsUrl = "$API_HOST/membershipapi/test/v1.0.0/getOrderStatusOptions";
  final changeOrderStatusUrl = "$API_HOST/membershipapi/test/v1.0.0/changeOrderStatus";

  Future<List<OrderModel>> fetchAllOrders(BuildContext context) async {
    var token;
    try {
      await getToken()
      .then((result) {
        token = result;
      });
      final response = await client.post(
        url,
        headers: getAuthHeader(token),
        body: json.encode(Map<String, String>())
      );

      if (response.statusCode == 200) {
        try {
          final responseJson = json.decode(response.body) as List;
            var orders = new List<OrderModel>();
            responseJson.forEach((s) => {
              orders.add(new OrderModel.fromJson(s))
            });
            return orders;
        } catch (err) {
          print("FAILED TO LOAD ORDER AS STATUS CODE 200");
          print(err);
        }
      } else {
        throw Exception('Failed to load orders');
      }
    } on Exception catch(error) {
      print(error);
      saveLogout();
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Navigator.of(context).pushReplacementNamed('/LoginScreen');
    }
  }

  Future<List<String>> fetchOrderStatusOptions(BuildContext context) async {
    var token;

    try {
      await getToken()
      .then((result) {
        token = result;
      });
      final response = await client.post(
        getOrderStatusOptionsUrl,
        headers: getAuthHeader(token),
        body: json.encode(Map<String, String>())
      );
      if (response.statusCode == 200) {
        try {
          final responseJson = json.decode(response.body) as List;
            var orderStatusOptions = new List<String>();
            responseJson.forEach((s) => {
              orderStatusOptions.add(s.toString())
            });
            return orderStatusOptions;
        } catch (err) {
          print(err);
        }
      } else {
        throw Exception('Failed to load orderStatusOptions');
      }
    } on Exception catch(error) {
      print(error);
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Navigator.of(context).pushReplacementNamed('/LoginScreen');
    }
  }

  Future<bool> changeOrderStatus(BuildContext context, String orderId, String status) async {
    var token;
    try {
      await getToken()
      .then((result) {
        token = result;
      });

      Map<String, String> body = {
          'id': orderId,
          'status': status
      };

      final response = await client.post(
        changeOrderStatusUrl,
        headers: getAuthHeader(token),
        body: json.encode(body)
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to change order status');
      }
    } on Exception catch(error) {
      print(error);
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Navigator.of(context).pushReplacementNamed('/LoginScreen');
    }
  }
}



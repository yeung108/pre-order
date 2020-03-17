import 'dart:async';
import '../models/login_model.dart';
import 'login_api_provider.dart';
import 'order_api_provider.dart';
import 'setting_api_provider.dart';
import '../models/order_model.dart';
import 'package:flutter/material.dart';

class Repository {
  final ordersApiProvider = OrderApiProvider();
  final loginApiProvider = LoginApiProvider();
  final settingApiProvider = SettingApiProvider();

  Future<LoginModel> changePassword(BuildContext context, String oldPassword, String newPassword) => settingApiProvider.changePassword(context, oldPassword, newPassword);

  Future<LoginModel> login(BuildContext context, String username, String password) => loginApiProvider.login(context, username, password);

  Future<List<OrderModel>> fetchAllOrders(BuildContext context) => ordersApiProvider.fetchAllOrders(context);

  Future<List<String>> fetchOrderStatusOptions(BuildContext context) => ordersApiProvider.fetchOrderStatusOptions(context);

  Future<bool> changeOrderStatus(BuildContext context, String orderId, String status) => ordersApiProvider.changeOrderStatus(context, orderId, status);

}

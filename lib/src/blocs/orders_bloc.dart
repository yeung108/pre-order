import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/order_model.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
class OrdersBloc {
  final _repository = Repository();
  final _ordersFetcher = PublishSubject<List<OrderModel>>();
  final _ordersStatusOptionsFetcher = PublishSubject<List<String>>();

  Observable
    <Tuple2
      <List<OrderModel>, List<String>
    >
  > get allOrdersAndStatusOptions => Observable.combineLatest2(_ordersFetcher.stream, _ordersStatusOptionsFetcher.stream, (orders, options) => Tuple2<List<OrderModel>, List<String>>(orders, options));

  fetchAllOrders(BuildContext context) async {
    List<OrderModel> orderModels = await _repository.fetchAllOrders(context);
    _ordersFetcher.sink.add(orderModels);
  }

  fetchOrderStatusOptions(BuildContext context) async {
    List<String> orderStatusOptions = await _repository.fetchOrderStatusOptions(context);
    _ordersStatusOptionsFetcher.sink.add(orderStatusOptions);
  }

  changeOrderStatus(BuildContext context, String orderId, String status) async {
    bool result = await _repository.changeOrderStatus(context, orderId, status);
    await this.fetchAllOrders(context);
  }

  dispose() {
    _ordersFetcher.close();
    _ordersStatusOptionsFetcher.close();
  }
}

final bloc = OrdersBloc();

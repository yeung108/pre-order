import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../blocs/orders_bloc.dart';
import 'package:flutter/services.dart';
import '../common/class/hex_color.dart';
import '../common/widgets/basic_drawer.dart';
import '../common/platform/platform_scaffold.dart';
import '../common/functions/set_last_screen_route.dart';
import '../common/functions/show_dialog_confirm_button.dart';
import '../common/widgets/multi_select_chip.dart';
import 'package:tuple/tuple.dart';
import 'dart:ui';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  TextEditingController editingController = TextEditingController();
  OrdersBloc bloc = new OrdersBloc();
  String searchText = "";
  Timer timer;
  DateTime lastFetchTime = DateTime.now();
  List<String> filteredStatusList = OrderStatusFilteringOptions;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIOverlays ([]);
    setLastScreenRoute("/HomeScreen");
    new Future.delayed(Duration.zero,() {
      // Fetch for every 5 seconds
      timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
        setState(() {
          lastFetchTime = DateTime.now();
        });
        bloc.fetchAllOrders(context);
        bloc.fetchOrderStatusOptions(context);
      });
    });
  }

  @override
  void dispose() {
    bloc.dispose();
    timer.cancel();
    super.dispose();
  }

  _buildExpandableContent(String orderId, OrderProductList orderProductList, List<String> allOrderStatusOptions) {
    List<Widget> columnContent = [];
    List<Widget> orderStatusOptionsButtonBar = [];

    for (OrderProduct content in orderProductList.orderProducts){
      columnContent.add(
        new ListTile(
          title: new Text(content.productName, style: new TextStyle(fontSize: 18.0),),
          subtitle: new Text(content.quantity.toString(), style: new TextStyle(fontSize: 18.0),),
        )
      );
    }

    for (String option in allOrderStatusOptions){
      orderStatusOptionsButtonBar.add(
        new FlatButton(
          child: FittedBox(
            fit:BoxFit.fitWidth, 
            child: Text(option)
          ),
          // new Text(option, style: TextStyle(fontSize: 22.0)),
          onPressed: () async {
            if (OrderStatusShowConfirmDialogue.contains(option)){
              ConfirmAction action = await ShowDialogConfirmButton(context);
              if (action == ConfirmAction.ACCEPT){
                bloc.changeOrderStatus(context, orderId, option);
              }
            } else{
              bloc.changeOrderStatus(context, orderId, option);
            }
          },
          color: HexColor(OrderStatusColor[option])
        ),
      );
    }

    columnContent.add(
      new ButtonBar(
        mainAxisSize: MainAxisSize.max, // this will take space as minimum as posible(to center)
        children: orderStatusOptionsButtonBar,
      ),
    );

    return columnContent;
  }

  @override
  Widget build(BuildContext context) {

    return PlatformScaffold(
          drawer: BasicDrawer(),
          appBar: AppBar(
            // leading: Icon(Icons.search),
            title: 
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                    keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                    controller: editingController,
                    decoration: InputDecoration(
                        labelText: "Search by ticket no",
                        hintText: "Search by ticket no",
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                  )
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Last Fetched: ${lastFetchTime.hour.toString().padLeft(2, '0')}:${lastFetchTime.minute.toString().padLeft(2, '0')}:${lastFetchTime.second.toString().padLeft(2, '0')} ", style: TextStyle(fontSize: 12.0))
                ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
              stream: bloc.allOrdersAndStatusOptions,
              builder: (context, AsyncSnapshot<Tuple2<List<OrderModel>, List<String>>> allOrdersAndStatusOptions) {
                if (allOrdersAndStatusOptions.hasData) {
                  return buildList(allOrdersAndStatusOptions.data.item1, allOrdersAndStatusOptions.data.item2);
                } else if (allOrdersAndStatusOptions.hasError) {
                  return Text(allOrdersAndStatusOptions.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            )
          ),
          bottomNavigationBar: BottomAppBar(
            child: 
              MultiSelectChip(
                OrderStatusFilteringOptions,
                onSelectionChanged: (selectedList) {
                  setState(() {
                    filteredStatusList = selectedList;
                  });
                },
              )
          ),
    );
  }

  Widget buildList(List<OrderModel> allOrders, List<String> orderStatusOptions) {
    List<OrderModel> content;
    if (allOrders != null){
      content = allOrders
      .where(
        (info) => 
        info.ticketNo.toString().trim().substring(0, searchText.length).contains(searchText.trim()) && 
        (filteredStatusList.contains(info.orderStatus)) 
      )
      .toList();
    } else {
      content = [];
    }

    return new ListView.builder(
      itemCount: content.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, position) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ExpansionTile(
                title: Text(
                  "${content[position].ticketNo.toString()} - ${content[position].orderStatus} (  ${content[position].remarks} ) ", 
                style: TextStyle(
                  fontSize: 22.0, 
                  color: HexColor(OrderStatusColor[content[position].orderStatus])
                )
                ),
                children: <Widget>[
                  new Column(
                    children: _buildExpandableContent(content[position].id, content[position].orderProducts, orderStatusOptions), 
                  ),
                ],
              )
            ]
          )
        );
      }
    );
  }
}

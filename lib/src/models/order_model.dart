class OrderModel {
  final String id;
  final String orderStatus;
  final DateTime createdAt;
  final double price;
  final String remarks;
  final String storeCode;
  final int ticketNo;
  final OrderProductList orderProducts;

  OrderModel(this.id, this.orderStatus, this.createdAt, this.price, this.remarks, this.storeCode, this.ticketNo, this.orderProducts);

  OrderModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        orderStatus = json['orderStatus'],
        createdAt = DateTime.parse(json['createdAt']).toLocal(),
        price = json['price'].toDouble(),
        remarks = json['remarks'],
        storeCode = json['storeCode'],
        ticketNo = json['ticketNo'],
        orderProducts = OrderProductList.fromJson(json['orderProducts']);

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'orderStatus': orderStatus,
      'createdAt': createdAt,
      'price': price,
      'remarks': remarks,
      'storeCode': storeCode,
      'ticketNo': ticketNo,
      'orderProducts':orderProducts
    };
}

class OrderProductList {
  final List<OrderProduct> orderProducts;

  OrderProductList({
    this.orderProducts,
  });

  factory OrderProductList.fromJson(List<dynamic> json) {

    List<OrderProduct> orderProducts = new List<OrderProduct>();
    orderProducts = json.map((i)=>OrderProduct.fromJson(i)).toList();

    return new OrderProductList(
      orderProducts: orderProducts
    );
  }
}

class OrderProduct {
  final String aisleNumber;
  final String id;
  final double price;
  final String productCode;
  final String productName;
  final int quantity;
 
  OrderProduct(this.aisleNumber, this.id, this.price, this.productCode, this.productName, this.quantity);

  OrderProduct.fromJson(Map<String, dynamic> json)
    : aisleNumber = json['aisleNumber'],
      id = json['id'],
      price = json['price'].toDouble(),
      productCode = json['productCode'],
      productName = json['productName'],
      quantity = json['quantity'];

  Map<String, dynamic> toJson() =>
    {
      'aisleNumber': aisleNumber,
      'id': id,
      'price': price,
      'productCode': productCode,
      'productName': productName,
      'quantity': quantity
    };
}

const OrderStatusColor = {
  'pending':'#8A2BE2', 
  'preparing':'#20639B', 
  'cancelled':'#3CAEA3', 
  'ready':'#F6D55C', 
  'delivered':'#ED553B'
};

const OrderStatusShowConfirmDialogue = ['cancelled', 'delivered'];
const OrderStatusFilteringOptions = ['pending', 'preparing', 'ready', 'cancelled'];

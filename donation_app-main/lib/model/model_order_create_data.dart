import 'dart:convert';

ModelOrderCreateData modelOrderCreateDataFromJson(String str) => ModelOrderCreateData.fromJson(json.decode(str));
String modelOrderCreateDataToJson(ModelOrderCreateData data) => json.encode(data.toJson());

class ModelOrderCreateData {
  ModelOrderCreateData({
    this.transaction,
    this.redirectUrl,
  });

  ModelOrderCreateData.fromJson(dynamic json) {
    transaction = json['transaction'] != null ? Transaction.fromJson(json['transaction']) : null;
    redirectUrl = json['redirect_url'];
  }
  Transaction? transaction;
  String? redirectUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (transaction != null) {
      map['transaction'] = transaction?.toJson();
    }
    map['redirect_url'] = redirectUrl;
    return map;
  }
}

Transaction transactionFromJson(String str) => Transaction.fromJson(json.decode(str));
String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  Transaction({
    this.trackId,
    this.amount,
    this.status,
    this.orderRequest,
    this.cartData,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Transaction.fromJson(dynamic json) {
    trackId = json['trackId'];
    amount = json['amount'];
    status = json['status'];
    orderRequest = json['order_request'];
    cartData = json['cart_data'] != null ? CartData.fromJson(json['cart_data']) : null;
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  String? trackId;
  String? amount;
  String? status;
  String? orderRequest;
  CartData? cartData;
  String? updatedAt;
  String? createdAt;
  num? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['trackId'] = trackId;
    map['amount'] = amount;
    map['status'] = status;
    map['order_request'] = orderRequest;
    if (cartData != null) {
      map['cart_data'] = cartData?.toJson();
    }
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }
}

CartData cartDataFromJson(String str) => CartData.fromJson(json.decode(str));
String cartDataToJson(CartData data) => json.encode(data.toJson());

class CartData {
  CartData({
    this.mosqueName,
    this.mosqueAddress,
    this.subTotal,
    this.paymentMethod,
    this.total,
    this.receiverName,
    this.quantity,
  });

  CartData.fromJson(dynamic json) {
    mosqueName = json['mosque_name'];
    mosqueAddress = json['mosque_address'];
    subTotal = json['sub_total'];
    paymentMethod = json['payment_method'];
    total = json['total'];
    receiverName = json['receiver_name'];
    quantity = json['quantity'];
  }
  String? mosqueName;
  String? mosqueAddress;
  String? subTotal;
  String? paymentMethod;
  String? total;
  String? receiverName;
  String? quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mosque_name'] = mosqueName;
    map['mosque_address'] = mosqueAddress;
    map['sub_total'] = subTotal;
    map['payment_method'] = paymentMethod;
    map['total'] = total;
    map['receiver_name'] = receiverName;
    map['quantity'] = quantity;
    return map;
  }
}

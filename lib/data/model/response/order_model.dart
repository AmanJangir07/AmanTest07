import 'package:shopiana/data/model/response/cart_model.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/data/model/response/user_profile.dart';

class OrderModel {
  int? totalPages;
  int? number;
  int? recordsTotal;
  int? recordsFiltered;
  List<Order>? orders;

  OrderModel({
    int? totalPages,
    int? number,
    int? recordsTotal,
    int? recordsFiltered,
    List<Order>? orders,
  }) {
    this.totalPages = totalPages;
    this.number = number;
    this.recordsTotal = recordsTotal;
    this.recordsFiltered = recordsFiltered;
    this.orders = orders;
  }

  OrderModel.fromJson(Map<String, dynamic> json) {
    totalPages = json['totalPages'];
    number = json['number'];
    recordsTotal = json['recordsTotal'];
    recordsFiltered = json['recordsFiltered'];
    orders = (json['orders'] as List<dynamic>)
        .map((order) => Order.fromJson(order))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPages'] = this.totalPages;
    data['number'] = this.number;
    data['recordsTotal'] = this.recordsTotal;
    data['recordsFiltered'] = this.recordsFiltered;
    data['orders'] = this.orders;
    return data;
  }
}

class Order {
  int? id;
  List<Totals>? totals;
  List? attirbutes;
  String? paymentType;
  String? paymentModule;
  String? shippingModule;
  String? previousOrderStatus;
  String? orderStatus;
  String? creditCard;
  dynamic datePurchased;
  String? datePurchasedSimple;
  String? currency;
  bool? customerAgreed;
  bool? confirmedAddress;
  String? comments;
  UserProfile? customer;
  List<OrderProduct>? products;
  String? currencyModel;
  UserBilling? billing;
  UserDelivery? delivery;
  dynamic store;
  int? productItemCount;
  String? customerGstNumber;
  Totals? total;
  dynamic tax;
  dynamic shipping;

  Order({
    this.id,
    this.totals,
    this.attirbutes,
    this.paymentType,
    this.paymentModule,
    this.shippingModule,
    this.customerGstNumber,
    this.previousOrderStatus,
    this.orderStatus,
    this.creditCard,
    this.datePurchased,
    this.datePurchasedSimple,
    this.currency,
    this.customerAgreed,
    this.confirmedAddress,
    this.comments,
    this.customer,
    this.products,
    this.currencyModel,
    this.billing,
    this.delivery,
    this.store,
    this.productItemCount,
    this.total,
    this.tax,
    this.shipping,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totals = (json['totals'] as List<dynamic>?)
            ?.map((total) => Totals.fromJson(total))
            .toList() ??
        [];
    attirbutes = json['attirbutes'];
    paymentType = json['paymentType'];
    shippingModule = json['shippingModule'];
    previousOrderStatus = json['previousOrderStatus'];
    orderStatus = json['orderStatus'];
    creditCard = json['creditCard'];
    datePurchased = json['datePurchased'];
    datePurchasedSimple = json['datePurchasedSimple'];
    currency = json['currency'];
    customerGstNumber = json['customerGstNumber'];
    customerAgreed = json['customerAgreed'];
    confirmedAddress = json['confirmedAddress'];
    comments = json['comments'];
    customer = UserProfile.fromJson(json['customer']);
    products = (json['products'] as List<dynamic>)
        .map((product) => OrderProduct.fromJson(product))
        .toList();
    currencyModel = json['currencyModel'];
    billing = UserBilling.fromJson(json['billing']);
    delivery = UserDelivery.fromJson(json['delivery']);
    store = json['store'];
    productItemCount = json['productItemCount'];
    total = Totals.fromJson(json['total']);
    tax = json['tax'];
    shipping = json['shipping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['totals'] = this.totals;
    data['attirbutes'] = this.attirbutes;
    data['paymentType'] = this.paymentType;
    data['shippingModule'] = this.shippingModule;
    data['previousOrderStatus'] = this.previousOrderStatus;
    data['orderStatus'] = this.orderStatus;
    data['creditCard'] = this.creditCard;
    data['datePurchased'] = this.datePurchased;
    data['datePurchasedSimple'] = this.datePurchasedSimple;
    data['currency'] = this.currency;
    data['customerAgreed'] = this.customerAgreed;
    data['confirmedAddress'] = this.confirmedAddress;
    data['comments'] = this.comments;
    data['customer'] = this.customer;
    data['products'] = this.products;
    data['customerGstNumber'] = this.customerGstNumber;
    data['currencyModel'] = this.currencyModel;
    data['billing'] = this.billing;
    data['delivery'] = this.delivery;
    data['store'] = this.store;
    data['productItemCount'] = this.productItemCount;
    data['total'] = this.total;
    data['tax'] = this.tax;
    data['shipping'] = this.shipping;
    return data;
  }
}

class OrderProduct {
  int? id;
  int? orderedQuantity;
  Product? product;
  String? productName;
  String? price;
  String? subTotal;
  List<dynamic>? attributes;
  String? sku;
  String? image;

  OrderProduct(
      {this.id,
      this.orderedQuantity,
      this.product,
      this.productName,
      this.price,
      this.subTotal,
      this.attributes,
      this.image,
      this.sku});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderedQuantity'] = this.orderedQuantity;
    data['product'] = this.product;
    data['productName'] = this.productName;
    data['price'] = this.price;
    data['subTotal'] = this.subTotal;
    data['attributes'] = this.attributes;
    data['sku'] = this.sku;
    data['image'] = this.image;

    return data;
  }

  OrderProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderedQuantity = json['orderedQuantity'];
    product = Product.fromJson(json['product']);

    productName = json['productName'];
    price = json['price'];
    subTotal = json['subTotal'];
    attributes = json['attributes'];
    sku = json['sku'];
    image = json['image'];
  }
}

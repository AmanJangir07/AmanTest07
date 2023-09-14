import 'package:shopiana/data/model/response/cart_model.dart';
import 'package:shopiana/data/model/response/order_model.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/data/model/response/user_info_model.dart';

class OrderCheckoutResponse {
  UserBilling? billing;
  UserDelivery? delivery;
  int? id;
  String? payment;
  List<OrderProduct>? products;

  String? shipping;
  OrderTotals? orderTotals;

  OrderCheckoutResponse({
    this.billing,
    this.delivery,
    this.id,
    this.payment,
    this.products,
    this.shipping,
    this.orderTotals,
  });

  Map toJson() => {
        "billing": billing,
        "delivery": delivery,
        "id": id,
        "payment": payment,
        "products": products,
        "shipping": shipping,
        "codTotals": orderTotals
      };

  factory OrderCheckoutResponse.fromJson(Map<String, dynamic> json) {
    return OrderCheckoutResponse(
      billing: UserBilling.fromJson(json['billing']),
      delivery: UserDelivery.fromJson(json['delivery']),
      id: json['id'],
      payment: json['payment'],
      products: (json['products'] as List<dynamic>)
          .map((product) => OrderProduct.fromJson(product))
          .toList(),
      shipping: json['shipping'],
      orderTotals: OrderTotals.fromJson(
        json['total'],
      ),
    );
  }
}

class OrderTotals {
  List<Totals>? totals;
  dynamic grandTotal;

  OrderTotals({
    this.totals,
    this.grandTotal,
  });

  Map toJson() => {
        "totals": totals,
        "grandTotal": grandTotal,
      };

  factory OrderTotals.fromJson(Map<String, dynamic> json) {
    return OrderTotals(
        totals: (json['totals'] as List<dynamic>)
            .map(
              (total) => Totals.fromJson(total),
            )
            .toList(),
        //  Totals.fromJson(json['totals']),
        grandTotal: json['grandTotal']);
  }
}

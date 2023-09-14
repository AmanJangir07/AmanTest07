import 'package:shopiana/data/model/response/cart_model.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/data/model/response/user_profile.dart';

class CheckoutOrderPayment {
  int? id;
  UserBilling? billing;
  UserDelivery? delivery;
  String? payment;
  Totals? total;
  List<Product>? products;
}

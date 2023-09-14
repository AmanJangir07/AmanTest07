import 'package:flutter/foundation.dart';
import 'package:shopiana/data/model/response/order_model.dart';
import 'package:shopiana/data/model/response/shipping_calculation_model.dart';
import 'package:shopiana/data/model/response/shipping_method_model.dart';
import 'package:shopiana/data/model/response/shipping_model.dart';
import 'package:shopiana/helper/api_base_helper.dart';

class OrderRepo {
  final ApiBaseHelper? apiBaseHelper;

  OrderRepo({required this.apiBaseHelper, Object? sharedPreferences});

  Future<OrderModel> getOrders({required String url, String? token}) async {
    OrderModel ordersData;
    final response = await apiBaseHelper!.get(url: url, token: token);
    ordersData = OrderModel.fromJson(response);
    return ordersData;
  }

  Future<ShippingCalculation> getAuthShippingCalculation(
      {required String url, String? token}) async {
    ShippingCalculation shippingCalculation;
    final response = await apiBaseHelper!.get(url: url, token: token);
    shippingCalculation = ShippingCalculation.fromJson(response);
    return shippingCalculation;
  }

  Future<ShippingTotal> getAuthShippingTotal({required String url, String? token}) async {
    ShippingTotal shippingTotal;
    final response = await apiBaseHelper!.get(url: url, token: token);
    shippingTotal = ShippingTotal.fromJson(response);
    return shippingTotal;
  }

  Future<ShippingCalculation> createShippingCalculation(
      {required String url, dynamic body}) async {
    ShippingCalculation shippingCalculation;
    final response = await apiBaseHelper!.post(url, body, "");
    shippingCalculation = ShippingCalculation.fromJson(response);
    return shippingCalculation;
  }

  Future<ShippingTotal> getShippingTotal({required String url, String? token}) async {
    ShippingTotal shippingTotal;
    final response = await apiBaseHelper!.get(url: url, token: token);
    shippingTotal = ShippingTotal.fromJson(response);
    return shippingTotal;
  }

  Future<void> updateStatus({required String url, String? token, Object? body}) async {
    try {
      await apiBaseHelper!.patch(body: body, token: token, url: url);
    } on Exception catch (e) {}
  }

  Future<OrderModel?> getOrderListByOrderStatus(
      {required String url, String? token}) async {
    OrderModel? ordersData;
    try {
      final response = await apiBaseHelper!.get(url: url, token: token);
      ordersData = OrderModel.fromJson(response);
    } on Exception catch (e) {}
    return ordersData;
  }

  List<ShippingMethodModel> getShippingList() {
    List<ShippingMethodModel> shippingMethodList = [
      ShippingMethodModel(
          id: 1, title: 'Currier', cost: '20', duration: '2-3 days'),
      ShippingMethodModel(
          id: 2, title: 'Company Vehicle', cost: '10', duration: '8-10 days'),
    ];
    return shippingMethodList;
  }
}

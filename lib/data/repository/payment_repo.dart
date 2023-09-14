import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/checkout_defination_model.dart';
import 'package:shopiana/data/model/response/init_order_model.dart';
import 'package:shopiana/data/model/response/order_checkout_response.dart';
import 'package:shopiana/data/model/response/payment_module.dart';
import 'package:shopiana/helper/api.dart';
import 'package:shopiana/helper/api_base_helper.dart';

class PaymentRepo {
  final ApiBaseHelper? apiBaseHelper;

  PaymentRepo({required this.apiBaseHelper});

  Future<OrderCheckoutResponse?> codPayment(
      String url, dynamic data, String token) async {
    OrderCheckoutResponse? orderSummary;
    try {
      final response = await apiBaseHelper!.post(url, data, token);
      orderSummary = OrderCheckoutResponse.fromJson(response);
      return orderSummary;
    } on Exception catch (e) {
      print(e);
    }
    return orderSummary;
  }

  Future<List<PaymentModule>> getPaymentModules() async {
    var url = API.getPaymentModules();
    List<PaymentModule> paymentModules = [];
    try {
      var response = await apiBaseHelper!.get(url: url);
      response = response as List<dynamic>?;
      response!.forEach((module) {
        PaymentModule paymentModule = PaymentModule.fromJson(module);
        paymentModules.add(paymentModule);
      });
    } on Exception catch (e) {}
    return paymentModules;
  }

  Future<InitOrder?> initOnlineOrder(
      String cartId, dynamic data, String url, String token) async {
    InitOrder? initOrder;
    print("initonlinorder params" + data.toString());
    try {
      var response = await apiBaseHelper!.post(url, data, token);
      initOrder = InitOrder.fromJson(response);
      print("response of initOnlineOrder" + response.toString());
    } on Exception catch (e) {
      print("Exception is: " + e.toString());
    }
    return initOrder;
  }

  Future<OrderCheckoutResponse?> orderCheckout(
      {dynamic data, required String url, String? token}) async {
    OrderCheckoutResponse? checkoutResponse;
    try {
      var response = await apiBaseHelper!.post(url, data, token);
      checkoutResponse = OrderCheckoutResponse.fromJson(response);
    } on Exception catch (e) {}
    return checkoutResponse;
  }

  Future onlinePayment() async {}

  Future<CheckoutDefinationModel?> createAuthOrderDefination(
      String url, Object? data, String token,
      {BuildContext? context}) async {
    print("urls is" + url);
    CheckoutDefinationModel? checkoutDefinationResponse;
    // Object dataNew = {"amount": "39.0", "currency": "INR"};
    try {
      var response =
          await apiBaseHelper!.post(url, data, token, context: context);
      checkoutDefinationResponse = CheckoutDefinationModel.fromJson(response);
    } on Exception catch (e) {
      print("error is: " + e.toString());
    }
    return checkoutDefinationResponse;
  }

  Future<OrderCheckoutResponse?> checkoutOrderPayment(
      String url, Object? data) async {
    dynamic response;
    OrderCheckoutResponse? orderSummery;
    response = await apiBaseHelper!.post(url, data, '');
    if (response != null) {
      orderSummery = OrderCheckoutResponse.fromJson(response);
    }
    return orderSummery;
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shopiana/data/model/body/order_place_model.dart';
import 'package:shopiana/data/model/response/cart_model.dart';
import 'package:shopiana/data/model/response/order_details.dart';
import 'package:shopiana/data/model/response/order_model.dart';
import 'package:shopiana/data/model/response/shipping_calculation_model.dart';
import 'package:shopiana/data/model/response/shipping_method_model.dart';
import 'package:shopiana/data/model/response/shipping_model.dart';
import 'package:shopiana/data/repository/auth_repo.dart';
import 'package:shopiana/data/repository/order_repo.dart';
import 'package:shopiana/helper/api.dart';
import 'package:shopiana/helper/app_exception.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/snackbar.dart';

class OrderProvider with ChangeNotifier {
  final AuthRepo? authRepo;
  final OrderRepo? orderRepo;

  OrderProvider({required this.orderRepo, required this.authRepo});

  // List<OrderModel> _pendingList;
  // List<OrderModel> _deliveredList;
  // List<OrderModel> _canceledList;
  // List<Order> _orderList;

  int? _addressIndex;
  int? _shippingIndex;
  bool _isLoading = false;
  int? totalPages = 0;
  int? totalOrders = 0;
  int? shippingQuoteId = 0;
  List<ShippingMethodModel>? _shippingList;
  // List<OrderModel> get pendingList => _pendingList;
  // List<OrderModel> get deliveredList => _deliveredList;
  // List<OrderModel> get canceledList => _canceledList;
  // List<Order> get orderlist => _orderList;

  int? get addressIndex => _addressIndex;
  int? get shippingIndex => _shippingIndex;
  bool get isLoading => _isLoading;
  List<ShippingMethodModel>? get shippingList => _shippingList;
  List<Order>? _orders = [];
  get orders => this._orders;

  set orders(value) => this._orders = value;
  List<Order> _pendingOrder = [];
  List<Order> get pendingOrder => _pendingOrder;
  List<Order> _cancelOrder = [];
  List<Order> get cancelOrder => _cancelOrder;
  List<Order> _deliverOrder = [];
  List<Order> get deliverOrder => _deliverOrder;

  void initOrderList() async {
    notifyListeners();
  }

  int _orderTypeIndex = 0;
  int get orderTypeIndex => _orderTypeIndex;

  void setIndex(int index) {
    _orderTypeIndex = index;
    notifyListeners();
  }

  List<OrderDetailsModel>? _orderDetails;
  List<OrderDetailsModel>? get orderDetails => _orderDetails;

  ShippingTotal? shippingTotal;
  ShippingTotal? get getShippingTotal => this.shippingTotal;

  set setShippingTotal(ShippingTotal shippingTotal) =>
      this.shippingTotal = shippingTotal;

  ShippingCalculation? shippingCalculation;
  ShippingCalculation? get getShippingCalculation => this.shippingCalculation;

  set setShippingCalculation(ShippingCalculation shippingCalculation) =>
      this.shippingCalculation = shippingCalculation;

  Future<OrderModel?> getOrderDetailsByOrderStatus(
      {required String orderStatus}) async {
    _pendingOrder.clear();
    _cancelOrder.clear();
    _deliverOrder.clear();
    _orders!.clear();
    // bool isLoggedIn = authRepo.isLoggedIn();
    // this._orderList = [];
    String usertoken = authRepo!.getUserToken();
    final url = API.getOrdersByStatus(orderStatus);
    OrderModel? orderResponse;
    // if (isLoggedIn && usertoken.isNotEmpty) {
    orderResponse =
        await orderRepo!.getOrderListByOrderStatus(url: url, token: usertoken);
    print("order response" + jsonEncode(orderResponse.toString()));
    if (orderResponse != null && orderResponse.orders != null) {
      _orders = orderResponse.orders;
      // switch (orderStatus) {
      //   case Constants.PROCESSED:
      //     _pendingOrder = orderResponse.orders;
      //     break;
      //   case Constants.DELIVERED:
      //     _deliverOrder = orderResponse.orders;
      //     break;
      //   case Constants.CANCELED:
      //     _cancelOrder = orderResponse.orders;
      //     break;
      //   default:
      // }
      // this._orderList = orderResponse.orders;
      // notifyListeners();
    }
    // }
    notifyListeners();
    return orderResponse;
  }

  Future<void> getOrders(
      {int? pageNumber,
      int? count,
      String? orderStatus,
      required BuildContext context}) async {
    try {
      if (pageNumber == 0) {
        _orders!.clear();
      }
      if ((totalPages == 0) || pageNumber! <= totalPages!) {
        String usertoken = authRepo!.getUserToken();
        final url = API.getOrders(
            count: count.toString(),
            orderStatus: orderStatus,
            pageNumber: pageNumber.toString());
        OrderModel orderResponse;
        orderResponse = await orderRepo!.getOrders(url: url, token: usertoken);
        print("order response" + jsonEncode(orderResponse.toString()));
        if (orderResponse != null && orderResponse.orders != null) {
          if (_orders == null || _orders!.length == 0) {
            totalPages = orderResponse.totalPages;
            totalOrders = orderResponse.recordsTotal;
          }
          orderResponse.orders!.forEach((element) {
            _orders!.add(element);
          });
        }
      }
    } on AppException catch (e) {
      showErrorSnackbar(context, e.message!);
    }
    notifyListeners();
  }

  Future<void> placeOrder(OrderPlaceModel orderPlaceModel, Function callback,
      List<CartModel> cartList) async {
    _addressIndex = null;
    callback(true, 'Order placed successfully', cartList);
    notifyListeners();
  }

  Future<void> updateOrder(int? orderId) async {
    final url = API.updateOrder(orderId);
    final token = authRepo!.getUserToken();
    var body = {"status": "CANCELED"};
    await orderRepo!.updateStatus(
      url: url,
      body: body,
      token: token,
    );
    notifyListeners();
  }

  Future<void> getAuthShippingCalculation(String? cartCode) async {
    final shippingUrl = API.getAuthShippingCalculation(cartCode);
    final token = authRepo!.getUserToken();

    try {
      shippingCalculation = await orderRepo!.getAuthShippingCalculation(
        url: shippingUrl,
        token: token,
      );
      notifyListeners();
      if ((shippingCalculation != null) &&
          shippingCalculation!.shippingQuote!) {
        shippingQuoteId =
            shippingCalculation!.shippingOptions!.first.shippingQuoteOptionId;
      }
      final calculationUrl =
          API.orderTotalCalculation(cartCode, shippingQuoteId);
      shippingTotal = await orderRepo!.getAuthShippingTotal(
          url: calculationUrl, token: token);
      notifyListeners();
    } on AppException catch (e) {}
    notifyListeners();
  }

  Future<void> createShippingCalculation(String? cartCode) async {
    final shippingUrl = API.getShippingCalculation(cartCode);
    try {
      final body = {"countryCode": "IN", "postalCode": "303702"};
      shippingCalculation = await orderRepo!.createShippingCalculation(
          url: shippingUrl, body: body);
      notifyListeners();
      if (shippingCalculation != null) {
        final calculationUrl = API.orderTotalCalculation(cartCode,
            shippingCalculation!.shippingOptions!.first.shippingQuoteOptionId);
        shippingTotal = await orderRepo!.getShippingTotal(url: calculationUrl);
        notifyListeners();
      }
    } on AppException catch (e) {}
    notifyListeners();
  }

  void setAddressIndex(int index) {
    _addressIndex = index;
    notifyListeners();
  }

  void initShippingList() async {
    _shippingList = [];
    orderRepo!
        .getShippingList()
        .forEach((shippingMethod) => _shippingList!.add(shippingMethod));
    notifyListeners();
  }

  void setSelectedShippingAddress(int? index) {
    _shippingIndex = index;
    notifyListeners();
  }
}

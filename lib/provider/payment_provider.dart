import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/data/model/persistable/order_defination.dart';
import 'package:shopiana/data/model/response/cart_model.dart';
import 'package:shopiana/data/model/response/checkout_defination_model.dart';
import 'package:shopiana/data/model/response/init_order_model.dart';
import 'package:shopiana/data/model/response/order_checkout_response.dart';
import 'package:shopiana/data/model/response/payment_module.dart';
import 'package:shopiana/data/model/response/user_info_model.dart';
import 'package:shopiana/data/model/response/user_profile.dart';
import 'package:shopiana/data/repository/auth_repo.dart';
import 'package:shopiana/data/repository/cart_repo.dart';
import 'package:shopiana/data/repository/payment_repo.dart';
import 'package:shopiana/helper/api.dart';
import 'package:shopiana/provider/profile_provider.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/string_resources.dart';
import 'package:shopiana/view/screen/orderStatus/order_failure_screen.dart';

class PaymentProvider extends ChangeNotifier {
  PaymentRepo? paymentRepo;
  AuthRepo? authRepo;
  CartRepo? cartRepo;
  PaymentProvider(
      {required this.paymentRepo,
      required this.authRepo,
      required this.cartRepo});
  List<PaymentModule> paymentModules = [];
  InitOrder? _initOrder;
  InitOrder? get initOrder => _initOrder;
  OrderCheckoutResponse? orderSummaryDetails;

  void orderCheckoutFinal({
    dynamic data,
    String? paymentMode,
    Function? orderSuccessCallback,
    Function? orderFailureCallback,
  }) async {
    try {
      print("order checkout");
      print(data);
      // get user token
      String userToken = authRepo!.getUserToken();
      bool isLoggedIn = authRepo!.isLoggedIn();
      var url = '';
      String cartCode = cartRepo!.getCartCode();

      if (paymentMode == Strings.COD) {
        // auth user cod order confirmation
        if (userToken.isNotEmpty && authRepo!.isLoggedIn()) {
          url = API.authOrderCheckout(cartCode);
          orderSummaryDetails =
              await paymentRepo!.codPayment(url, data, userToken);
          if (orderSummaryDetails != null) {
            orderSuccessCallback!();
            authRepo!.clearCart();
          } else {
            orderFailureCallback!();
            authRepo!.clearCart();
          }
        }
        // guest user cod order confirmation
        else {
          url = API.guestOrderCheckout(cartCode);
          orderSummaryDetails = await paymentRepo!.codPayment(url, data, "");
          if (orderSummaryDetails != null) {
            orderSuccessCallback!();
            authRepo!.clearCart();
          } else {
            orderFailureCallback!();
          }
        }
      } else {
        // payment update
        if (data['orderId'] != null) {
          String url = API.checkoutOrderPayent(data['orderId']);
          OrderCheckoutResponse? orderSummery =
              await (paymentRepo!.checkoutOrderPayment(url, data)
                  as Future<OrderCheckoutResponse?>);
          if (orderSummery != null) {
            cartRepo!.removeCartCode();
            orderSummaryDetails = orderSummery;
            orderSuccessCallback!();
          } else {
            orderFailureCallback!();
          }
          log("response checkout order payment");
          debugPrint(orderSummery.toString());
        } else {
          throw Exception("order id is not availave in initOrder Model");
        }
      }
    } catch (e) {
      orderFailureCallback!();
    }

    // paid order confirmation (for both guest and authenticated user)
    // url = API.orderPaymentUpdate(orderId)

    // if (isLoggedIn && userToken.isNotEmpty) {}

    // // if user is authenticated
    // if (userToken.isNotEmpty && authRepo.isLoggedIn()) {
    //   // auth user cod order confirmation
    //   if (paymentMode == Strings.COD) {
    //     url = API.authOrderCheckout(cartCode);
    //     orderSummaryDetails =
    //         await paymentRepo.codPayment(url, data, userToken);
    //     if (orderSummaryDetails != null) {
    //       orderSuccessCallback();
    //       authRepo.clearCart();
    //     } else {
    //       orderFaildCallback();
    //     }
    //   }
    //   // auth user paid order confirmation
    //   else{
    //     url = API.authPayment
    //   }

    //   // if user is guest
    // } else {
    //   // guest user cod payment
    //   url = API.guestOrderCheckout(cartCode);
    //   orderSummaryDetails = await paymentRepo.codPayment(url, data, "");
    //   if (orderSummaryDetails != null) {
    //     orderSuccessCallback();
    //     authRepo.clearCart();
    //   } else {
    //     orderFaildCallback();
    //   }
    // }
    // notifyListeners();
  }

  Future<InitOrder?> initOnlineOrder(String? paymentModuleCode,
      CartModel? cartData, String amount, int orderId) async {
    // InitOrder initOrder;
    final String cartCode = cartRepo!.getCartCode();
    var finalAmount = /* fillterFinalValue(cartData) */ double.parse(amount);
    var token = authRepo!.getUserToken();
    var url = "";
    var cartId = cartRepo!.getCartCode();
    if (token != "") {
      url = API.authInitOnlineOrder(cartId);
    } else {
      url = API.initOnlineOrder(cartId);
    }
    var params = {
      'amount': finalAmount,
      'orderId': orderId,
      // 'keyId': cartCode,
      'paymentId': "",
      'paymentModule': paymentModuleCode,
      'paymentToken': "",
      'paymentType': Constants.ONLINE_PAYMENT,
      'signature': "",
      'transactionType': Constants.TRANSACTION_TYPE_INIT,
    };
    try {
      _initOrder =
          await paymentRepo!.initOnlineOrder(cartCode, params, url, token);
    } catch (e) {
      print("Exception is: " + e.toString());
    }
    print("init order response provider: " + _initOrder.toString());
    return _initOrder;
  }

  double? fillterFinalValue(CartModel cartData) {
    var finalAmount = cartData.totals!
        .where((item) => item.code == Constants.ORDER_TOTAL_TOTAL)
        .toList()[0]
        .value;
    return finalAmount;
  }

  Future<void> getPaymentModules() async {
    print("GetPaymentModule");
    List<PaymentModule> paymentModulesResponse =
        await paymentRepo!.getPaymentModules();
    if (paymentModulesResponse.isNotEmpty) {
      paymentModules = paymentModulesResponse;
    }
    notifyListeners();
  }

  Future<int?> createOrderDefination(
      Map<String, dynamic> orderDefinationBody, BuildContext context) async {
    if (authRepo!.isLoggedIn()) {
      return createAuthOrderDefination(orderDefinationBody, context);
    } else {
      return createGuestOrderDefination(orderDefinationBody, context);
    }
  }

  Future<int?> createGuestOrderDefination(
      Map<String, dynamic> orderDefinationData, BuildContext context) async {
    try {
      UserProfile? userProfile =
          Provider.of<ProfileProvider>(context, listen: false)
              .getSharePreferGuestUserAddress();

      orderDefinationData.putIfAbsent(
          "customer",
          () => {
                "billing": json.decode(jsonEncode(userProfile!.billing)),
                "delivery": json.decode(jsonEncode(userProfile.delivery)),
                "emailAddress": userProfile.emailAddress
              });
      dynamic data = orderDefinationData;
      print("json data");
      print(data.toString());
      String cartCode = cartRepo!.getCartCode();
      if (cartCode == null || cartCode.isEmpty) {
        throw Exception('Cart code not exist');
      }
      String url = API.guestCheckoutDefination(cartCode);
      CheckoutDefinationModel? checkoutDefinationResponse;
      checkoutDefinationResponse = await paymentRepo!
          .createAuthOrderDefination(url, data, '', context: context);
      log("Order id is" + checkoutDefinationResponse!.id.toString());

      return checkoutDefinationResponse.id;
    } catch (e) {
      print("Error is: " + e.toString());
    }
  }

  Future<int?> createAuthOrderDefination(
      Map<String, dynamic> authOrderDefinationData,
      BuildContext context) async {
    try {
      print("increateauthrordedefination");
      Object? data = json.decode(jsonEncode(authOrderDefinationData));
      String cartCode = cartRepo!.getCartCode();
      String token = authRepo!.getUserToken();
      if (cartCode == null || cartCode.isEmpty) {
        throw Exception('Cart code not exist');
      }
      String url = API.authCheckoutDefination(cartCode);

      CheckoutDefinationModel? checkoutDefinationResponse;

      checkoutDefinationResponse = await paymentRepo!
          .createAuthOrderDefination(url, data, token, context: context);
      log("Order id is" + checkoutDefinationResponse!.id.toString());

      return checkoutDefinationResponse.id;
    } catch (e) {
      print("Error is: " + e.toString());
    }
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shopiana/data/model/persistable/order_defination.dart';
import 'package:shopiana/data/model/response/cart_model.dart';

import 'package:shopiana/data/model/response/init_order_model.dart';
import 'package:shopiana/data/model/response/user_profile.dart';
import 'package:shopiana/helper/app_exception.dart';
import 'package:shopiana/provider/auth_provider.dart';
import 'package:shopiana/provider/cart_provider.dart';
import 'package:shopiana/provider/order_provider.dart';
import 'package:shopiana/provider/payment_provider.dart';
import 'package:shopiana/provider/profile_provider.dart';
import 'package:shopiana/provider/theme_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/store_constant.dart';
import 'package:shopiana/utill/string_resources.dart';
import 'package:shopiana/view/basewidget/price_card.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/view/screen/orderStatus/order_failure_screen.dart';
import 'package:shopiana/view/screen/orderStatus/order_successfull_screen.dart';
import 'package:shopiana/view/screen/payment_gateway_screens/razorpay_screen.dart';

class CheckoutPaymentScreen extends StatefulWidget {
  const CheckoutPaymentScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutPaymentScreen> createState() => _CheckoutPaymentScreenState();
}

class _CheckoutPaymentScreenState extends State<CheckoutPaymentScreen> {
  static const platform = const MethodChannel("razorpay_flutter");
  String? _paymentMode = "cod";
  late CartProvider cartProvider;
  late ProfileProvider profileProvider;
  late PaymentProvider paymentProvider;
  bool isLoading = true;

  // order success callback
  void orderSuccessCallback() {
    // while (Navigator.canPop(context)) {
    //   // Navigator.canPop return true if can pop
    //   Navigator.pop(context);
    // }
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) => OrderSuccessfullScreen(
                  orderSummeryDetails: paymentProvider.orderSummaryDetails,
                )),
        (route) => false);
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //       builder: (context) => OrderSuccessfullScreen(
    //             orderSummeryDetails: paymentProvider.orderSummaryDetails,
    //           )),
    // );
  }

  void orderFaildCallback() {
    // while (Navigator.canPop(context)) {
    //   // Navigator.canPop return true if can pop
    //   Navigator.pop(context);
    // }
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //       builder: (context) => OrderFailureScreen(
    //             orderSummeryDetails: paymentProvider.orderSummaryDetails,
    //           )),
    // );
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) => OrderFailureScreen(
                  orderSummeryDetails: paymentProvider.orderSummaryDetails,
                )),
        (route) => false);
  }

  paymentFailureCallback({
    UserProfile? customerInfo,
    CartModel? cartData,
    InitOrder? initOrder,
    PaymentFailureResponse? paymentFailureResponse,
  }) {
    print(paymentFailureResponse);
    orderFaildCallback();
  }

  // razorpay success call
  paymentSuccessCallback({
    UserProfile? customerInfo,
    CartModel? cartData,
    required InitOrder initOrder,
    required PaymentSuccessResponse paymentSuccessResponse,
  }) {
    String userToken =
        Provider.of<AuthProvider>(context, listen: false).getUserToken();
    // fillter final cart amount
    /* paymentProvider.fillterFinalValue(cartData) */
    var finalAmount = initOrder.details!.amount! / 100;
    var checkoutParams;

    final storeCode = StoreConstant.STORE_CODE;

    checkoutParams = {
      "amount": finalAmount.toString(),
      "orderId": initOrder.details?.receipt,
      "paymentId": paymentSuccessResponse.paymentId,
      "paymentModule": "razorpay", //TODO soft code
      "paymentToken": paymentSuccessResponse.orderId,
      "paymentType": Constants.ONLINE_PAYMENT, // TODO make ENUM
      "signature": paymentSuccessResponse.signature,
      "transactionType":
          Constants.TRANSACTION_TYPE_AUTHORIZECAPTURE, // TODO make ENUM,
      "shippingQuote":
          Provider.of<OrderProvider>(context, listen: false).shippingQuoteId
    };

    paymentProvider.orderCheckoutFinal(
        data: checkoutParams,
        paymentMode: _paymentMode,
        orderFailureCallback: orderFaildCallback,
        orderSuccessCallback: orderSuccessCallback);
  }

  Future<void> proceedPayment(String? paymentMode, BuildContext context) async {
    var finalAmount =
        /* paymentProvider.fillterFinalValue(cartProvider.cartData).toString() */ Provider
                .of<OrderProvider>(context, listen: false)
            .shippingTotal!
            .total
            .toString();
    // payment process starts

    // Make order -> order defination create -> starts
    Map<String, dynamic> orderDefinationData = {
      "amount": finalAmount,
      "currency": Constants.CURRENCY,
      "shippingQuote":
          Provider.of<OrderProvider>(context, listen: false).shippingQuoteId
    };
    AuthOrderDefination authOrderDefinationBody =
        AuthOrderDefination(amount: finalAmount, currency: Constants.CURRENCY);
    int? orderId = await paymentProvider.createOrderDefination(
        orderDefinationData, context);
    // int orderId = await paymentProvider.createAuthOrderDefination(
    //     authOrderDefinationBody, context);
    // Make order -> order defination create -> ends

    // payment init -> get payment signature -> starts
    if (orderId == null) {
    } else {
      InitOrder? initOrder = await /* ( */ paymentProvider.initOnlineOrder(
          _paymentMode, cartProvider.cartData, finalAmount, orderId);
      print("init order");
      print(initOrder?.paymentToken.toString());
      print(initOrder?.paymentType.toString());

      /* as Future<InitOrder>); */
      initOrder!.shippingQuote =
          Provider.of<OrderProvider>(context, listen: false).shippingQuoteId;
      // payment init -> get payment signature -> ends
      UserProfile? userProfile = profileProvider.userInfoModel;
      if (!Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
        userProfile = profileProvider.guestInfo;
      }
      if (paymentMode == Strings.RAZORPAY) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => RazorpayScreen(
                    cartdata: cartProvider.cartData,
                    userProfile: userProfile,
                    finalAmount:
                        Provider.of<OrderProvider>(context, listen: false)
                            .shippingTotal!
                            .total,
                    initOrder: initOrder,
                    paymentSuccessCallback: paymentSuccessCallback,
                    paymentFailureCallback: paymentFailureCallback)));
      }
    }
  }

  // cod payment call
  Future<void> codPayment() async {
    UserProfile userInfo = profileProvider.userInfoModel!;
    var finalAmount = /*  paymentProvider.fillterFinalValue(cartProvider.cartData) */ Provider
            .of<OrderProvider>(context, listen: false)
        .shippingTotal!
        .total;
    var data = {
      "comments": "",
      "currency": "INR",
      "customer": {
        "billing": userInfo.billing,
        "delivery": userInfo.delivery,
        "emailAddress": userInfo.emailAddress,
        "id": 0,
        "language": userInfo.language,
        "storeCode": userInfo.storeCode
      },
      "customerAgreement": true,
      "id": 0,
      "payment": {
        "amount": finalAmount,
        "paymentId": 0,
        "paymentModule": Strings.COD,
        "paymentToken": "",
        "paymentType": Strings.COD.toUpperCase(),
        "signature": "",
        "transactionType": "AUTHORIZECAPTURE",
      },
      "shippingQuote":
          Provider.of<OrderProvider>(context, listen: false).shippingQuoteId
    };

    paymentProvider.orderCheckoutFinal(
        data: data,
        paymentMode: _paymentMode,
        orderSuccessCallback: orderSuccessCallback,
        orderFailureCallback: orderFaildCallback);
  }

  // payment method for online/cashondelivery
  void orderCheckout() async {
    setState(() {
      print("set state in order checkout");
      isLoading = true;
    });
    // paymentProvider.orderCheckout(_paymentMode, cartProvider.cartData)
    // _paymentMode == cod then codpayment else online payment
    print("selectedModule" + _paymentMode!);
    if (_paymentMode == Strings.COD) {
      codPayment();
    } else {
      await proceedPayment(_paymentMode, context);
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getPaymentModules(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<PaymentProvider>(context, listen: false)
        .getPaymentModules();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getShippingCalculation(BuildContext context) async {
    bool isLoggedIn =
        Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (isLoggedIn) {
      await Provider.of<OrderProvider>(context, listen: false)
          .getAuthShippingCalculation(cartProvider.cartData!.code);
    } else {
      await Provider.of<OrderProvider>(context, listen: false)
          .createShippingCalculation(cartProvider.cartData!.code);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    getPaymentModules(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    paymentProvider = Provider.of<PaymentProvider>(context, listen: false);

    //  get payment modules list
    // List<PaymentModule> paymentModulesList = paymentProvider.paymentModules;

    return Scaffold(
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
          child: InkWell(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => OrderSuccessfullScreen()));
              return isLoading ? null : orderCheckout();
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor,
              ),
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ))
                  : Text(
                      getTranslated('payment', context)!,
                      style: titilliumSemiBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: Theme.of(context).accentColor),
                    ),
            ),
          )),
      appBar: AppBar(
        title: Row(children: [
          InkWell(
            child: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).textTheme.bodyText1!.color, size: 20),
            onTap: () => Navigator.pop(context),
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Text(getTranslated('payment', context)!,
              style: robotoRegular.copyWith(
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodyText1!.color)),
        ]),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Provider.of<ThemeProvider>(context).darkTheme
            ? Colors.black
            : Colors.white.withOpacity(0.5),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ))
          : Container(
              child: Consumer<PaymentProvider>(
                builder: (context, paymentProvider, child) {
                  return Column(
                    children: [
                      ...paymentProvider.paymentModules.map(
                        (module) => RadioListTile(
                          value: module.code,
                          title: Text(module.code!.toUpperCase()),
                          activeColor: Theme.of(context).primaryColor,
                          subtitle: Text(
                              '${module.code} delivery available for this product'),
                          groupValue: _paymentMode,
                          onChanged: (dynamic value) {
                            setState(() {
                              _paymentMode = value;
                              // isLoading =
                            });
                          },
                        ),
                      ),
                      /* Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: PriceCard(totals: cartProvider.cartData.totals),
                      ), */
                      FutureBuilder(
                        future: getShippingCalculation(context),
                        builder: (ctx, groupSnapshot) {
                          if (groupSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            );
                          } else if (groupSnapshot.hasError) {
                            return Center(
                              child: Text('Something Went Wrong'),
                            );
                          } else {
                            return Consumer<OrderProvider>(
                              builder: (context, orderProvider, child) {
                                return Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    height: 300,
                                    child: ListView.builder(
                                      itemCount: orderProvider
                                          .shippingTotal!.totals!.length,
                                      itemBuilder: (context, index) =>
                                          Container(
                                              child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(orderProvider.shippingTotal!
                                                      .totals![index].title! +
                                                  " :"),
                                              Text(orderProvider.shippingTotal!
                                                  .totals![index].value
                                                  .toString())
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Divider(
                                              indent: 20,
                                              endIndent: 20,
                                              color: Colors.grey.shade400)
                                        ],
                                      )),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}

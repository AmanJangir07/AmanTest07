import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shopiana/data/model/response/cart_model.dart';
import 'package:shopiana/data/model/response/init_order_model.dart';
import 'package:shopiana/data/model/response/user_profile.dart';
import 'package:shopiana/provider/payment_provider.dart';

class RazorpayScreen extends StatefulWidget {
  final CartModel? cartdata;
  final UserProfile? userProfile;
  final InitOrder initOrder;
  final Function paymentSuccessCallback;
  final Function paymentFailureCallback;
  final double? finalAmount;
  const RazorpayScreen(
      {required this.cartdata,
      required this.finalAmount,
      required this.userProfile,
      required this.initOrder,
      required this.paymentSuccessCallback,
      required this.paymentFailureCallback});

  @override
  State<RazorpayScreen> createState() => _RazorpayScreenState();
}

class _RazorpayScreenState extends State<RazorpayScreen> {
  Razorpay _razorpay = Razorpay();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    debugPrint("payment success response");
    // debugPrint(jsonEncode(response));
    widget.paymentSuccessCallback(
        customerInfo: widget.userProfile,
        cartData: widget.cartdata,
        initOrder: widget.initOrder,
        paymentSuccessResponse: response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    debugPrint("payment failure response");
    widget.paymentFailureCallback(
        customerInfo: widget.userProfile,
        cartData: widget.cartdata,
        initOrder: widget.initOrder,
        paymentFailureResponse: response);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    debugPrint("payment external wallet selected response");
    debugPrint(response.toString());
  }

  void processRazorpay() {
    var finalAmount = /* Provider.of<PaymentProvider>(context, listen: false)
        .fillterFinalValue(widget.cartdata) */
        widget.initOrder.amount.toString();
    var options = {
      'key': widget.initOrder.metadata!.keyId,
      'amount': widget.finalAmount,
      'name': widget.userProfile!.billing!.firstName,
      'description': 'Test payment',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'order_id': widget.initOrder.paymentToken,
      'prefill': {
        'contact': widget.userProfile!.billing!.phone,
        'email': widget.userProfile!.emailAddress,
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("razorpay payment error" + e.toString());
    }
  }

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
    processRazorpay();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Plese do not press back button or close the app"),
      ),
    );
  }
}

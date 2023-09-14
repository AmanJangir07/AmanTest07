import 'dart:convert';

import 'package:shopiana/data/model/response/meta_data.dart';

class InitOrder {
  String? amount;
  InitOrderDetails? details;
  int? id;
  MetaData? metadata;
  int? orderId;
  String? paymentToken;
  String? paymentType;
  String? transactionDate;
  String? transactionType;
  int? shippingQuote;

  InitOrder(
      {this.amount,
      this.details,
      this.id,
      this.metadata,
      this.orderId,
      this.paymentToken,
      this.paymentType,
      this.transactionDate,
      this.transactionType,
      this.shippingQuote});

  Map toJson() => {
        "amount": amount,
        "details": details,
        "id": id,
        "metadata": metadata,
        "orderId": orderId,
        "paymentToken": paymentToken,
        "paymentType": paymentType,
        "transactionDate": transactionDate,
        "transactionType": transactionType,
        "shippingQuote": shippingQuote
      };

  factory InitOrder.fromJson(Map<String, dynamic> json) {
    return InitOrder(
        amount: json['amount'],
        details: InitOrderDetails.fromJson(jsonDecode(json['details'])),
        id: json['id'],
        metadata: MetaData.fromJson(json['metadata']),
        orderId: json['orderId'],
        paymentToken: json['paymentToken'],
        paymentType: json['paymentType'],
        transactionDate: json['transactionDate'],
        transactionType: json['transactionType'],
        shippingQuote: json["shippingQuote"]);
  }
}

class InitOrderDetails {
  int? amount;
  String? receipt;

  InitOrderDetails({this.amount, this.receipt});
  factory InitOrderDetails.fromJson(Map<String, dynamic>? json) {
    return json == null
        ? InitOrderDetails()
        : InitOrderDetails(amount: json['amount'], receipt: json['receipt']);
  }
}

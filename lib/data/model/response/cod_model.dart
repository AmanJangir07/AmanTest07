import 'package:shopiana/data/model/response/user_info_model.dart';

class CodModel {
  String? comments;
  String? currency;
  CustomerModel? customer;
  bool? customerAgreement;
  int? id;
  PaymentModel? payment;

  CodModel(
      {this.comments,
      this.currency,
      this.customer,
      this.customerAgreement,
      this.id,
      this.payment});

  CodModel.fromJson(Map<String, dynamic> json) {
    comments = json['comments'];
    currency = json['currency'];

    customer = json['customer'] != null
        ? new CustomerModel.fromJson(json['customer'])
        : null;

    customerAgreement = json['customerAgreement'];
    id = json['id'];

    payment = json['payment'] != null
        ? new PaymentModel.fromJson(json['payment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comments'] = this.comments;
    data['currency'] = this.currency;

    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['customerAgreement'] = this.customerAgreement;
    data['id'] = this.id;

    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    return data;
  }
}

class CustomerModel {
  UserBilling? billing;
  UserDelivery? delivery;
  String? emailAddress;
  int? id;
  String? language;
  String? storeCode;

  CustomerModel(
      {this.billing,
      this.delivery,
      this.emailAddress,
      this.id,
      this.language,
      this.storeCode});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    billing = json['billing'] != null
        ? new UserBilling.fromJson(json['billing'])
        : null;

    delivery = json['delivery'] != null
        ? new UserDelivery.fromJson(json['delivery'])
        : null;

    emailAddress = json['emailAddress'];
    id = json['id'];
    language = json['language'];
    storeCode = json['storeCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.billing != null) {
      data['billing'] = this.billing!.toJson();
    }
    if (this.delivery != null) {
      data['delivery'] = this.delivery!.toJson();
    }
    data['id'] = this.id;
    data['emailAddress'] = this.emailAddress;
    data['language'] = this.language;
    data['storeCode'] = this.storeCode;
    return data;
  }
}

class PaymentModel {
  double? amount;
  int? paymentId;
  String? paymentModule;
  String? paymentToken;
  String? paymentType;
  String? signature;
  String? transactionType;
  PaymentModel(
      {this.amount,
      this.paymentId,
      this.paymentModule,
      this.paymentToken,
      this.paymentType,
      this.signature,
      this.transactionType});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    paymentId = json['paymentId'];
    paymentModule = json['paymentModule'];
    paymentToken = json['paymentToken'];
    paymentType = json['paymentType'];
    signature = json['signature'];
    transactionType = json['transactionType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['paymentId'] = this.paymentId;
    data['paymentModule'] = this.paymentModule;
    data['paymentToken'] = this.paymentToken;
    data['paymentType'] = this.paymentType;
    data['signature'] = this.signature;
    data['transactionType'] = this.transactionType;
    return data;
  }
}

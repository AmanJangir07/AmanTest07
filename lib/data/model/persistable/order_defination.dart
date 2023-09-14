import 'package:flutter/cupertino.dart';

class AuthOrderDefination {
  String? _amount;
  String? _currency;
  AuthOrderDefination({required String amount, required String currency}) {
    this._amount = amount;
    this._currency = currency;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this._amount;
    data['currency'] = this._currency;
    return data;
  }
}

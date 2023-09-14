import 'package:flutter/cupertino.dart';

class OrderStatus {
  static const ALL = {'title': 'ALL', 'value': ''};
  static const ORDERED = {'title': 'ORDERED', 'value': 'ORDERED'};
  static const PROCESSED = {'title': 'PROCESSED', 'value': 'PROCESSED'};
  static const DELIVERED = {'title': 'DELIVERED', 'value': 'DELIVERED'};
  static const CANCELED = {'title': 'CANCELED', 'value': 'CANCELED'};

  static const ALL_STATUS = [ALL, ORDERED, PROCESSED, DELIVERED, CANCELED];
}

// class OrderStatusInfo {
//   final String title;
//   final String value;
//   // String get getTitle => this._title;

//   // set setTitle(String title) => this._title = title;

//   // get getValue => this._value;

//   // set setValue(value) => this._value = value;
//   OrderStatusInfo({@required String title, @required String value}) {
//     this.title = title;
//     this.value = value;
//   }
// }

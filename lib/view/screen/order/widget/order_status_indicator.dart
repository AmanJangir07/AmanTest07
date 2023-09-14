import 'package:flutter/material.dart';
import 'package:shopiana/data/enum_constants/order_enum.dart';

Color getIndicatorColor(String orderStatus) {
  print("orderstatus:" + orderStatus + OrderStatus.ORDERED.toString());
  if (orderStatus == OrderStatus.ORDERED['value']) {
    return Colors.yellow;
  } else if (orderStatus == OrderStatus.PROCESSED['value']) {
    return Colors.teal;
  } else if (orderStatus == OrderStatus.DELIVERED['value']) {
    return Colors.green;
  } else if (orderStatus == OrderStatus.CANCELED['value']) {
    return Colors.red;
  } else {
    return Colors.black;
  }
}

Widget OrderStatusIndicator(String orderStatus, double containerHeight) {
  return Container(
    height: containerHeight * 0.08,
    width: containerHeight * 0.08,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: getIndicatorColor(orderStatus),
    ),
  );
}

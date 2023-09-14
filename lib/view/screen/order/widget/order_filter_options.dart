import 'package:flutter/material.dart';
import 'package:shopiana/data/enum_constants/order_enum.dart';

Future<void> orderFilterOptions(
    {required BuildContext context,
    dynamic selectedStatus,
    double? height,
    double? width,
    Function? orderFilterCallbackFunction}) {
  return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...OrderStatus.ALL_STATUS.map((status) => orderStatusOption(
                  context: context,
                  height: height!,
                  status: status,
                  selectedStatus: selectedStatus,
                  orderFilterCallbackFunction: orderFilterCallbackFunction)),
            ],
          ),
        );
      }).then((value) => value as Widget);
}

Widget orderStatusOption(
    {BuildContext? context,
    required double height,
    required dynamic status,
    required dynamic selectedStatus,
    Function? orderFilterCallbackFunction}) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context!);
          orderFilterCallbackFunction!(selectedOrderStatus: status);
        },
        child: Container(
          width: double.infinity,
          height: height * 0.06,
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            color: status['value'] == selectedStatus['value']
                ? Theme.of(context!).primaryColor
                : Colors.white,
          ),
          child: Center(
              child: Text(
            status['title'],
            style: TextStyle(
                color: status['value'] == selectedStatus['value']
                    ? Colors.white
                    : Colors.black),
          )),
        ),
      ));
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/data/model/response/order_model.dart';
import 'package:shopiana/provider/order_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';

class OrderTypeButton extends StatelessWidget {
  final String text;
  final int index;
  final List<OrderModel> orderList;

  OrderTypeButton(
      {required this.text, required this.index, required this.orderList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(0),
        ),
        onPressed: () =>
            Provider.of<OrderProvider>(context, listen: false).setIndex(index),
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Provider.of<OrderProvider>(context, listen: false)
                        .orderTypeIndex ==
                    index
                ? ColorResources.getPrimary(context)
                : Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(text + '(${orderList.length})',
              style: titilliumBold.copyWith(
                  color: Provider.of<OrderProvider>(context, listen: false)
                              .orderTypeIndex ==
                          index
                      ? Theme.of(context).accentColor
                      : ColorResources.getPrimary(context))),
        ),
      ),
    );
  }
}

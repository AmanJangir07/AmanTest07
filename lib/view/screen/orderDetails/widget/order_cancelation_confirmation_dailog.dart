import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/order_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/screen/orderStatus/order_cancel_screen.dart';

class CancelOrderConfirmationDialog extends StatelessWidget {
  int? id;
  CancelOrderConfirmationDialog(this.id);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: 50),
          child: Text("Do you want to Cancel Your Order?",
              style: robotoBold, textAlign: TextAlign.center),
        ),
        Divider(height: 0, color: ColorResources.HINT_TEXT_COLOR),
        Row(children: [
          Expanded(
              child: InkWell(
            onTap: () {
              Provider.of<OrderProvider>(context, listen: false)
                  .updateOrder(id);

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => OrderCancelScreen()),
                  (route) => false);
            },
            child: Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(10))),
              child: Text(getTranslated('YES', context)!,
                  style: titilliumBold.copyWith(
                      color: ColorResources.COLOR_PRIMARY)),
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: ColorResources.RED,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(10))),
              child: Text(getTranslated('NO', context)!,
                  style: titilliumBold.copyWith(color: ColorResources.WHITE)),
            ),
          )),
        ]),
      ]),
    );
  }
}

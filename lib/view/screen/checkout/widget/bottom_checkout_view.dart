import 'package:flutter/material.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/screen/checkoutAddress/checkout_address_screen.dart';

class BottomCheckoutView extends StatelessWidget {
  const BottomCheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: Colors.grey[300]!, blurRadius: 15, spreadRadius: 1)
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                "\$309",
                style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            Expanded(
                flex: 11,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CheckoutAddress()));
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorResources.getPrimary(context),
                    ),
                    child: Text(
                      "Continue",
                      style: titilliumSemiBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: Theme.of(context).accentColor),
                    ),
                  ),
                )),
          ],
        ));
  }
}

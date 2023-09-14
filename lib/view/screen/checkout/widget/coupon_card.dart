import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/data/model/response/cart_model.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/cart_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/basewidget/show_custom_snakbar.dart';
import 'coupon_bottom_sheet.dart';

class CouponCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void removeCoupon() async {
      CartModel? cartModel =
          await Provider.of<CartProvider>(context, listen: false)
              .removeCoupon();
      if (cartModel != null) {
        showCustomSnackBar(getTranslated('coupon_remove', context)!, context,
            isError: false);
        Provider.of<CartProvider>(context, listen: false).getCartData();
      } else {
        showCustomSnackBar(
            getTranslated("something_went_wrong", context)!, context,
            isError: true);
      }
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.only(
            right: Dimensions.PADDING_SIZE_DEFAULT,
            left: Dimensions.PADDING_SIZE_DEFAULT),
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            return Column(
              children: [
                if (cartProvider.cartData!.promoCode == null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.local_offer_outlined,
                            color: Theme.of(context).primaryColor,
                            size: Dimensions.FONT_SIZE_OVER_LARGE,
                          ),
                          Text(
                            getTranslated('apply_coupon', context)!,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                          )
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (con) => CouponBottomSheet());
                        },
                        child: Text(
                          getTranslated(
                            'APPLY',
                            context,
                          )!,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  )
                else
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getTranslated('your_coupon_code_applied', context)! +
                              cartProvider.cartData!.promoCode!,
                          style: TextStyle(
                            color: ColorResources.GREEN,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              removeCoupon();
                            },
                            icon: Icon(Icons.cancel, color: ColorResources.RED))
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

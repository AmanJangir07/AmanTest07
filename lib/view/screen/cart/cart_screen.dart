import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/user_profile.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/auth_provider.dart';
import 'package:shopiana/provider/cart_provider.dart';
import 'package:shopiana/provider/profile_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/basewidget/custom_app_bar.dart';
import 'package:shopiana/view/basewidget/no_internet_screen.dart';
import 'package:shopiana/view/basewidget/price_card.dart';
import 'package:shopiana/view/screen/cart/widget/cart_widget.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/view/screen/checkout/widget/coupon_card.dart';
import 'package:shopiana/view/screen/checkoutAddress/widget/auth_user_address.dart';
import 'package:shopiana/view/screen/home/home_screen.dart';
import 'package:shopiana/view/screen/product/widget/guest_auth_checkout_selection_bottom_sheet.dart';

class CartScreen extends StatelessWidget {
  final bool fromCheckout;
  // final List<CartModel> checkoutCartList;
  CartScreen({this.fromCheckout = false
      // this.checkoutCartList
      });

  @override
  Widget build(BuildContext context) {
    NetworkInfo.checkConnectivity(context);
    List<String> sellerList = [];
    sellerList.forEach((seller) {});

    return Scaffold(
      appBar: AppBar(
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            child:
                Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
            onTap: () => Navigator.pop(context),
          ),
          title: Text("Cart",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      bottomNavigationBar: !fromCheckout
          ? Consumer<CartProvider>(
              builder: (context, cartProvider, child) => cartProvider
                          .cartItems.length >
                      0
                  ? Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_LARGE,
                          vertical: Dimensions.PADDING_SIZE_DEFAULT),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Text(
                              cartProvider.cartData!.displayTotal!,
                              style: titilliumSemiBold.copyWith(
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                          Builder(
                            builder: (context) => ElevatedButton(
                              onPressed: cartProvider.cartItems.length != 0
                                  ? () {
                                      if (Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .isLoggedIn()) {
                                        UserBilling? userBilling =
                                            Provider.of<ProfileProvider>(
                                                    context,
                                                    listen: false)
                                                .userInfoModel
                                                ?.billing;
                                        if (userBilling != null) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AuthUserAddress(),
                                            ),
                                          );
                                        }
                                      } else {
                                        showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (con) =>
                                                GuestAuthCheckoutSelectionBottomSheet());
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             GuestUserAddress()));
                                      }
                                    }
                                  : () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(getTranslated(
                                                  'please_add_item_in_cart',
                                                  context)!),
                                              backgroundColor:
                                                  ColorResources.RED));
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    },
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).accentColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: InkWell(
                                child: Text(
                                  getTranslated('continue', context)!,
                                  style: titilliumSemiBold.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                  : SizedBox(),
            )
          : SizedBox(),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, child) => Container(
            // height: 500,
            child: Column(
              children: [
                cartProvider.cartItems.length > 0
                    ? Column(
                        children: [
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.all(0),
                            itemCount: cartProvider.cartItems.length,
                            itemBuilder: (context, i) => CartWidget(
                              product:
                                  cartProvider.cartItems.values.toList()[i],
                              index: i,
                              fromCheckout: false,
                            ),
                          ),
                          CouponCard(),
                          Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_DEFAULT),
                            child: PriceCard(
                                totals: cartProvider.cartData?.totals),
                          )
                        ],
                      )
                    : Container(
                        height: 500,
                        child: Expanded(
                          child: NoInternetOrDataScreen(isNoInternet: false),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

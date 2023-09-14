import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/data/model/response/config_model.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/provider/cart_provider.dart';
import 'package:shopiana/provider/splash_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/view/screen/cart/cart_screen.dart';
import 'package:shopiana/view/screen/dashboard/dashboard_screen.dart';
import 'package:shopiana/view/screen/home/widget/home_products_widget.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NetworkInfo.checkConnectivity(context);
    ConfigModel config =
        Provider.of<SplashProvider>(context, listen: false).configModel!;
    final ScrollController _scrollController = new ScrollController();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        leading: InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => DashBoardScreen(),
                ),
                (route) => false)),
        title: Text(
          "Products",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          /*    IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ), */
          config.allowOnlinePurchase!
              ? Consumer<CartProvider>(builder: (_, cart, ch) {
                  return IconButton(
                    onPressed: () {
                      // if (cart.cartItems.isNotEmpty) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CartScreen()));
                      // }
                    },
                    icon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset(
                          Images.cart_image,
                          color: Theme.of(context).primaryColor,
                          height: Dimensions.ICON_SIZE_DEFAULT,
                          width: Dimensions.ICON_SIZE_DEFAULT,
                        ),
                        Positioned(
                          top: -4,
                          right: -4,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text(cart.cartItems.length.toString(),
                                style: titilliumSemiBold.copyWith(
                                  color: ColorResources.WHITE,
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                )),
                          ),
                        ),
                      ],
                    ),
                  );
                })
              : SizedBox()
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
          child: HomeProducts(_scrollController),
          controller: _scrollController),
    );
  }
}

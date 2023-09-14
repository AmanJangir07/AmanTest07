import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/cart_provider.dart';
import 'package:shopiana/provider/theme_provider.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/basewidget/price_card.dart';
import 'package:shopiana/view/screen/checkout/widget/bottom_checkout_view.dart';
import 'package:shopiana/view/screen/checkout/widget/checkout_product.dart';
import 'package:shopiana/view/screen/checkout/widget/coupon_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomCheckoutView(),
      appBar: AppBar(
        title: Row(children: [
          InkWell(
            child: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).textTheme.bodyText1!.color, size: 20),
            onTap: () => Navigator.pop(context),
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Text(getTranslated('checkout', context)!,
              style: robotoRegular.copyWith(
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodyText1!.color)),
        ]),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Provider.of<ThemeProvider>(context).darkTheme
            ? Colors.black
            : Colors.white.withOpacity(0.5),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Container(
            child: SingleChildScrollView(
              child: Column(children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  padding: EdgeInsets.all(0),
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (context, i) => CheckoutProduct(
                    product: cartProvider.cartItems.values.toList()[i],
                    index: i,
                  ),
                ),
                CouponCard(),
                PriceCard(totals: cartProvider.cartData!.totals),
              ]),
            ),
          );
        },
      ),
    );
  }
}

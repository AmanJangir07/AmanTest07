import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/cart_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/view/basewidget/show_custom_snakbar.dart';
import 'package:shopiana/view/screen/cart/cart_screen.dart';
import 'package:shopiana/view/screen/product/widget/cart_bottom_sheet.dart';
import 'package:provider/provider.dart';

class BottomCartView extends StatelessWidget {
  final Product product;
  final double? priceOptionPrice;
  final Map<String?, OptionValue>? selectedOptions;
  final Map<String?, int?> variants;
  BottomCartView(
      {required this.product,
      required this.priceOptionPrice,
      this.selectedOptions,
      required this.variants});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        // color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(color: Colors.grey[300]!, blurRadius: 15, spreadRadius: 1)
        ],
      ),
      child: Row(children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Stack(
              children: [
                Consumer<CartProvider>(builder: (_, cart, ch) {
                  return GestureDetector(
                    onTap: () {
                      if (cart.cartItems.isNotEmpty) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CartScreen()));
                      }
                    },
                    child: Image.asset(Images.cart_image,
                        color: Theme.of(context).primaryColor),
                  );
                }),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 22,
                  child: Container(
                    height: 17,
                    width: 17,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      Provider.of<CartProvider>(context)
                          .cartItems
                          .length
                          .toString(),
                      style: titilliumSemiBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          color: Theme.of(context).accentColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
            flex: 11,
            child: InkWell(
              onTap: () {
                if (product.available == false || product.quantity! <= 0) {
                  return null;
                }
                if (!Provider.of<CartProvider>(context, listen: false)
                    .isAddedInCart(product.id)) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (con) => CartBottomSheet(
                      product: product,
                      isBuy: false,
                      selectedOptions: selectedOptions,
                      priceOptionPrice: priceOptionPrice,
                      variants: variants,
                      callback: () {
                        showCustomSnackBar('Added to cart', context,
                            isError: false);
                      },
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(getTranslated('already_added', context)!),
                      backgroundColor: ColorResources.RED));
                }
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: product.available == false || product.quantity! <= 0
                        ? Colors.red
                        : Theme.of(context).primaryColor),
                child: Text(
                  product.available == false || product.quantity! <= 0
                      ? "Out Of Stock"
                      : Provider.of<CartProvider>(context)
                              .isAddedInCart(product.id)
                          ? getTranslated('added_to_cart', context)!
                          : getTranslated('add_to_cart', context)!,
                  style: titilliumSemiBold.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      color: Theme.of(context).accentColor),
                ),
              ),
            )),
      ]),
    );
  }
}

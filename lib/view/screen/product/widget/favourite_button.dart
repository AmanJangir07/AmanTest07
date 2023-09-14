import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/provider/auth_provider.dart';
import 'package:shopiana/provider/wishlist_provider.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/view/basewidget/animated_custom_dialog.dart';
import 'package:shopiana/view/basewidget/guest_dialog.dart';
import 'package:shopiana/view/basewidget/show_custom_snakbar.dart';
import 'package:provider/provider.dart';

class FavouriteButton extends StatelessWidget {
  final Color backgroundColor;
  final Color favColor;
  final bool isSelected;
  final Product? product;
  FavouriteButton(
      {this.backgroundColor = Colors.black,
      this.favColor = Colors.white,
      this.isSelected = false,
      this.product});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode =
        !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();

    feedbackMessage(String message) {
      if (message != '') {
        showCustomSnackBar(message, context, isError: false);
      }
    }

    return GestureDetector(
      onTap: () {
        if (isGuestMode) {
          showAnimatedDialog(context, GuestDialog(), isFlip: true);
        } else {
          Provider.of<WishListProvider>(context, listen: false).isWish
              ? Provider.of<WishListProvider>(context, listen: false)
                  .removeWishList(product, feedbackMessage: feedbackMessage)
              : Provider.of<WishListProvider>(context, listen: false)
                  .addWishList(product, feedbackMessage: feedbackMessage);
        }
      },
      child: Consumer<WishListProvider>(
        builder: (context, wishListProvider, child) => Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          color: backgroundColor,
          child: Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Image.asset(
              wishListProvider.isWish ? Images.wish_image : Images.wishlist,
              color: favColor,
              height: 30,
              width: 30,
            ),
          ),
        ),
      ),
    );
  }
}

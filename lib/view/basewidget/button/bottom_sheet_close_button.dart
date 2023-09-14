import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/provider/product_details_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/dimensions.dart';

class BottomSheetCloseButton extends StatelessWidget {
  const BottomSheetCloseButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).accentColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[200]!,
                    spreadRadius: 1,
                    blurRadius: 5,
                  )
                ]),
            child: Icon(Icons.clear, size: Dimensions.ICON_SIZE_SMALL),
          ),
        ));
  }
}

class QuantityButton extends StatelessWidget {
  final bool isIncrement;
  final int quantity;
  final bool isCartWidget;

  QuantityButton({
    required this.isIncrement,
    required this.quantity,
    this.isCartWidget = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (!isIncrement && quantity > 1) {
          Provider.of<ProductDetailsProvider>(context, listen: false)
              .setQuantity(quantity - 1);
        } else if (isIncrement) {
          Provider.of<ProductDetailsProvider>(context, listen: false)
              .setQuantity(quantity + 1);
        }
      },
      icon: Icon(
        isIncrement ? Icons.add_circle : Icons.remove_circle,
        color: isIncrement
            ? ColorResources.getPrimary(context)
            : quantity > 1
                ? ColorResources.getPrimary(context)
                : ColorResources.getLowGreen(context),
        size: isCartWidget ? 26 : 20,
      ),
    );
  }
}

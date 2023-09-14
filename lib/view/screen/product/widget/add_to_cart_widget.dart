import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/cart_provider.dart';
import 'package:shopiana/provider/product_provider.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/snackbar.dart';

class AddToCart extends StatefulWidget {
  Product product;
  AddToCart({required this.product});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  String selectedSizeValue = '';
  Map<String?, int?> variants = {};
  ProductVariantPrice? productVariantPrice;
  bool _isLoading = false;
  double? priceOptionPrice;
  Map<String?, OptionValue> selectedOptions = {};

  void initSelectOptions() {
    priceOptionPrice = widget.product.productPrice!.finalPriceDecimal!;
    widget.product.options!.forEach((option) {
      if (option.optionValues![0] != null) {
        priceOptionPrice = priceOptionPrice! + option.optionValues![0].price!;
        selectedOptions.putIfAbsent(option.code, () => option.optionValues![0]);
      }
    });
  }

  void changeProductOptions(Map<String?, OptionValue> newOptions) {
    setState(() {
      selectedOptions = newOptions;
      priceOptionPrice = widget.product.productPrice!.finalPriceDecimal!;
      newOptions.forEach((key, value) {
        priceOptionPrice = priceOptionPrice! + value.price!;
      });
    });
  }

  void setInitialVariants() {
    widget.product.options!.forEach((currentOption) {
      for (var currentOptionValue in currentOption.optionValues!) {
        var index = currentOption.optionValues!.indexOf(currentOptionValue);
        if (index == 0 || currentOptionValue.defaultValue!) {
          variants.update(
            currentOption.name,
            (existingValue) => currentOption.optionValues![0].id,
            ifAbsent: () => currentOption.optionValues![0].id,
          );
          if (currentOptionValue.defaultValue!) {
            break;
          }
        }
      }
    });
  }

  Future<void> changeVariant(String variantKey, int variantValue) async {
    variants[variantKey] = variantValue;
    await getPriceByVariant();
  }

  Future<void> getPriceByVariant() async {
    setState(() {
      _isLoading = true;
    });
    productVariantPrice =
        await Provider.of<ProductProvider>(context, listen: false)
            .getPriceByVariants(
                productId: widget.product.id,
                variantMap: variants,
                context: context);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initSelectOptions();

    super.initState();
  }

  @override
  Widget build(BuildContext buildContext) {
    return Container(
      child: ElevatedButton(
        style: ButtonStyle(
            side: MaterialStateProperty.all(
                BorderSide(color: Theme.of(context).primaryColor)),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            elevation: MaterialStateProperty.all(1)),
        onPressed: () {
          Provider.of<CartProvider>(buildContext, listen: false).addToCart(
              productId: widget.product.id,
              selectedOptions: selectedOptions,
              quantity: 1,
              variants: variants,
              promocode: '');
          showSuccessSnackbar(buildContext, "Added to Cart");
        },
        child: Text(
          widget.product.available == false || widget.product.quantity! <= 0
              ? "Out Of Stock"
              : Provider.of<CartProvider>(context)
                      .isAddedInCart(widget.product.id)
                  ? "Added"
                  : "Add",
          style: titilliumSemiBold.copyWith(
              fontSize: Dimensions.FONT_SIZE_SMALL,
              color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

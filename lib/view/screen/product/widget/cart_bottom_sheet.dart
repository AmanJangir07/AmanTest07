import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/cart_provider.dart';
import 'package:shopiana/provider/product_details_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/basewidget/button/bottom_sheet_close_button.dart';
import 'package:shopiana/view/basewidget/button/custom_button.dart';
import 'package:shopiana/view/basewidget/button/quantity_drop_down.dart';
import 'package:provider/provider.dart';

class CartBottomSheet extends StatefulWidget {
  final Product product;
  final Map<String?, OptionValue>? selectedOptions;
  final bool isBuy;
  final double? priceOptionPrice;
  final Function? callback;
  final Map<String?, int?> variants;

  CartBottomSheet(
      {required this.product,
      this.selectedOptions,
      required this.isBuy,
      required this.priceOptionPrice,
      this.callback,
      required this.variants});

  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  int selectedQty = 1;

  void selectProductQty(value) {
    setState(() {
      selectedQty = value;
    });
    print(selectedQty);
  }

  @override
  Widget build(BuildContext context) {
    // Variation _variation = Variation();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Color(0xff757575),
          child: Container(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: Consumer<ProductDetailsProvider>(
              builder: (context, details, child) {
                List<String> _variationList = [];
                for (int index = 0;
                    index < widget.product.choiceOptions.length;
                    index++) {
                  _variationList.add(widget.product.choiceOptions[index]
                      .options![details.variationIndex[index]]
                      .replaceAll(' ', ''));
                }

                double priceWithDiscount = double.parse('2000');

                double priceWithQuantity = priceWithDiscount * details.quantity;

                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Close Button
                      BottomSheetCloseButton(),

                      // Product details
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            padding:
                                EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            decoration: BoxDecoration(
                              color: ColorResources.getImageBg(context),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.network(
                                (widget.product.image?.imageUrl == null
                                    ? ''
                                    : widget.product.image?.imageUrl!)!),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.product.description!.name ?? '',
                                      style: titilliumSemiBold.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_LARGE),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                  Text(
                                    '${widget.priceOptionPrice}',
                                    style: titilliumBold.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    '${widget.product.originalPrice}',
                                    style: titilliumRegular.copyWith(
                                        color: Theme.of(context).hintColor,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ]),
                          ),
                          Expanded(child: SizedBox.shrink()),
                          Container(
                            height: 20,
                            margin: EdgeInsets.only(
                                top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              '${widget.priceOptionPrice}',
                              style: titilliumRegular.copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                            ),
                          ),
                        ],
                      ),

                      //Quantity dropdown
                      QuantityDropDown(selectProductQty),

                      Row(
                        children: [
                          Text(getTranslated('total_price', context)!,
                              style: robotoBold),
                          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                          Text(
                            '${selectedQty * widget.priceOptionPrice!}',
                            style: titilliumBold.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                      // Cart button
                      CustomButton(
                          buttonText: widget.isBuy
                              ? getTranslated('buy_now', context)
                              : getTranslated('add_to_cart', context),
                          onTap: () {
                            Navigator.pop(context);
                            if (widget.isBuy) {
                            } else {
                              Provider.of<CartProvider>(context, listen: false)
                                  .addToCart(
                                      productId: widget.product.id,
                                      selectedOptions: widget.selectedOptions!,
                                      quantity: selectedQty,
                                      variants: widget.variants,
                                      promocode: '');
                              widget.callback!();
                            }
                          }),
                    ]);
              },
            ),
          ),
        ),
      ],
    );
  }

  Button({Text? child, Color? color, Null Function()? onPressed}) {}
}

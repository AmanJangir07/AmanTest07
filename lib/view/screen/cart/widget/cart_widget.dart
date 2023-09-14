import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopiana/data/model/response/cart_model.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/provider/cart_provider.dart';
import 'package:shopiana/provider/product_details_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/view/basewidget/button/quantity_drop_down.dart';
import 'package:shopiana/view/screen/home/home_screen.dart';

class CartWidget extends StatefulWidget {
  final Product? product;
  final int index;
  final bool fromCheckout;
  const CartWidget(
      {Key? key,
      this.product,
      required this.index,
      required this.fromCheckout});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  int selectedQty = 1;
  bool quantityChange = false;
  bool isRemoved = false;

  void selectProductQty(value) {
    setState(() {
      selectedQty = value;
    });
  }

  removeCartItem(BuildContext context) async {
    setState(() {
      isRemoved = true;
    });
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);

    await cartProvider.removeFromCart(widget.product!.id);

    setState(() {
      isRemoved = false;
    });
  }

  void updateQuantity(int? quantity) async {
    setState(() {
      quantityChange = true;
    });
    await Provider.of<CartProvider>(context, listen: false)
        .updateProductQuantity(
            productId: widget.product?.id, quantity: quantity);

    setState(() {
      quantityChange = false;
    });
  }

  TextEditingController quantityController = new TextEditingController();
  int? _chosenValue = 1;

  List<int> quantityValueList = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
  ];

  dynamic _getTenPlusQuantity(value) {
    setState(
      () {
        Provider.of<ProductDetailsProvider>(context, listen: false)
            .setQuantity(int.parse(value));
        _chosenValue = int.parse(value);
      },
    );
    // Navigator.of(context).pop();
    Navigator.of(context).pop();
    quantityController.clear();
  }

  // @override
  // void initState() {
  //   cartModel = Provider.of<CartProvider>(context).cartData;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    CartModel? cartModel = Provider.of<CartProvider>(context).cartData;
    Product? product = cartModel?.products
        ?.firstWhere((element) => element.id == widget.product?.id);
    return Container(
      margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(color: Theme.of(context).accentColor),
      child: Row(children: [
        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Image.network(
            (widget.product?.image?.imageUrl == null
                ? ''
                : widget.product?.image?.imageUrl!)!,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Image.asset(
                Constants.DEFAULT_NO_IMAGE_SRC.isEmpty
                    ? ''
                    : Constants.DEFAULT_NO_IMAGE_SRC,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Text('No image');
                },
                height: 50,
                width: 40,
              );
            },
            height: 50,
            width: 40,
          ),
        ),
        Expanded(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.product!.description!.name!,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Container(
                      // width: 50,
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      alignment: Alignment.center,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(10),
                      //   border: Border.all(
                      //       color: ColorResources.getPrimary(context)),
                      // ),
                      child: Text(
                        widget.product!.productPrice!.finalPrice!,
                      ),
                    ),
                  ],
                ),
                // !fromCheckout
                //     ? Row(children: [
                //         Padding(
                //           padding: EdgeInsets.only(
                //               right: Dimensions.PADDING_SIZE_SMALL),
                //           child: QuantityButton(
                //               isIncrement: false,
                //               index: index,
                //               quantity: product.quantity),
                //         ),
                //         Text(product.quantity.toString(),
                //             style: titilliumSemiBold),
                //         Padding(
                //           padding: EdgeInsets.symmetric(
                //               horizontal: Dimensions.PADDING_SIZE_SMALL),
                //           child: QuantityButton(
                //               isIncrement: true,
                //               index: index,
                //               quantity: product.quantity),
                //         ),
                //         ...product.cartItemattributes
                //             .map((attr) => Text(attr.optionValue.name + " "))
                //             .toList(),
                //       ])
                //     : SizedBox.shrink(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<int>(
                      // alignment: Alignment.center,
                      // value: _chosenValue,
                      value: null,
                      elevation: 5,
                      /*  onChanged: (_) {
                        updateQuantity();
                      }, */
                      style: TextStyle(color: Colors.black),
                      hint: quantityChange
                          ? Container(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ))
                          : Text(
                              "qty. ${product!.quantity}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                      // alignment: Alignment.center,
                      items: [
                        ...quantityValueList.map<DropdownMenuItem<int>>(
                          (int value) {
                            return DropdownMenuItem<int>(
                                value: value,
                                child: Text(value.toString()),
                                onTap: () {
                                  print("VALUE IS + ");
                                  print(value);
                                  updateQuantity(value);
                                }
                                // alignment: Alignment.center,
                                );
                          },
                        ).toList(),
                        DropdownMenuItem<int>(
                          child: InkWell(
                            onTap: () {
                              _buildPopupDialog(context, _getTenPlusQuantity);
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: 50,
                              height: 50,
                              child: Text(
                                "10+",
                              ),
                            ),
                          ),
                          value: _chosenValue,
                        ),
                      ],

                      onChanged: (int? value) {
                        setState(() {
                          _chosenValue = value;
                        });
                      },
                    ),
                    Text('x ${widget.product?.productPrice?.finalPrice}'),
                    !widget.fromCheckout
                        ? !isRemoved
                            ? IconButton(
                                onPressed: () => removeCartItem(context),
                                icon: Icon(Icons.cancel,
                                    color: ColorResources.RED),
                              )
                            : CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              )
                        : SizedBox.shrink(),
                  ],
                ),
                ...widget.product!.cartItemattributes!.map((optionAttribute) {
                  return Text(
                      '${optionAttribute.productOption!.code}: ${optionAttribute.optionValue!.code}');
                }).toList()
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void _buildPopupDialog(context, callbackQunatityFn) {
    showDialog(
      context: context,
      builder: (ctx) {
        return new AlertDialog(
          title: const Text('Enter your quantity'),
          content: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: quantityController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            new TextButton(
              onPressed: () {
                if (quantityController.text.isNotEmpty) {
                  callbackQunatityFn(quantityController.text);
                  //_getTenPlusQuantity(quantityController.text);
                  updateQuantity(_chosenValue);
                  Navigator.of(context).pop();
                } else {}
                // Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
            new TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class QuantityButton extends StatelessWidget {
  final bool isIncrement;
  final int quantity;
  final int index;
  QuantityButton(
      {required this.isIncrement, required this.quantity, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isIncrement && quantity > 1) {
          // Provider.of<CartProvider>(context, listen: false)
          //     .setQuantity(false, index);
        } else if (isIncrement && quantity < 10) {
          // Provider.of<CartProvider>(context, listen: false)
          //     .setQuantity(true, index);
        }
      },
      child: Icon(
        isIncrement ? Icons.add_circle : Icons.remove_circle,
        color: isIncrement
            ? ColorResources.getPrimary(context)
            : quantity > 1
                ? ColorResources.getPrimary(context)
                : ColorResources.getGrey(context),
        size: 20,
      ),
    );
  }
}

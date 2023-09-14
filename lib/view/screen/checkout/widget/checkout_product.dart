import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/dimensions.dart';

class CheckoutProduct extends StatelessWidget {
  final Product? product;
  final int index;
  const CheckoutProduct({
    Key? key,
    this.product,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Image.network(
                  product!.image!.imageUrl!,
                  height: 60,
                  width: 60,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_LARGE),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(product.id.toString(),
                      //     maxLines: 2,
                      //     overflow: TextOverflow.ellipsis,
                      //     style: titilliumBold.copyWith(
                      //       fontSize: Dimensions.FONT_SIZE_SMALL,
                      //       color: ColorResources.getHint(context),
                      //     )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              product!.description!.name!,
                              overflow: TextOverflow.clip,
                              // PriceConverter.convertPrice(context, product.price),
                              // style: titilliumSemiBold.copyWith(
                              //     color: ColorResources.getPrimary(context)),
                            ),
                          ),
                          Container(
                            width: 50,
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: ColorResources.getPrimary(context)),
                            ),
                            child: Text(product!.price.toString()
                                // PriceConverter.percentageCalculation(
                                //     context,
                                //     product.price.toString(),
                                //     product.discount.toString(),
                                //     product.discountType),
                                // textAlign: TextAlign.center,
                                // style: titilliumRegular.copyWith(
                                //     fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                //     color: ColorResources.getHint(context)),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Divider(),
          // Container(
          //   padding: EdgeInsets.all(5.0),
          //   // color: Colors.red,

          //   width: double.infinity,
          //   child: Text(
          //     'Remove',
          //     textAlign: TextAlign.center,
          //   ),
          // ),
        ],
      ),
    );
  }
}

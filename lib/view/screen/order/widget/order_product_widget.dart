import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/order_details.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';

class OrderProductWidget extends StatelessWidget {
  final OrderDetailsModel orderDetailsModel;
  OrderProductWidget({required this.orderDetailsModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(color: ColorResources.WHITE),
      child: Row(children: [
        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Image.network(
            orderDetailsModel.productDetails!.image.toString(),
            height: 50,
            width: 50,
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
              Text('abc',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: titilliumRegular.copyWith(
                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                    color: ColorResources.HINT_TEXT_COLOR,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    //PriceConverter.convertPrice(context, cartModel.price),
                    '200',
                    style: titilliumSemiBold.copyWith(
                        color: ColorResources.COLOR_PRIMARY),
                  ),
                  Container(
                    width: 50,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ColorResources.COLOR_PRIMARY),
                    ),
                    child: Text('${100}% OFF',
                        textAlign: TextAlign.center,
                        style: titilliumRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          color: ColorResources.HINT_TEXT_COLOR,
                        )),
                  ),
                  Container(
                    width: 50,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ColorResources.COLOR_PRIMARY,
                    ),
                    child: Text(getTranslated('review', context)!,
                        textAlign: TextAlign.center,
                        style: titilliumRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          color: ColorResources.WHITE,
                        )),
                  ),
                ],
              ),
            ],
          ),
        )),
      ]),
    );
  }
}

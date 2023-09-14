import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/order_details.dart';
import 'package:shopiana/helper/price_converter.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/order_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/screen/product/review_dialog.dart';
import 'package:provider/provider.dart';

class OrderDetailsWidget extends StatelessWidget {
  final OrderDetailsModel? orderDetailsModel;
  final Function? callback;
  OrderDetailsWidget({this.orderDetailsModel, this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (Provider.of<OrderProvider>(context, listen: false).orderTypeIndex ==
            1) {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => ReviewBottomSheet(
                  productID: orderDetailsModel!.productDetails!.id.toString(),
                  callback: callback));
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                  orderDetailsModel!.productDetails!.image.toString(),
                  fit: BoxFit.scaleDown,
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: Dimensions.MARGIN_SIZE_DEFAULT),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              orderDetailsModel!.productDetails!.description!.name!,
                              style: titilliumSemiBold.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_SMALL,
                                  color: Theme.of(context).hintColor),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Provider.of<OrderProvider>(context).orderTypeIndex ==
                                  1
                              ? Container(
                                  margin: EdgeInsets.only(
                                      left: Dimensions.PADDING_SIZE_SMALL),
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                      horizontal:
                                          Dimensions.PADDING_SIZE_SMALL),
                                  decoration: BoxDecoration(
                                    color: ColorResources.getPrimary(context),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1,
                                        color: ColorResources.COLUMBIA_BLUE),
                                  ),
                                  child: Text(getTranslated('review', context)!,
                                      style: titilliumRegular.copyWith(
                                        fontSize:
                                            Dimensions.FONT_SIZE_EXTRA_SMALL,
                                        color: Theme.of(context).accentColor,
                                      )),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                      SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            PriceConverter.convertPrice(
                                context, double.parse(orderDetailsModel!.price!)),
                            style: titilliumSemiBold.copyWith(
                                color: ColorResources.getPrimary(context)),
                          ),
                          Text('x${orderDetailsModel!.qty}',
                              style: titilliumSemiBold.copyWith(
                                  color: ColorResources.getPrimary(context))),
                          Container(
                            height: 20,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: ColorResources.getPrimary(context))),
                            child: Text(
                              PriceConverter.percentageCalculation(
                                  context,
                                  (double.parse(orderDetailsModel!.price!) *
                                          double.parse(orderDetailsModel!.qty!))
                                      .toString(),
                                  orderDetailsModel!.discount,
                                  'amount'),
                              style: titilliumRegular.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                  color: ColorResources.getPrimary(context)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

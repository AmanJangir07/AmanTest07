import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/data/model/response/config_model.dart';
import 'package:shopiana/data/model/response/order_model.dart';
import 'package:shopiana/helper/price_converter.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/splash_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/utill/util.dart';
import 'package:shopiana/view/screen/order/widget/order_status_indicator.dart';
import 'package:shopiana/view/screen/orderDetails/order_details_screen.dart';

class OrderWidget extends StatelessWidget {
  final Order? order;
  OrderWidget({this.order});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    double _containerHeight = MediaQuery.of(context).size.height * 0.17;
    ConfigModel config =
        Provider.of<SplashProvider>(context, listen: false).configModel!;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(order: order)));
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        child: Container(
          height: _containerHeight,

          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_width * 0.03)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: _containerHeight * 0.3,
                        width: _containerHeight * 0.35,
                        child: order!.products![0].image != null
                            ? Image.network(
                                order!.products![0].product!.image!.imageUrl!,
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                Images.no_image,
                                fit: BoxFit.fill,
                              ),
                      ),
                      SizedBox(
                        width: _width * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: _width * 0.6,
                              child: Text(
                                order!.products![0].productName!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: _width * 0.04),
                              ),
                            ),
                            Container(
                              width: _width * 0.73,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${config.currency} ${order!.total!.value}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: _width * 0.035),
                                  ),
                                  order!.products!.length <= 1
                                      ? Text('${order!.products!.length} Item',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey))
                                      : Text('${order!.products!.length} Items',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: _containerHeight * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order #${order!.id}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _width * 0.04)),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text(
                          Util.getDynamicDate(order!.datePurchased),
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _containerHeight * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          OrderStatusIndicator(
                              order!.orderStatus!, _containerHeight),
                          SizedBox(
                            width: _width * 0.015,
                          ),
                          Text(
                            "${order?.orderStatus?.toUpperCase()}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: _width * 0.03),
                          ),
                        ],
                      ),
                      order?.paymentType != null
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(_width * 0.01),
                                color: Util.paymentModeBackgroundColor(
                                    order!.paymentType),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  "${order!.paymentType}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: _width * 0.03),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  )
                ],
              ),
            ),
            // color: Colors.red,
          ),

          // margin: EdgeInsets.only(
          //     bottom: Dimensions.PADDING_SIZE_SMALL,
          //     left: Dimensions.PADDING_SIZE_SMALL,
          //     right: Dimensions.PADDING_SIZE_SMALL),
          // padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          // decoration: BoxDecoration(
          //     color: Theme.of(context).accentColor,
          //     borderRadius: BorderRadius.circular(5)),
          // child: Row(children: [
          //   Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //     Row(children: [
          //       Text(getTranslated('ORDER_ID', context),
          //           style: titilliumRegular.copyWith(
          //               fontSize: Dimensions.FONT_SIZE_SMALL)),
          //       SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          //       Text(order.id.toString(), style: titilliumSemiBold),
          //     ]),
          //     Row(children: [
          //       Text(getTranslated('order_date', context),
          //           style: titilliumRegular.copyWith(
          //               fontSize: Dimensions.FONT_SIZE_SMALL)),
          //       SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          //       Text(order.datePurchased,
          //           style: titilliumRegular.copyWith(
          //             fontSize: Dimensions.FONT_SIZE_SMALL,
          //             color: Theme.of(context).hintColor,
          //           )),
          //     ]),
          //   ]),
          //   SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
          //   Expanded(
          //     child:
          //         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //       Text(getTranslated('total_price', context),
          //           style: titilliumRegular.copyWith(
          //               fontSize: Dimensions.FONT_SIZE_SMALL)),
          //       Text(order.total.value.toString(), style: titilliumSemiBold),
          //     ]),
          //   ),
          //   Container(
          //     alignment: Alignment.center,
          //     padding:
          //         EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
          //     decoration: BoxDecoration(
          //       color: ColorResources.getLowGreen(context),
          //       borderRadius: BorderRadius.circular(5),
          //     ),
          //     child:
          //         Text(order.orderStatus.toUpperCase(), style: titilliumSemiBold),
          //   ),
          // ]),
        ),
      ),
    );
  }
}

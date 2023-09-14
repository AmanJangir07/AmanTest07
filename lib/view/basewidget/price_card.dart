import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/cart_model.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/dimensions.dart';

class PriceCard extends StatelessWidget {
  final List<Totals>? totals;

  const PriceCard({required this.totals});

  @override
  Widget build(BuildContext context) {
    return totals != null
        ? Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text('item total'),
                //     Text(total.toString()),
                //   ],
                // ),
                // SizedBox(height: 10),
                // ListView.builder(
                //   itemCount: 3,
                //   itemBuilder: (context, index) => Container(
                //     child: Text('test'),
                //   ),
                // ),

                for (var item in totals!)
                  if (item.code == 'order.total.subtotal')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total MRP',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(item.value!.toString()),
                      ],
                    )
                  else if (item.code == 'order.total.tax')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Tax',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(item.value!.toString()),
                      ],
                    )
                  else if (item.code == 'order.total.shipping')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Shipping',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(item.value!.toString()),
                      ],
                    )
                  else if (item.code == 'order.total.discount')
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Coupon Discount',
                            style: TextStyle(
                                color: ColorResources.GREEN,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            item.value.toString(),
                            style: TextStyle(
                                color: ColorResources.GREEN,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  else if (item.code == 'order.total.total') ...[
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.FONT_SIZE_LARGE),
                        ),
                        Text(
                          item.value.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.FONT_SIZE_LARGE),
                        ),
                      ],
                    ),
                  ],
                // const Divider(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'Grand Total',
                //       style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: Dimensions.FONT_SIZE_LARGE),
                //     ),
                //     Text(
                //       '\$290',
                //       style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: Dimensions.FONT_SIZE_LARGE),
                //     ),
                //   ],
                // ),
                // const Divider(),
                // Text(
                //   'Average Dilvery time: 4-5 hours',
                //   style: TextStyle(
                //       color: Theme.of(context).textTheme.bodyText1.color),
                // ),
              ],
            ),
          )
        : Text('');
  }
}

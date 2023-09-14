import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/order_checkout_response.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/basewidget/price_card.dart';
import 'package:shopiana/view/screen/dashboard/dashboard_screen.dart';
import 'package:shopiana/view/screen/home/home_screen.dart';

// class OrderSummaryScreen {
//   OrderCheckoutResponse orderCheckoutSummary;
//   OrderSummaryScreen({@required this.orderCheckoutSummary});
// }

class OrderSummaryScreen extends StatelessWidget {
  final OrderCheckoutResponse? orderCheckoutSummary;
  OrderSummaryScreen({
    required this.orderCheckoutSummary,
  });

  @override
  Widget build(BuildContext context) {
    return orderCheckoutSummary != null
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text("Order Summary"),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashBoardScreen()),
                      (route) => true);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    'Continue Shopping',
                    style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
              ),
            ),
            // appBar: AppBar(
            //   // automaticallyImplyLeading: false,
            //   title: Row(children: [
            //     InkWell(
            //       child: Icon(Icons.arrow_back_ios,
            //           color: Theme.of(context).textTheme.bodyText1.color, size: 20),
            //       onTap: () => Navigator.pop(context),
            //     ),

            //     SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
            //     Text("Order Complete",
            //         style: robotoRegular.copyWith(
            //             fontSize: 20,
            //             color: Theme.of(context).textTheme.bodyText1.color)),
            //   ]),
            //   automaticallyImplyLeading: false,
            //   elevation: 0,
            //   backgroundColor: Provider.of<ThemeProvider>(context).darkTheme
            //       ? Colors.black
            //       : Colors.white.withOpacity(0.5),
            // ),
            body: Container(
                child: orderCheckoutSummary != null
                    ? Padding(
                        padding:
                            EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'Your Order Id: ${orderCheckoutSummary!.id}',
                                  style: TextStyle(
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Your item(${orderCheckoutSummary!.products!.length})',
                                    style: TextStyle(
                                        fontSize: Dimensions.FONT_SIZE_LARGE,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Subtotal',
                                    style: TextStyle(
                                        fontSize: Dimensions.FONT_SIZE_LARGE,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Divider(
                                // thickness: 1.10,
                                color: Colors.blueGrey,
                              ),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      orderCheckoutSummary!.products!.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 60,
                                              child: Image.network(
                                                '${orderCheckoutSummary!.products![index].product!.image!.imageUrl}',
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 120,
                                                  child: Text(
                                                      '${orderCheckoutSummary!.products![index].productName}'),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                    'Qty: ${orderCheckoutSummary!.products![index].orderedQuantity}')
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                            '${orderCheckoutSummary!.products![index].subTotal}')
                                      ],
                                    );
                                  }),
                              Divider(
                                // thickness: 1.10,
                                color: Colors.blueGrey,
                              ),
                              PriceCard(
                                  totals:
                                      orderCheckoutSummary!.orderTotals!.totals),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: Text('Something went Wrong'),
                      )),
          )
        : Text('data not available');
  }
}

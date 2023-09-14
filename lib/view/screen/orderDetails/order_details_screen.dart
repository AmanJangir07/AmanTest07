import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/data/model/response/order_model.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/theme_provider.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/utill/util.dart';
import 'package:shopiana/view/basewidget/animated_custom_dialog.dart';
import 'package:shopiana/view/basewidget/price_card.dart';
import 'package:shopiana/view/screen/dashboard/dashboard_screen.dart';
import 'package:shopiana/view/screen/home/home_screen.dart';
import 'package:shopiana/view/screen/order/widget/order_details_widget.dart';
import 'package:shopiana/view/screen/orderDetails/widget/delievery_widget.dart';
import 'package:shopiana/view/screen/orderDetails/widget/order_cancelation_confirmation_dailog.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order? order;
  OrderDetailsScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        leading: InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () => Navigator.of(context).pop()),
        title: Text("Order Details",
            style: TextStyle(fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Provider.of<ThemeProvider>(context).darkTheme
            ? Colors.black
            : Colors.white.withOpacity(0.5),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      //   child: OutlinedButton(
      //     onPressed: () {
      //       Navigator.of(context)
      //           .push(MaterialPageRoute(builder: (context) => HomePage()));
      //     },
      //     child: Padding(
      //       padding: const EdgeInsets.all(10.0),
      //       child: const Text(
      //         'Continue Shopping',
      //         style: TextStyle(
      //           fontSize: Dimensions.FONT_SIZE_DEFAULT,
      //           fontWeight: FontWeight.w500,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10),
        child: OutlinedButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DashBoardScreen()));
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: const Text(
              'Continue Shopping',
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Container(
          child: order != null
              ? Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Order Id",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: _width * 0.04),
                                ),
                                Text(
                                  "${order?.billing?.firstName} ${order?.billing?.lastName}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: _width * 0.04),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "#${order?.id}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: _width * 0.04),
                                ),
                                Text(
                                  "${order?.billing?.city},${order?.billing?.zone}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: _width * 0.029),
                                )
                              ],
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                  Util.getDynamicDate(order!.datePurchased),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: _width * 0.03)),
                            )
                          ],
                        ),

                        /* Container(
                          height: _height * 0.1,
                          child: Row(children: [
                            Container(
                              height: _height * 0.07,
                              width: _width * 0.23,
                              child: TimelineTile(
                                indicatorStyle: IndicatorStyle(
                                    color: Colors.green,
                                    iconStyle:
                                        IconStyle(iconData: Icons.check)),
                                isFirst: true,
                                startChild: Text("Ordered"),
                                afterLineStyle: LineStyle(color: Colors.green),
                                /* endChild: Container(
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red)),
                                      child: Text("Cancel Order")),
                                ), */
                                axis: TimelineAxis.horizontal,
                                alignment: TimelineAlign.manual,
                                lineXY: 0.45,
                              ),
                            ),
                            Container(
                              height: _height * 0.07,
                              width: _width * 0.23,
                              child: TimelineTile(
                                afterLineStyle: LineStyle(color: Colors.green),
                                indicatorStyle: IndicatorStyle(
                                    color: Colors.blueAccent,
                                    iconStyle:
                                        IconStyle(iconData: Icons.lock_clock)),
                                startChild: Text("Processed"),
                                axis: TimelineAxis.horizontal,
                                alignment: TimelineAlign.manual,
                                lineXY: 0.45,
                              ),
                            ),
                            Container(
                              height: _height * 0.07,
                              width: _width * 0.23,
                              child: TimelineTile(
                                afterLineStyle: LineStyle(color: Colors.green),
                                indicatorStyle: IndicatorStyle(
                                    color: Colors.blue,
                                    iconStyle:
                                        IconStyle(iconData: Icons.lock_clock)),
                                startChild: Text("Dispatched"),
                                axis: TimelineAxis.horizontal,
                                alignment: TimelineAlign.manual,
                                lineXY: 0.45,
                              ),
                            ),
                            Container(
                              height: _height * 0.07,
                              width: _width * 0.23,
                              child: TimelineTile(
                                afterLineStyle: LineStyle(color: Colors.green),  
                                indicatorStyle: IndicatorStyle(
                                    color: Colors.blue,
                                    iconStyle:
                                        IconStyle(iconData: Icons.lock_clock)),
                                isLast: true,
                                startChild: Text("Delievered"),
                                axis: TimelineAxis.horizontal,
                                alignment: TimelineAlign.manual,
                                lineXY: 0.45,
                              ),
                            ),
                          ]),
                        ), */
                        /* Container(
                          height: _height * 0.15,
                          width: _width * 8,
                          child: Stepper(
                              currentStep: 0,
                              type: StepperType.horizontal,
                              steps: [
                                Step(
                                  title: Text("Ordered"),
                                  content: ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red)),
                                      child: Text("Cancel Order")),
                                ),
                                Step(
                                    title: Text("Processed"),
                                    content: SizedBox()),
                                Step(
                                    title: Text("Dispatched"),
                                    content: SizedBox()),
                                Step(
                                    title: Text("Delivered"),
                                    content: SizedBox())
                              ]),
                        ), */
                        /*  Column(children: [
                          Row(children: [
                            Text("ORDER STATUS :"),
                            SizedBox(
                              width: _width * 0.1,
                            ),
                            Text(order?.orderStatus)
                          ]),
                          ElevatedButton(
                              onPressed: () {
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              child: Text("Cancel Order"))
                        ]), */
                        order?.orderStatus == "CANCELED"
                            ? Column(
                                children: [
                                  Divider(
                                    color: Colors.blueGrey,
                                  ),
                                  Text(
                                    "Order has been Canceled",
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  Divider(
                                    color: Colors.blueGrey,
                                  ),
                                  DeliveryTimeline(order?.orderStatus),
                                ],
                              ),
                        order?.orderStatus == "ORDERED"
                            ? Column(
                                children: [
                                  Divider(
                                    color: Colors.blueGrey,
                                  ),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red)),
                                      onPressed: () {
                                        showAnimatedDialog(
                                            context,
                                            CancelOrderConfirmationDialog(
                                                order?.id),
                                            isFlip: true);
                                      },
                                      child: Text("Cancel Order"))
                                ],
                              )
                            : SizedBox(),
                        Divider(
                          color: Colors.blueGrey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            order!.productItemCount! > 1
                                ? Text(
                                    'Your items (${order?.products?.length})',
                                    style: TextStyle(
                                        fontSize: Dimensions.FONT_SIZE_LARGE,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text('Your item (${order?.products?.length})',
                                    style: TextStyle(
                                        fontSize: Dimensions.FONT_SIZE_LARGE,
                                        fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Divider(
                          // thickness: 1.10,
                          color: Colors.blueGrey,
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: order?.products?.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        child: order?.products![index].product
                                                    ?.image?.imageUrl !=
                                                null
                                            ? Image.network(
                                                '${order?.products![index].product?.image?.imageUrl}',
                                              )
                                            : Image.asset(Images.no_image),
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
                                              '${order?.products![index].productName}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Qty: ${order?.products![index].orderedQuantity} X ${order?.products![index].subTotal}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(children: [
                                    SizedBox(
                                      height: _height * 0.065,
                                    ),
                                    Text(
                                      '${order?.products![index].subTotal}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )
                                  ])
                                ],
                              );
                            }),
                        Divider(
                          // thickness: 1.10,
                          color: Colors.blueGrey,
                        ),
                        PriceCard(totals: order?.totals),
                        Divider(
                          color: Colors.blueGrey,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Your details",
                                style: TextStyle(
                                    fontSize: _height * 0.026,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: _height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: _width * 0.3,
                                  child: Text(
                                    "Your Name:",
                                    textAlign: TextAlign.start,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                    width: _width * 0.6,
                                    child: Text(
                                      order?.customer?.firstName ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: _width * 0.3,
                                  child: Text(
                                    "Mobile:",
                                    textAlign: TextAlign.start,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: _width * 0.6,
                                  child: Text(
                                    order?.billing?.phone ?? "",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: _width * 0.3,
                                  child: Text(
                                    "Address:",
                                    textAlign: TextAlign.start,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: _width * 0.6,
                                  child: Text(
                                    order?.billing?.address ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: _width * 0.3,
                                  child: Text(
                                    "City:",
                                    textAlign: TextAlign.start,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: _width * 0.6,
                                  child: Text(
                                    order?.billing?.city ?? "",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: _width * 0.3,
                                  child: Text(
                                    "Pincode:",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: _width * 0.6,
                                  child: Text(
                                    order?.billing?.postalCode ?? "",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                order?.customerGstNumber != null
                                    ? Container(
                                        width: _width * 0.3,
                                        child: Text(
                                          "Customer Gst Number:",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 0,
                                      ),
                                Container(
                                  width: _width * 0.6,
                                  child: Text(
                                    order?.customerGstNumber ?? "",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: _width * 0.3,
                                  child: Text(
                                    "Payment:",
                                    textAlign: TextAlign.start,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: _width * 0.6,
                                  child: Text(
                                    (order?.paymentType != null
                                        ? order?.paymentType!
                                        : "COD")!,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Text('Details Not available'),
                )),
    );
  }
}

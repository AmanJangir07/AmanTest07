import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/order_model.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/view/screen/order/widget/order_shimmer.dart';
import 'package:shopiana/view/screen/orderDetails/order_details_screen.dart';

class MyOrderListTile extends StatelessWidget {
  final List<Order> orders;

  const MyOrderListTile({
    required this.orders,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return orders.length > 0 || orders.length != null
        ? ListView.builder(
            itemCount: orders.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderDetailsScreen(
                        order: orders[index],
                      ),
                    ),
                  );
                },
                leading: orders[index].products![0].product!.image != null
                    ? Container(
                        height: _height * 0.06,
                        width: _height * 0.06,
                        child: Image.network(
                            orders[index].products![0].product!.image!.imageUrl!),
                      )
                    : Container(
                        height: _height * 0.06,
                        width: _height * 0.06,
                        child: Image.asset(
                          Constants.DEFAULT_NO_IMAGE_SRC,
                        ),
                      ),
                title: Text('Order Id : ${orders[index].id}'),
                subtitle: Text('Date :${orders[index].datePurchased}'),
                trailing: Icon(Icons.more_vert),
                isThreeLine: true,
              );
            })
        : OrderShimmer();
  }
}

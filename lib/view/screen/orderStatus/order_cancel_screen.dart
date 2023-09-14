import 'package:flutter/material.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/view/screen/dashboard/dashboard_screen.dart';

class OrderCancelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    // while (Navigator.canPop(context)) {
    //   // Navigator.canPop return true if can pop
    //   Navigator.pop(context);
    // }

    void popScreen(BuildContext context) {
      while (Navigator.canPop(context)) {
        // Navigator.canPop return true if can pop
        Navigator.pop(context);
      }
    }

    return Scaffold(
      body:
          // orderSummeryDetails != null
          //     ?
          Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Images.order_failure,
              width: _width * 0.7,
              height: _height * 0.35,
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              thickness: 1,
              endIndent: _width * 0.05,
              indent: _width * 0.05,
            ),
            // Icon(
            //   Icons.check_circle,
            //   color: Colors.green,
            //   size: Dimensions.ICON_SIZE_EXTRA_LARGE,
            // ),
            SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),
            Text(
              "Your order has been Cancelled",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
            ),
            SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
            // Text(
            //   'You will receive a confirmation message shortly.',
            //   style: TextStyle(fontWeight: FontWeight.w500),
            // ),
            SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                  ElevatedButton(
                    style: ButtonStyle(
                        // foregroundColor:
                        //     MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_width * 0.03),
                        ))),
                    // color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => DashBoardScreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text(
                      'Continue Shopping',
                      style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // CustomButton(
                  //   buttonText: "Continue Shopping",
                  //   onTap: () {},
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

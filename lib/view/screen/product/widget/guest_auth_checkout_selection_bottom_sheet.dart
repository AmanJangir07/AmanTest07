import 'package:flutter/material.dart';
import 'package:shopiana/view/basewidget/button/custom_button.dart';
import 'package:shopiana/view/basewidget/button/custom_button_full_width.dart';
import 'package:shopiana/view/screen/checkoutAddress/widget/guest_user_address.dart';

class GuestAuthCheckoutSelectionBottomSheet extends StatelessWidget {
  const GuestAuthCheckoutSelectionBottomSheet();

  void orderAsGuest(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => GuestUserAddress()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButtonFullWidth(
              buttonText: "Order As Guest",
              color: Colors.green,
              onTap: () => orderAsGuest(context),
            ),
            CustomButtonFullWidth(buttonText: "Login", color: Colors.teal)
          ],
        ),
      ),
    );
  }
}

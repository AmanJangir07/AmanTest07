import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/data/model/response/cart_model.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/cart_provider.dart';
import 'package:shopiana/provider/coupon_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/basewidget/button/bottom_sheet_close_button.dart';
import 'package:shopiana/view/basewidget/button/custom_button.dart';
import 'package:shopiana/view/basewidget/show_custom_snakbar.dart';
import 'package:shopiana/view/basewidget/textfield/custom_textfield.dart';

class CouponBottomSheet extends StatefulWidget {
  const CouponBottomSheet({Key? key}) : super(key: key);

  @override
  State<CouponBottomSheet> createState() => _CouponBottomSheetState();
}

class _CouponBottomSheetState extends State<CouponBottomSheet> {
  final FocusNode _couponCodeFocus = FocusNode();
  TextEditingController _couponCodeController = new TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    void applyCoupon() async {
      CartModel? applyCouponResponse =
          await Provider.of<CartProvider>(context, listen: false)
              .applyCoupon(_couponCodeController.text);
      if (applyCouponResponse != null) {
        showCustomSnackBar(
            getTranslated('coupon_apply_successfully', context)!, context,
            isError: false);
        Navigator.pop(context);
      } else {
        showCustomSnackBar(
            getTranslated('something_went_wrong', context)!, context,
            isError: true);
        Navigator.pop(context);
      }
    }

    Future<void> getCoupons() async {
      await Provider.of<CouponProvider>(context, listen: false)
          .getCoupons(context: context);
    }

    return Container(
      padding: MediaQuery.of(context).viewInsets,
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL,
          left: Dimensions.PADDING_SIZE_SMALL,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomSheetCloseButton(),
            Container(
              margin: EdgeInsets.all(Dimensions.MARGIN_SIZE_DEFAULT),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_offer_outlined,
                          color: ColorResources.getLightSkyBlue(context),
                          size: 20),
                      SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                      Text(getTranslated('enter_coupon', context)!,
                          style: titilliumRegular)
                    ],
                  ),
                  SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                  CustomTextField(
                    focusNode: _couponCodeFocus,
                    // hintText: profile.userInfoModel.phone ?? "",
                    controller: _couponCodeController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                    future: getCoupons(),
                    builder: (ctx, groupSnapshot) {
                      if (groupSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      } else if (groupSnapshot.hasError) {
                        return Center(
                          child: Text('Something Went Wrong'),
                        );
                      } else {
                        return Consumer<CouponProvider>(
                          builder: (context, couponProvider, child) {
                            return Container(
                              height: 100,
                              child: couponProvider.couponList.length > 0
                                  ? ListView.builder(
                                      itemCount:
                                          couponProvider.couponList.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(children: [
                                                Text(
                                                  couponProvider
                                                      .couponList[index].code!,
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                                Text(
                                                    couponProvider
                                                            .couponList[index]
                                                            .description ??
                                                        "",
                                                    style: TextStyle(
                                                        fontSize: 10)),
                                              ]),
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Theme.of(
                                                                      context)
                                                                  .primaryColor)),
                                                  onPressed: () {
                                                    _couponCodeController.text =
                                                        couponProvider
                                                            .couponList[index]
                                                            .code!;
                                                    applyCoupon();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Apply"))
                                            ]);
                                      })
                                  : Center(child: Text("No Coupon Available")),
                            );
                          },
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      buttonText: getTranslated('apply_coupon', context),
                      onTap: () {
                        if (_couponCodeController.text != null) {
                          applyCoupon();
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

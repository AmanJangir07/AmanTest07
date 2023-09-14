import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/data/model/response/user_info_model.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/profile_provider.dart';
import 'package:shopiana/provider/theme_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/screen/checkoutAddress/widget/update_auth_user_address.dart';
import 'package:shopiana/view/screen/checkoutPayment/checkout_payment_screen.dart';

class AuthUserAddress extends StatefulWidget {
  const AuthUserAddress();

  @override
  State<AuthUserAddress> createState() => _AuthUserAddressState();
}

class _AuthUserAddressState extends State<AuthUserAddress> {
  int? active;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => CheckoutPaymentScreen(),
                  ),
                  (Route<dynamic> route) => true);
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                getTranslated('continue', context)!,
                style: titilliumSemiBold.copyWith(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    color: Theme.of(context).accentColor),
              ),
            ),
          )),
      appBar: AppBar(
        title: Row(children: [
          InkWell(
            child: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).textTheme.bodyText1!.color, size: 20),
            onTap: () => Navigator.pop(context),
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Text(getTranslated('selectAddress', context)!,
              style: robotoRegular.copyWith(
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodyText1!.color)),
        ]),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Provider.of<ThemeProvider>(context).darkTheme
            ? Colors.black
            : Colors.white.withOpacity(0.5),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          print("profile +" + profile.userInfoModel.toString());
          return Container(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Column(
              children: [
                Card(
                  child: profile.userInfoModel != null
                      ? Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_SMALL),
                          child: Row(
                            // mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Radio<int>(
                                    activeColor: Theme.of(context).primaryColor,
                                    value: 1,
                                    groupValue: 1,
                                    onChanged: (value) {
                                      setState(() {
                                        active = 1;
                                      });
                                    }),
                              ),
                              Expanded(
                                flex: 11,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${profile.userInfoModel?.billing?.firstName} ${profile.userInfoModel?.billing?.lastName}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Dimensions.FONT_SIZE_LARGE),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      '${getTranslated('mobile', context).toString()} : ${profile.userInfoModel?.billing?.phone}',
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      '${profile.userInfoModel?.billing?.address}',
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      '${getTranslated('pin_code', context).toString()} : ${profile.userInfoModel?.billing?.postalCode}',
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: Dimensions.MARGIN_SIZE_DEFAULT,
                                            bottom: Dimensions
                                                .MARGIN_SIZE_EXTRA_SMALL),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateAuthUserAddress(
                                                          userProfile: profile
                                                              .userInfoModel,
                                                        )));
                                          },
                                          child: Container(
                                            height: 50,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            child: Text(
                                              getTranslated(
                                                  'change_address', context)!,
                                              style: titilliumSemiBold.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_LARGE,
                                                  color: Theme.of(context)
                                                      .accentColor),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      : Text(''),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

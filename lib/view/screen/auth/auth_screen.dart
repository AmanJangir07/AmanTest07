import 'package:flutter/material.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/auth_provider.dart';
import 'package:shopiana/provider/profile_provider.dart';
import 'package:shopiana/provider/splash_provider.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/utill/store_constant.dart';
import 'package:shopiana/view/screen/auth/forget_password_screen.dart';
import 'package:shopiana/view/screen/auth/widget/mobile_number_widget.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/view/screen/dashboard/dashboard_screen.dart';

class AuthScreen extends StatelessWidget {
  final int initialPage;
  AuthScreen({this.initialPage = 0});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    Provider.of<ProfileProvider>(context, listen: false).initAddressTypeList();
    Provider.of<AuthProvider>(context, listen: false).isRemember;
    PageController _pageController = PageController(initialPage: initialPage);
    NetworkInfo.checkConnectivity(context);

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: 150,
          ),
          Consumer<AuthProvider>(
            builder: (context, auth, child) => SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /*  Text(
                            "Log In",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: _height * 0.04),
                          ), */
                          SizedBox(
                            width: _width * 0.4,
                          ),
                          if (Provider.of<SplashProvider>(context,
                                  listen: false)
                              .configModel!
                              .allowGuestUser!) // This is dynamically configured
                            Container(
                              alignment: Alignment.centerRight,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DashBoardScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                    getTranslated('SKIP_SIGN_IN', context)!,
                                    style: titilliumRegular.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_SMALL,
                                        color: Theme.of(context).primaryColor)),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        Images.LOGO,
                        height: _height * 0.20,
                        width: _height * 0.20,
                        // color: ColorResources.getPrimary(context),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    MobileNumberWidget(),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ForgetPasswordScreen()));
                        },
                        child: Text(
                          "Forgot Password",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )),
                    SizedBox(
                      height: _height * 0.21,
                    ),
                    Text("2022 © ${StoreConstant.STORE_NAME}")
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

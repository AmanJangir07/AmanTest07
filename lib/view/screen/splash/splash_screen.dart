import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/custom_plugin/new_version.dart';
import 'package:shopiana/provider/auth_provider.dart';
import 'package:shopiana/provider/splash_provider.dart';
import 'package:shopiana/provider/theme_provider.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/utill/store_constant.dart';
import 'package:shopiana/view/basewidget/update_dialog.dart';
import 'package:shopiana/view/screen/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopiana/view/screen/splash/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initialConfig() async {
    // await Provider.of<SplashProvider>(context, listen: false)
    //     .initSharedPrefData();
    // get cart data
    bool isSuccess =
        await Provider.of<SplashProvider>(context, listen: false).initConfig();
    if (isSuccess) {
      Timer(Duration(seconds: 1), () {
        if (!Provider.of<SplashProvider>(context, listen: false)
                .allowGuestUser &&
            !Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => WelcomeScreen()));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => WelcomeScreen()));
        }

        // if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
        //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => DashBoardScreen()));
        // } else {
        //   Navigator.of(context).pushReplacement(MaterialPageRoute(
        //       builder: (BuildContext context) =>
        // OnBoardingScreen(indicatorColor: ColorResources.GREY, selectedIndicatorColor: ColorResources.COLOR_PRIMARY)));
        // }
      });
    } else {
      Provider.of<SplashProvider>(context, listen: false)
          .initConfig()
          .then((bool isSuccess) {
        if (isSuccess) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => DashBoardScreen()));
          // if (Provider.of<AuthProvider>(context, listen: false)
          //     .isLoggedIn()) {
          //   Navigator.of(context).pushReplacement(MaterialPageRoute(
          //       builder: (BuildContext context) => DashBoardScreen()));
          // } else {
          //   Navigator.of(context).pushReplacement(MaterialPageRoute(
          //       builder: (BuildContext context) => OnBoardingScreen(
          //           indicatorColor: ColorResources.GREY,
          //           selectedIndicatorColor: ColorResources.COLOR_PRIMARY)));
          // }
        }
      });
    }
  }

  @override
  void initState() {
    final newVersion = NewVersion(
      androidId: StoreConstant.STORE_ANDROID_PACKAGE,
    );

    checkNewVersion(newVersion);

    super.initState();
    NetworkInfo.checkConnectivity(context);
  }

  void checkNewVersion(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    print("status" + status.toString());
    print(status?.localVersion);
    print(status?.storeVersion);

    if (status != null) {
      print(status.canUpdate);
      if (status.canUpdate) {
        bool dismissible = true;
        String localVersion = status.localVersion;
        String storeVersion = status.storeVersion;
        List<String> localVersionNumbers = localVersion.split('.');
        List<String> storeVersionNumbers = storeVersion.split('.');
        for (var i = 0; i < 3 - localVersionNumbers.length; i++) {
          localVersionNumbers.add('0');
        }
        for (var i = 0; i < 3 - storeVersionNumbers.length; i++) {
          storeVersionNumbers.add('0');
        }
        if (int.parse(storeVersionNumbers.elementAt(0)) >
                int.parse(localVersionNumbers.elementAt(0)) ||
            int.parse(storeVersionNumbers.elementAt(1)) >
                int.parse(localVersionNumbers.elementAt(1))) {
          dismissible = false;
        }
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return UpdateDialog(
                dismissalFunction: initialConfig,
                allowDismissal: dismissible,
                description: status.releaseNotes!,
                version: status.storeVersion,
                appLink: status.appStoreLink,
              );
            });
      } else {
        initialConfig();
      }
    } else {
      initialConfig();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Provider.of<ThemeProvider>(context).darkTheme
                ? Colors.black
                : Colors.white,
            // ColorResources.COLOR_PRIMARY,
            child: CustomPaint(
                // painter: SplashPainter(),
                ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  Images.SPLASH_LOGO,
                  height: 400, width: double.infinity,
                  cacheColorFilter: true,
                  // color: Colors.red,
                )
                // svg asset(Images.splash_logo,
                //     height: 250.0, fit: BoxFit.scaleDown, width: 250.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/view/screen/dashboard/dashboard_screen.dart';

class NoInternetOrDataScreen extends StatelessWidget {
  final bool isNoInternet;
  final Widget? child;
  NoInternetOrDataScreen({required this.isNoInternet, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(isNoInternet ? Images.no_internet : Images.no_data,
                  width: 150, height: 150),
              Text(
                  isNoInternet
                      ? getTranslated('OPPS', context)!
                      : getTranslated('sorry', context)!,
                  style: titilliumBold.copyWith(
                    fontSize: 30,
                    color: isNoInternet
                        ? Theme.of(context).textTheme.bodyText1!.color
                        : ColorResources.getColombiaBlue(context),
                  )),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Column(children: [
                Text(
                  isNoInternet
                      ? 'No internet connection'
                      : 'Add Some Products!!',
                  textAlign: TextAlign.center,
                  style: titilliumRegular,
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DashBoardScreen()));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor)),
                    child: Text("Add Products"))
              ]),
              SizedBox(height: 40),
              isNoInternet
                  ? Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ColorResources.getYellow(context)),
                      child: TextButton(
                        onPressed: () async {
                          if (await Connectivity().checkConnectivity() !=
                              ConnectivityResult.none) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => child!));
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(getTranslated('RETRY', context)!,
                              style: titilliumSemiBold.copyWith(
                                  color: Theme.of(context).accentColor,
                                  fontSize: Dimensions.FONT_SIZE_LARGE)),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share/share.dart';
import 'package:shopiana/data/model/response/master_item_model.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/auth_provider.dart';
import 'package:shopiana/provider/master_provider.dart';
import 'package:shopiana/provider/profile_provider.dart';
import 'package:shopiana/provider/splash_provider.dart';
import 'package:shopiana/provider/theme_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/view/basewidget/animated_custom_dialog.dart';
import 'package:shopiana/view/basewidget/guest_dialog.dart';
import 'package:shopiana/view/screen/cart/cart_screen.dart';
import 'package:shopiana/view/screen/category/all_category_screen.dart';
import 'package:shopiana/view/screen/more/web_view_screen.dart';
import 'package:shopiana/view/screen/more/widget/sign_out_confirmation_dialog.dart';
import 'package:shopiana/view/screen/notification/notification_screen.dart';
import 'package:shopiana/view/screen/offer/offers_screen.dart';
import 'package:shopiana/view/screen/order/order_screen.dart';
import 'package:shopiana/view/screen/profile/profile_screen.dart';
import 'package:shopiana/view/screen/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';

class MoreScreen extends StatelessWidget {
  bool isGuestMode = false;
  Future<void> getUserInfo(BuildContext context) async {
    isGuestMode =
        !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (!isGuestMode) {
      await Provider.of<ProfileProvider>(context, listen: false).getUserInfo();
      await Provider.of<MasterProvider>(context, listen: false)
          .retrieveMasterItem(Constants.ITEM_KEY_REFER_AND_EARN);
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    NetworkInfo.checkConnectivity(context);

    return Scaffold(
        body: FutureBuilder(
      future: getUserInfo(context),
      builder: (ctx, profileSnapshot) {
        if (profileSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        } else if (profileSnapshot.hasError) {
          return Center(
            child: Text('Something Went Wrong'),
          );
        } else {
          return Stack(children: [
            // Background
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                  height: _height * 0.3,
                  // fit: BoxFit.fill,
                  color: Theme.of(context).primaryColor),
            ),

            // AppBar
            Positioned(
              top: 40,
              left: Dimensions.PADDING_SIZE_SMALL,
              right: Dimensions.PADDING_SIZE_SMALL,
              child: Consumer<ProfileProvider>(
                builder: (context, profile, child) {
                  return Row(children: [
                    // SvgPicture.asset(
                    //   Images.splash_logo,
                    //   height: 35,
                    //   // color: ColorResources.WHITE
                    // ),
                    Expanded(child: SizedBox.shrink()),
                    Text(
                        !isGuestMode
                            ? profile.userInfoModel != null
                                ? '${profile.userInfoModel!.firstName} ${profile.userInfoModel!.lastName}'
                                : 'Full Name'
                            : 'Guest',
                        style: titilliumRegular.copyWith(
                            color: ColorResources.WHITE)),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    InkWell(
                      onTap: () {
                        if (isGuestMode) {
                          showAnimatedDialog(context, GuestDialog(),
                              isFlip: true);
                        } else {
                          if (Provider.of<ProfileProvider>(context,
                                      listen: false)
                                  .userInfoModel !=
                              null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProfileScreen()));
                          }
                        }
                      },
                      child: isGuestMode
                          ? CircleAvatar(
                              child: Icon(
                              Icons.person,
                              size: 35,
                            ))
                          : profile.userInfoModel == null
                              ? CircleAvatar(
                                  child: Icon(Icons.person, size: 35))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Icon(
                                    Icons.verified_user,
                                    color: Colors.white,
                                  )
                                  // Image.asset(
                                  //   profile.userInfoModel.image,
                                  //   width: 35,
                                  //   height: 35,
                                  //   fit: BoxFit.fill,
                                  // ),
                                  ),
                    ),
                  ]);
                },
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 120),
              decoration: BoxDecoration(
                color: ColorResources.getIconBg(context),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  // Top Row Items
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (Provider.of<SplashProvider>(context, listen: false)
                            .configModel!
                            .displayOrderSection!)
                          SquareButton(
                              image: Images.orders,
                              title: getTranslated('orders', context),
                              navigateTo: OrderScreen()),
                        if (Provider.of<SplashProvider>(context, listen: false)
                            .configModel!
                            .allowOnlinePurchase!)
                          SquareButton(
                              image: Images.cart,
                              title: getTranslated('CART', context),
                              navigateTo: CartScreen()),
                        /* SquareButton(
                            image: Images.offers,
                            title: getTranslated('offers', context),
                            navigateTo: OffersScreen()), */
                        // SquareButton(
                        //     image: Images.wishlist,
                        //     title: getTranslated('wishlist', context),
                        //     navigateTo: WishListScreen()),
                      ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                  // Buttons
                  if (Provider.of<AuthProvider>(context, listen: false)
                      .isLoggedIn())
                    TitleButton(
                        image: Images.more_filled_image,
                        title: getTranslated('PROFILE', context),
                        navigateTo: ProfileScreen()),
                  Provider.of<SplashProvider>(context, listen: false)
                          .configModel!
                          .allowOnlinePurchase!
                      ? TitleButton(
                          image: Images.more_filled_image,
                          title: getTranslated('all_category', context),
                          navigateTo: AllCategoryScreen())
                      : SizedBox(),
                  // TitleButton(
                  //     image: Images.notification_filled,
                  //     title: getTranslated('notification', context),
                  //     navigateTo: NotificationScreen()),

                  // TitleButton(
                  //     image: Images.privacy_policy,
                  //     title: getTranslated('terms_condition', context),
                  //     navigateTo: WebViewScreen(
                  //       title: getTranslated('terms_condition', context),
                  //       url: 'https://www.google.com',
                  //     )),

                  isGuestMode
                      ? SizedBox()
                      : ListTile(
                          leading: Icon(Icons.exit_to_app,
                              color: Theme.of(context).primaryColor, size: 25),
                          title: Text(getTranslated('sign_out', context)!,
                              style: titilliumRegular.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_LARGE)),
                          onTap: () => showAnimatedDialog(
                              context, SignOutConfirmationDialog(),
                              isFlip: true),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18, top: 6, bottom: 6),
                    child: SwitchListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      title: Provider.of<ThemeProvider>(context, listen: false)
                              .darkTheme
                          ? Text(
                              "Light Mode",
                            )
                          : Text(
                              "Dark Mode",
                            ),
                      value: Provider.of<ThemeProvider>(context, listen: false)
                          .darkTheme,
                      activeColor: Colors.blue,
                      inactiveTrackColor: Colors.grey,
                      onChanged: (bool value) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 300,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      /* ElevatedButton(
                        onPressed: () {
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme();
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ))),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            Provider.of<ThemeProvider>(context, listen: false)
                                    .darkTheme
                                ? "Light Mode"
                                : "Dark Mode",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ), */
                      if (Provider.of<MasterProvider>(context, listen: false)
                              .masterItem
                              ?.itemValue !=
                          null)
                        Container(
                          child: ElevatedButton(
                            onPressed: () async {
                              await Share.share(Provider.of<MasterProvider>(
                                      context,
                                      listen: false)
                                  .masterItem!
                                  .itemValue!);
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(9),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.share_sharp,
                                      color: Colors.green.shade400,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Share",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                    ],
                  ),
                  //* For token Expiratiion testing
                  /*  TextButton(
                      onPressed: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .changeToken();
                      },
                      child: Text("change token")) */
                ]),
              ),
            ),
          ]);
        }
      },
    ));
  }
}

class SquareButton extends StatelessWidget {
  final String image;
  final String? title;
  final Widget navigateTo;

  SquareButton(
      {required this.image, required this.title, required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 100;
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => navigateTo)),
      child: Column(children: [
        Container(
          width: width / 4,
          height: width / 4,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.03),
            border: Border.all(width: width * 0.003),
            // color: Theme.of(context).primaryColor,
          ),
          child: Image.asset(image, color: Theme.of(context).primaryColor),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(title!, style: titilliumRegular),
        ),
      ]),
    );
  }
}

class TitleButton extends StatelessWidget {
  final String image;
  final String? title;
  final Widget navigateTo;
  TitleButton(
      {required this.image, required this.title, required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        image,
        width: 25,
        height: 25,
        fit: BoxFit.fill,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(title!,
          style:
              titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
      onTap: () => Navigator.push(
        context,
        /*PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (context, animation, secondaryAnimation) => navigateTo,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(parent: animation, curve: Curves.bounceInOut);
              return ScaleTransition(scale: animation, child: child, alignment: Alignment.center);
            },
          ),*/
        MaterialPageRoute(builder: (_) => navigateTo),
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share/share.dart';
import 'package:shopiana/data/model/response/config_model.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/app_config_provider.dart';
import 'package:shopiana/provider/cart_provider.dart';
import 'package:shopiana/provider/category_provider.dart';
import 'package:shopiana/provider/master_provider.dart';
import 'package:shopiana/provider/product_provider.dart';
import 'package:shopiana/provider/profile_provider.dart';
import 'package:shopiana/provider/splash_provider.dart';
import 'package:shopiana/provider/wallet_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/utill/section_divider.dart';
import 'package:shopiana/view/basewidget/title_row.dart';
import 'package:shopiana/view/screen/Group/all_product_group_screen.dart';
import 'package:shopiana/view/screen/brand/all_brand_screen.dart';
import 'package:shopiana/view/screen/cart/cart_screen.dart';
import 'package:shopiana/view/screen/category/all_category_screen.dart';
import 'package:shopiana/view/screen/home/widget/brand_view.dart';
import 'package:shopiana/view/screen/home/widget/carousel_slider_widget.dart';
import 'package:shopiana/view/screen/home/widget/category_view.dart';
import 'package:shopiana/view/screen/home/widget/home_products_widget.dart';
import 'package:shopiana/view/screen/home/widget/product_group_widget.dart';
import 'package:shopiana/view/screen/home/widget/qr_code_widget.dart';
import 'package:shopiana/view/screen/search/search_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final ScrollController _scrollController = new ScrollController();

  Future<void> loadDataOnStartUp(BuildContext context) async {
    Provider.of<ProfileProvider>(context, listen: false).getUserInfo();
    await Provider.of<MasterProvider>(context, listen: false)
        .retrieveMasterItem(Constants.ITEM_KEY_REFER_AND_EARN);
    await Provider.of<CartProvider>(context, listen: false).getCartData();
  }

  Future<void> getProductGroups(BuildContext context) async {
    await Provider.of<ProductProvider>(context).getProductGroups();
  }

  Future<void> getWalletDetail(BuildContext context) async {
    await Provider.of<WalletProvider>(context, listen: false)
        .getWalletDetails();
  }

  var fistTimeLoad = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // Provider.of<MegaDealProvider>(context, listen: false).initMegaDealList();
    ConfigModel config =
        Provider.of<SplashProvider>(context, listen: false).configModel!;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    loadDataOnStartUp(context);
    bool? isProductDisplay =
        Provider.of<AppConfigProvider>(context, listen: false)
            .getDisplayProductListBool();

    NetworkInfo.checkConnectivity(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // App Bar
            SliverAppBar(
              floating: true,
              elevation: 0,
              centerTitle: false,
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).accentColor,
              title: Row(children: [
                SvgPicture.asset(
                  Images.SPLASH_LOGO,
                  height: 45,

                  // color: ColorResources.getPrimary(context)
                ),
                SizedBox(
                  width: _width * 0.04,
                ),
                /*  Text(
                  "Sleepin Saathi",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ) */
              ]),
              actions: [
                config.allowOnlinePurchase!
                    ? Consumer<CartProvider>(builder: (_, cart, ch) {
                        return IconButton(
                          onPressed: () {
                            // if (cart.cartItems.isNotEmpty) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CartScreen()));
                            // }
                          },
                          icon: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Image.asset(
                                Images.cart_image,
                                color: Theme.of(context).primaryColor,
                                height: Dimensions.ICON_SIZE_DEFAULT,
                                width: Dimensions.ICON_SIZE_DEFAULT,
                              ),
                              Positioned(
                                top: -4,
                                right: -4,
                                child: CircleAvatar(
                                  radius: 7,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Text(cart.cartItems.length.toString(),
                                      style: titilliumSemiBold.copyWith(
                                        color: ColorResources.WHITE,
                                        fontSize:
                                            Dimensions.FONT_SIZE_EXTRA_SMALL,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                    : SizedBox()
              ],
            ),
            /* SliverPadding(padding: EdgeInsets.only(top: 10)), */
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            // Search Button
            if (Provider.of<SplashProvider>(context, listen: false)
                .configModel!
                .displaySearchBox!)
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverDelegate(
                  child: InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SearchScreen())),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL,
                          vertical: 2),
                      //color: ColorResources.getHomeBg(context),
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        height: 50,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade500),
                          borderRadius: BorderRadius.circular(
                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        ),
                        child: Row(children: [
                          Icon(Icons.search,
                              color: Theme.of(context).primaryColor,
                              size: Dimensions.ICON_SIZE_LARGE),
                          SizedBox(width: 5),
                          Text(
                              /* getTranslated('SEARCH_HINT', context) */ "Search products or categories",
                              style: robotoRegular.copyWith(
                                  color: Theme.of(context).hintColor)),
                        ]),
                      ),
                    ),
                  ),
                ),
              ),

            SliverToBoxAdapter(
              child: Column(
                children: [
                  // Padding(
                  //   padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
                  //   child: BannersView(),
                  // ),
                  /* if (config.displaySlider!)
                    Text(
                      "Latest Updates and Offers",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ), */
                  SizedBox(
                    height: 10,
                  ),
                  if (config.displayQrscanSection!)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Material(
                                    elevation: 8,
                                    borderRadius: BorderRadius.circular(25),
                                    child: InkWell(
                                      onTap: () async {
                                        await Share.share(
                                            Provider.of<MasterProvider>(context,
                                                    listen: false)
                                                .masterItem!
                                                .itemValue!);
                                      },
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            Color.fromARGB(255, 184, 42, 161),
                                        foregroundColor:
                                            Color.fromARGB(255, 184, 42, 161),
                                        child: Icon(
                                          Icons.share_sharp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Share",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 40, 9, 47)),
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                  if (config.displayQrscanSection!)
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          Dimensions.PADDING_SIZE_SMALL,
                          20,
                          Dimensions.PADDING_SIZE_SMALL,
                          Dimensions.PADDING_SIZE_SMALL),
                      child: FutureBuilder(
                        future: getWalletDetail(context),
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
                            return Consumer<WalletProvider>(
                                builder: (context, wallet, _) {
                              return Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "You have",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: /*  Color.fromARGB(
                                                255, 69, 168, 48) */
                                              Colors.green),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Text(
                                          (wallet.walletDetail?.totalPoint ==
                                                  null
                                              ? "0"
                                              : wallet
                                                  .walletDetail?.availablePoint
                                                  ?.toString()
                                                  .toString())!,
                                          style: TextStyle(
                                              fontSize: 34,
                                              color: /*  Color.fromARGB(
                                                255, 69, 168, 48) */
                                                  Theme.of(context)
                                                      .primaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              getWalletDetail(context);
                                            },
                                            child: Icon(
                                              Icons.refresh,
                                              size: 35,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      "Reward Points",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: /*  Color.fromARGB(
                                                255, 69, 168, 48) */
                                              Colors.green),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    QRCodeWidget()
                                  ],
                                ),
                              );
                            });
                          }
                        },
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  //Slider
                  if (config.displaySlider!) CarouselSliderWidget(),
                  SizedBox(
                    height: 10,
                  ),
                  if (config.displayCategorySection!) SectionDividerWidget(),
                  // Category
                  if (config.displayCategorySection ?? false)
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          Dimensions.PADDING_SIZE_SMALL,
                          20,
                          Dimensions.PADDING_SIZE_SMALL,
                          Dimensions.PADDING_SIZE_SMALL),
                      child: TitleRow(
                          title: getTranslated('CATEGORY', context),
                          onTap: () {
                            Provider.of<CategoryProvider>(context,
                                    listen: false)
                                .changeSelectedIndex(0);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AllCategoryScreen()));
                          }),
                    ),
                  config.displayCategorySection!
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_SMALL),
                          child: CategoryView(isHomePage: true),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 10,
                  ),
                  if (config.displayManufacturerSection!)
                    SectionDividerWidget(),
                  // Brand
                  config.displayManufacturerSection!
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(
                              Dimensions.PADDING_SIZE_SMALL,
                              20,
                              Dimensions.PADDING_SIZE_SMALL,
                              Dimensions.PADDING_SIZE_SMALL),
                          child: TitleRow(
                              title: getTranslated('brand', context),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => AllBrandScreen()));
                              }),
                        )
                      : SizedBox(),
                  config.displayManufacturerSection!
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_SMALL),
                          child: BrandView(isHomePage: true),
                        )
                      : SizedBox(),

                  // Latest Products
                  // if (isProductDisplay) ...[
                  //   Padding(
                  //     padding: EdgeInsets.fromLTRB(
                  //         Dimensions.PADDING_SIZE_SMALL,
                  //         20,
                  //         Dimensions.PADDING_SIZE_SMALL,
                  //         Dimensions.PADDING_SIZE_SMALL),
                  //     child: TitleRow(
                  //         title: getTranslated('latest_products', context)),
                  //   ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //       horizontal: Dimensions.PADDING_SIZE_SMALL),
                  //   child: ProductView(
                  //       productType: ProductType.LATEST_PRODUCT,
                  //       scrollController: _scrollController),
                  // ),
                  // ],
                  SizedBox(
                    height: 10,
                  ),
                  if (config.displayProductGroupSection!)
                    SectionDividerWidget(),
                  config.displayProductGroupSection! &&
                          Provider.of<ProductProvider>(context, listen: false)
                                  .groupProducts !=
                              null &&
                          Provider.of<ProductProvider>(context, listen: false)
                                  .groupProducts!
                                  .length >
                              0
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(
                              Dimensions.PADDING_SIZE_SMALL,
                              20,
                              Dimensions.PADDING_SIZE_SMALL,
                              Dimensions.PADDING_SIZE_SMALL),
                          child: TitleRow(
                            title: "Product Group",
                            /* onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AllProductGroupScreen()));
                        } */
                          ),
                        )
                      : SizedBox(),
                  config.displayProductGroupSection! &&
                          Provider.of<ProductProvider>(context, listen: false)
                                  .groupProducts !=
                              null &&
                          Provider.of<ProductProvider>(context, listen: false)
                                  .groupProducts!
                                  .length >
                              0
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_SMALL),
                          child: FutureBuilder(
                            future: getProductGroups(context),
                            builder: (ctx, groupSnapshot) {
                              if (groupSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                );
                              } else if (groupSnapshot.hasError) {
                                return SizedBox();
                              } else {
                                return Consumer<ProductProvider>(
                                    builder: (context, product, _) {
                                  return ProductGroupWidget(product);
                                });
                              }
                            },
                          ),
                        )
                      : SizedBox(),
                  config.displayProductSectionAtHome!
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(
                              Dimensions.PADDING_SIZE_SMALL,
                              20,
                              Dimensions.PADDING_SIZE_SMALL,
                              Dimensions.PADDING_SIZE_SMALL),
                          child: TitleRow(
                            title: "Products",
                            /* onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AllProductGroupScreen()));
                        } */
                          ),
                        )
                      : SizedBox(),
                  config.displayProductSectionAtHome!
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_SMALL),
                          child: HomeProducts(_scrollController))
                      : SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}

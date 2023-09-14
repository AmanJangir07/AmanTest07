import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/category.dart';
import 'package:shopiana/data/model/response/config_model.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/provider/cart_provider.dart';
import 'package:shopiana/provider/category_provider.dart';
import 'package:shopiana/provider/product_provider.dart';
import 'package:shopiana/provider/splash_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/view/basewidget/custom_app_bar.dart';
import 'package:shopiana/view/basewidget/product_shimmer.dart';
import 'package:shopiana/view/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/view/screen/cart/cart_screen.dart';
import 'package:shopiana/view/screen/home/home_screen.dart';
import 'package:shopiana/view/screen/more/widget/loading_widget.dart';
import 'package:shopiana/view/screen/product/widget/filter_widget.dart';
import 'package:shopiana/view/screen/search/search_screen.dart';

class BrandAndCategoryProductScreen extends StatefulWidget {
  final bool isBrand;
  final String id;
  final String? name;
  final String? image;
  final ScrollController _scrollController = new ScrollController();

  BrandAndCategoryProductScreen(
      {required this.isBrand,
      required this.id,
      required this.name,
      this.image});

  @override
  _BrandAndCategoryProductScreenState createState() =>
      _BrandAndCategoryProductScreenState();
}

class _BrandAndCategoryProductScreenState
    extends State<BrandAndCategoryProductScreen> {
  int _page = 0;
  bool isLoading = false;

  final ScrollController _scrollController = new ScrollController();
  Future<void> initBrandOrCategory(
      {required BuildContext context,
      required String? id,
      required String? name}) async {
    setState(() {
      isLoading = true;
    });
    var dataProvider = Provider.of<ProductProvider>(context, listen: false);
    await dataProvider.initBrandOrCategoryProductList(
      context: context,
      isBrand: widget.isBrand,
      id: id,
      pageNumber: _page,
      count: Constants.DEFAULT_COUNT,
    );

    setState(() {
      isLoading = false;
    });
  }

  Future<void> getCategoryDefinition() async {
    await Provider.of<CategoryProvider>(context, listen: false)
        .getCategoryDefinition(context: context);
  }

  @override
  void initState() {
    initBrandOrCategory(context: context, id: widget.id, name: widget.name);
    widget._scrollController.addListener(() {
      if (widget._scrollController.position.pixels ==
          widget._scrollController.position.maxScrollExtent) {
        Provider.of<ProductProvider>(context, listen: false)
            .setLoadingState(LoadMoreStatus.LOADING);
        Provider.of<ProductProvider>(context, listen: false)
            .initBrandOrCategoryProductList(
                context: context,
                isBrand: widget.isBrand,
                id: widget.id,
                pageNumber: ++_page,
                count: Constants.DEFAULT_COUNT);
      }
    });
    getCategoryDefinition();
    super.initState();
  }

  List _selectedIndexs = [];
  @override
  Widget build(BuildContext context) {
    NetworkInfo.checkConnectivity(context);
    ConfigModel config =
        Provider.of<SplashProvider>(context, listen: false).configModel!;
    return Scaffold(
        appBar: AppBar(
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: InkWell(
              child:
                  Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
              onTap: () => Navigator.pop(context),
            ),
            actions: [
              config.allowOnlinePurchase!
                  ? Consumer<CartProvider>(builder: (_, cart, ch) {
                      return IconButton(
                        onPressed: () {
                          // if (cart.cartItems.isNotEmpty) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => CartScreen()));
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
                                backgroundColor: Theme.of(context).primaryColor,
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
            title: Text(widget.name!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        /*  bottomNavigationBar: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () {},
                child: Text(
                  "Sort",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () {},
                child: Text(
                  "Filter",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        ), */
        body: CustomScrollView(
          controller: widget._scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            /* SliverPadding(
              padding: EdgeInsets.only(top: 10),
            ), */
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
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        height: 50,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(
                              Dimensions.PADDING_SIZE_SMALL),
                        ),
                        child: Row(children: [
                          Icon(Icons.search,
                              color: Theme.of(context).primaryColor,
                              size: Dimensions.ICON_SIZE_LARGE),
                          SizedBox(width: 5),
                          Text(
                              /* getTranslated('SEARCH_HINT', context) */ "Search product or category",
                              style: robotoRegular.copyWith(
                                  color: Theme.of(context).hintColor)),
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
            if (!widget.isBrand)
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverDelegate(
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: /* FutureBuilder(
                    future: getCategoryDefinition(),
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
                        return */
                        Consumer<CategoryProvider>(
                      builder: (context, categoryProvider, _) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                categoryProvider.categoryDefinitionList.length,
                            itemBuilder: (context, index) {
                              final _isSelected =
                                  _selectedIndexs.contains(index);
                              return GestureDetector(
                                onTap: () {
                                  /* Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              BrandAndCategoryProductScreen(
                                                  isBrand: false,
                                                  id: categoryProvider
                                                      .categoryDefinitionList[
                                                          index]
                                                      .id
                                                      .toString(),
                                                  name: categoryProvider
                                                      .categoryDefinitionList[
                                                          index]
                                                      .name),
                                        ),
                                      ); */
                                  initBrandOrCategory(
                                      context: context,
                                      id: categoryProvider
                                          .categoryDefinitionList[index].id
                                          .toString(),
                                      name: categoryProvider
                                          .categoryDefinitionList[index].name);
                                  setState(() {
                                    _selectedIndexs.clear();
                                    if (_isSelected) {
                                      _selectedIndexs.remove(index);
                                    } else {
                                      _selectedIndexs.add(index);
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 5, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 3,
                                              color: _isSelected
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.white))),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: (categoryProvider
                                                        .categoryDefinitionList[
                                                            index]
                                                        .imageUrl !=
                                                    null
                                                ? NetworkImage(
                                                    categoryProvider
                                                        .categoryDefinitionList[
                                                            index]
                                                        .imageUrl,
                                                  )
                                                : AssetImage(Images.no_image))
                                            as ImageProvider<Object>?,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                color: Colors.black, width: 2),
                                          ),
                                        ),
                                        child: Text(
                                          categoryProvider
                                              .categoryDefinitionList[index]
                                              .code!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ),
              ),
            /*      }
                    },
                  ),
                )),
              ), */
            SliverToBoxAdapter(
              child: Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        /* CustomAppBar(title: widget.name), */

                        // Brand Details
                        widget.isBrand
                            ? Container(
                                height: 100,
                                padding: EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_LARGE),
                                margin: EdgeInsets.only(
                                    top: Dimensions.PADDING_SIZE_SMALL),
                                color: Theme.of(context).accentColor,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        widget.image!,
                                        width: 80,
                                        height: 80,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return Image.asset(
                                            Constants.DEFAULT_NO_IMAGE_SRC,
                                            height: 60,
                                            width: 60,
                                          );
                                        },
                                      ),
                                      SizedBox(
                                          width: Dimensions.PADDING_SIZE_SMALL),
                                      Text(widget.name!,
                                          style: titilliumSemiBold.copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_LARGE)),
                                    ]),
                              )
                            : SizedBox.shrink(),

                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                        // Products
                        !productProvider.firstLoadingBrandCategory
                            ? isLoading
                                ? Center(child: ProductShimmer(isEnabled: true))
                                : productProvider.brandOrCategoryProductList
                                            .length ==
                                        0
                                    ? Center(
                                        child: Text("No product available"),
                                      )
                                    : ListView.builder(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                Dimensions.PADDING_SIZE_SMALL),
                                        physics: BouncingScrollPhysics(),
                                        // crossAxisCount: 1,
                                        itemCount: productProvider
                                            .brandOrCategoryProductList.length,
                                        shrinkWrap: true,
                                        // staggeredTileBuilder: (int index) =>
                                        //     StaggeredTile.fit(1),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ProductWidget(
                                              productModel: productProvider
                                                      .brandOrCategoryProductList[
                                                  index]);
                                        },
                                      )
                            : ProductShimmer(isEnabled: true),
                        if (productProvider.brandOrCategoryProductList.length <
                                productProvider.brandCategoryTotalProducts! &&
                            isLoading == false)
                          Center(child: AppLoadingIndicator())
                      ]);
                },
              ),
            )
          ],
        ));
  }
}

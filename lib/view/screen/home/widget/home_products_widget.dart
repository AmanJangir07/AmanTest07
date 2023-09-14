import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/provider/product_provider.dart';
import 'package:shopiana/provider/splash_provider.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/view/basewidget/product_shimmer.dart';
import 'package:shopiana/view/screen/more/widget/loading_widget.dart';
import 'package:shopiana/view/screen/product/product_details_screen.dart';
import 'package:shopiana/view/screen/product/widget/add_to_cart_widget.dart';

class HomeProducts extends StatefulWidget {
  ScrollController scrollController;
  HomeProducts(this.scrollController);
  @override
  State<HomeProducts> createState() => _HomeProductsState();
}

class _HomeProductsState extends State<HomeProducts> {
  int _page = 0;
  bool isLoading = false;
  bool isFirstTime = true;
  bool isPageLoading = false;

  Future<void> getProducts({int? pageNumber}) async {
    setState(() {
      isLoading = true;
      if (isFirstTime) {
        isPageLoading = true;
      }
    });
    var dataProvider = Provider.of<ProductProvider>(context, listen: false);
    dataProvider.getProducts(
        context: context, pageNumber: _page, count: Constants.DEFAULT_COUNT);
    setState(() {
      isLoading = false;
      if (isFirstTime) {
        isPageLoading = false;
        isFirstTime = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    print("init");
    getProducts(pageNumber: _page);
    // print("position" + _scrollController.position.pixels.toString());
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels ==
          widget.scrollController.position.maxScrollExtent) {
        print("position" + widget.scrollController.position.pixels.toString());
        // orderProvider.setLoadingState(LoadMoreStatus.LOADING);
        getProducts(pageNumber: ++_page);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        List<Product> productList;
        productList = prodProvider.productList;

        return Column(children: [
          !prodProvider.firstLoadingProduct
              ? productList.length != 0
                  ? StaggeredGridView.countBuilder(
                      itemCount: productList.length,
                      crossAxisCount: Constants.PRODUCT_CROSS_AXIS_COUNT,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                      itemBuilder: (BuildContext context, int index) {
                        // if((index ==  prodProvider.latestProductList.length -1) && prodProvider.latestProductList)
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProductDetails(
                                        product: productList[index])));
                          },
                          child: Container(
                            height: _height * 0.36,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white70,
                                  border: Border(
                                      right: BorderSide(
                                          color: Colors.grey.shade200),
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200))),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: _height * 0.006,
                                  ),
                                  // Product Image
                                  Expanded(
                                    flex: 10,
                                    child: Stack(children: [
                                      Container(
                                        width: double.infinity,
                                        child: productList[index]
                                                    .image
                                                    ?.imageUrl !=
                                                null
                                            ? Image.network(
                                                productList[index]
                                                    .image!
                                                    .imageUrl
                                                    .toString(),
                                                fit: BoxFit.contain,
                                              )
                                            : Image.asset(
                                                Images.no_image,
                                                fit: BoxFit.contain,
                                              ),
                                      ),
                                      Positioned(
                                        right: 10,
                                        top: -150,
                                        bottom: 0,
                                        child: InkWell(
                                          onTap: () async {
                                            await Share.share(
                                                "${productList[index].description!.name} \n\n ${Provider.of<SplashProvider>(context, listen: false).configModel!.domainName!}/products/${productList[index].description!.friendlyUrl!}");
                                          },
                                          child: Container(
                                            child: Container(
                                                child: Icon(Icons.share)),
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: EdgeInsets.all(_width * 0.01),
                                      child: Container(
                                          width: _width * 0.40,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      productList[index]
                                                              .description
                                                              ?.name ??
                                                          "",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize:
                                                              _width * 0.028,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    SizedBox(
                                                      height: _height * 0.008,
                                                    ),
                                                    Provider.of<SplashProvider>(
                                                                context,
                                                                listen: false)
                                                            .configModel!
                                                            .displayProductPrice!
                                                        ? Text(
                                                            productList[index]
                                                                    .productPrice
                                                                    ?.finalPrice ??
                                                                "",
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                fontSize:
                                                                    _width *
                                                                        0.027),
                                                          )
                                                        : SizedBox(),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Provider.of<SplashProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .configModel!
                                                                .displayProductPrice!
                                                            ? Text(
                                                                productList[index]
                                                                        .productPrice
                                                                        ?.originalPrice ??
                                                                    "".toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        _width *
                                                                            0.024,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough),
                                                              )
                                                            : SizedBox(),
                                                        AddToCart(
                                                            product:
                                                                productList[
                                                                    index]),
                                                      ],
                                                    )
                                                  ],
                                                )),
                                              ),
                                            ],
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : SizedBox.shrink()
              : ProductShimmer(isEnabled: prodProvider.firstLoadingProduct),
          if (prodProvider.productList.length < prodProvider.totalProducts!)
            Center(child: AppLoadingIndicator())
        ]);
      },
    );
  }

  @override
  void dispose() {
    // widget.scrollController.dispose();
    super.dispose();
  }
}

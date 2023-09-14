import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/product_details_provider.dart';
import 'package:shopiana/provider/product_provider.dart';
import 'package:shopiana/provider/splash_provider.dart';
import 'package:shopiana/provider/theme_provider.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/basewidget/title_row.dart';
import 'package:shopiana/view/screen/product/widget/bottom_cart_view.dart';
import 'package:shopiana/view/screen/product/widget/product_image_view.dart';
import 'package:shopiana/view/screen/product/widget/product_specification_view.dart';
import 'package:shopiana/view/screen/product/widget/product_title_view.dart';
import 'package:shopiana/view/screen/product/widget/related_product_view.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  ProductDetails({required this.product});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String selectedSizeValue = '';
  Map<String?, int?> variants = {};
  ProductVariantPrice? productVariantPrice;
  bool _isLoading = false;
  double? priceOptionPrice;
  Map<String?, OptionValue> selectedOptions = {};

  void initSelectOptions() {
    priceOptionPrice = widget.product.productPrice!.finalPriceDecimal!;
    widget.product.options!.forEach((option) {
      if (option.optionValues![0] != null) {
        priceOptionPrice = priceOptionPrice! + option.optionValues![0].price!;
        selectedOptions.putIfAbsent(option.code, () => option.optionValues![0]);
      }
    });
  }

  void changeProductOptions(Map<String?, OptionValue> newOptions) {
    setState(() {
      selectedOptions = newOptions;
      priceOptionPrice = widget.product.productPrice!.finalPriceDecimal!;
      newOptions.forEach((key, value) {
        priceOptionPrice = priceOptionPrice! + value.price!;
      });
    });
  }

  void setInitialVariants() {
    widget.product.options!.forEach((currentOption) {
      for (var currentOptionValue in currentOption.optionValues!) {
        var index = currentOption.optionValues!.indexOf(currentOptionValue);
        if (index == 0 || currentOptionValue.defaultValue!) {
          variants.update(
            currentOption.name,
            (existingValue) => currentOption.optionValues![0].id,
            ifAbsent: () => currentOption.optionValues![0].id,
          );
          if (currentOptionValue.defaultValue!) {
            break;
          }
        }
      }
    });
  }

  Future<void> changeVariant(String variantKey, int variantValue) async {
    variants[variantKey] = variantValue;
    await getPriceByVariant();
  }

  Future<void> getPriceByVariant() async {
    setState(() {
      _isLoading = true;
    });
    productVariantPrice =
        await Provider.of<ProductProvider>(context, listen: false)
            .getPriceByVariants(
                productId: widget.product.id,
                variantMap: variants,
                context: context);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // setInitialVariants();
    // getPriceByVariant();
    initSelectOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final url = Provider.of<SplashProvider>(context, listen: false)
            .configModel!
            .domainName! +
        widget.product.description!.friendlyUrl!;
    //       "product option ${widget.product.options[0].optionValues[0].toJson()}");
    // Provider.of<ProductDetailsProvider>(context, listen: false)
    //     .removePrevReview();
    // Provider.of<ProductDetailsProvider>(context, listen: false)
    //     .initProduct(widget.product);
    // Provider.of<WishListProvider>(context, listen: false)
    //     .checkWishList(widget.product.id.toString());
    // Provider.of<ProductProvider>(context, listen: false)
    //     .removePrevRelatedProduct();
    Provider.of<ProductProvider>(context, listen: false)
        .initRelatedProductList(widget.product.id);
    // Provider.of<ProductDetailsProvider>(context, listen: false)
    //     .getCount(widget.product.id.toString());
    // Provider.of<ProductDetailsProvider>(context, listen: false)
    //     .getSharableLink(widget.product.id.toString());
    // NetworkInfo.checkConnectivity(context);

    return Consumer<ProductDetailsProvider>(
      builder: (context, details, child) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Theme.of(context).primaryColor,
            leading: InkWell(
              child:
                  Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
              onTap: () => Navigator.pop(context),
            ),
            title: Text("Product Details",
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold)),
            actions: [
              InkWell(
                onTap: () async {
                  await Share.share(
                      "${widget.product.description?.name} \n\n $url");

                  /*  if (Provider.of<ProductDetailsProvider>(context,
                                  listen: false)
                              .sharableLink !=
                          null) {
                        Share.share(Provider.of<ProductDetailsProvider>(context,
                                listen: false)
                            .sharableLink);
                      } */
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200]!,
                            spreadRadius: 1,
                            blurRadius: 5)
                      ],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.share,
                        color: Theme.of(context).primaryColor,
                        size: Dimensions.ICON_SIZE_SMALL),
                  ),
                ),
              ),
            ],
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Provider.of<ThemeProvider>(context).darkTheme
                ? Colors.black
                : Colors.white.withOpacity(0.5),
          ),
          bottomNavigationBar: _isLoading
              ? null
              : Provider.of<SplashProvider>(context, listen: false)
                      .configModel!
                      .displayProductPrice!
                  ? BottomCartView(
                      product: widget.product,
                      selectedOptions: selectedOptions,
                      priceOptionPrice: priceOptionPrice,
                      variants: variants)
                  : SizedBox(),
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : /* Column(children: [ */
              SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ProductImageView(productModel: widget.product),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 1,
                        thickness: 0,
                      ),
                      ProductTitleView(
                          productModel: widget.product,
                          priceOptionPrice: priceOptionPrice,
                          selectedOptions: selectedOptions,
                          changeProductOptions: changeProductOptions),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 1,
                        thickness: 0,
                      ),

                      // ...widget.product.options.map((currentVarient) {
                      //   return DropdownButton(
                      //     icon: Icon(Icons.arrow_drop_down),
                      //     elevation: 6,
                      //     hint: Text(selectedSizeValue),
                      //     onChanged: (_) {},
                      //     value: variants[currentVarient.name],
                      //     items: currentVarient.optionValues
                      //         .map((optionValue) => DropdownMenuItem(
                      //               child: Text(
                      //                 '${optionValue.description?.name}',
                      //               ),
                      //               value: optionValue.id,
                      //               onTap: () {
                      //                 changeVariant(
                      //                     currentVarient.name, optionValue.id);
                      //               },
                      //             ))
                      //         .toList(),
                      //   );
                      // }),

                      // Product variant
                      /*Container(
                    margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    color: ColorResources.WHITE,
                    child: Column(
                      children: [
                        Row(children: [
                          Expanded(child: Text(Strings.product_variants, style: robotoBold)),
                          Text(Strings.details, style: titilliumRegular.copyWith(
                            color: ColorResources.SELLER_TXT,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          )),
                        ]),
                        SizedBox(height: 5),
                        SizedBox(
                          height: 45,
                          child: ListView.builder(
                            itemCount: product.colors.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              String colorString = '0xff' + product.colors[index].substring(1, 7);
                              return Container(
                                width: 45,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(int.parse(colorString))),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),*/

                      // Reviews
                      // Container(
                      //   margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                      //   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      //   color: Theme.of(context).accentColor,
                      //   child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         TitleRow(
                      //             title: getTranslated('reviews', context) +
                      //                 '(${details.reviewList != null ? details.reviewList.length : 0})',
                      //             isDetailsPage: true,
                      //             onTap: () {
                      //               if (details.reviewList != null) {
                      //                 Navigator.push(
                      //                     context,
                      //                     MaterialPageRoute(
                      //                         builder: (_) => ReviewScreen(
                      //                             reviewList: details.reviewList)));
                      //               }
                      //             }),
                      //         Divider(),
                      //         details.reviewList != null
                      //             ? details.reviewList.length > 0
                      //                 ? ReviewWidget(
                      //                     reviewModel: details.reviewList[0])
                      //                 : Center(child: Text('No Review'))
                      //             : ReviewShimmer(),
                      //       ]),
                      // ),
                      Container(
                        margin:
                            EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        color: Theme.of(context).accentColor,
                        child: ProductSpecification(
                            productSpecification:
                                widget.product.description!.description ?? ''),
                      ),

                      Provider.of<ProductProvider>(context, listen: false)
                                  .relatedProductList!
                                  .length !=
                              0
                          ? Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.PADDING_SIZE_SMALL),
                              padding:
                                  EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                              color: Theme.of(context).accentColor,
                              child: Column(
                                children: [
                                  TitleRow(
                                      title: getTranslated(
                                          'related_products', context),
                                      isDetailsPage: true),
                                  SizedBox(height: 5),
                                  RelatedProductView(),
                                ],
                              ),
                            )
                          : SizedBox(),
                      // Related Products
                    ],
                  ),
                ),
          /* ]), */
        );
      },
    );
  }
}

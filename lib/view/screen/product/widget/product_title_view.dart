import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/provider/product_details_provider.dart';
import 'package:shopiana/provider/splash_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shopiana/utill/util.dart';
import 'package:shopiana/view/screen/product/widget/product_options_widget.dart';

class ProductTitleView extends StatelessWidget {
  final Product productModel;
  final double? priceOptionPrice;
  final Map<String?, OptionValue>? selectedOptions;
  final Function? changeProductOptions;
  // final ProductVariantPrice productVariantPrice;
  ProductTitleView(
      {required this.productModel,
      this.priceOptionPrice,
      this.selectedOptions,
      this.changeProductOptions});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    double? _startingPrice;
    double? _endingPrice;
    // if (productModel.choiceOptions.length != 0) {
    //   List<double> _priceList = [];
    //   productModel.variation.forEach(
    //       (variation) => _priceList.add(double.parse(variation.price)));
    //   _priceList.sort((a, b) => a.compareTo(b));
    //   _startingPrice = _priceList[0];
    //   if (_priceList[0] < _priceList[_priceList.length - 1]) {
    //     _endingPrice = _priceList[_priceList.length - 1];
    //   }
    // } else {
    //   _startingPrice = double.parse(productModel.price);
    // }
    _startingPrice = productModel.price;
    _endingPrice = productModel.price;
    return Container(
      color: Theme.of(context).accentColor,
      padding: EdgeInsets.only(
          left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL),
      child: Consumer<ProductDetailsProvider>(
        builder: (context, details, child) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: _height * 0.01,
                ),
                Container(
                  // tag: 'name-${productModel.id}',
                  child: Text(productModel.description!.name ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: _width * 0.05)),
                ),
                Provider.of<SplashProvider>(context, listen: false)
                        .configModel!
                        .displayProductPrice!
                    ? Row(children: [
                        Hero(
                          tag: 'price-${productModel.id}',
                          child: Text(
                            '${productModel.finalPrice}',
                            // '${PriceConverter.convertPrice(context, _startingPrice, discount: "10", discountType: "percent")}'
                            // '${_endingPrice != null ? ' - ${PriceConverter.convertPrice(context, _endingPrice, discount: "10", discountType: "percent")}' : ''}',
                            style: titilliumBold.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: Dimensions.FONT_SIZE_LARGE),
                          ),
                        ),
                        // SizedBox(width: 20),
                        // double.parse("10") >= 1
                        //     ? Container(
                        //         width: 50,
                        //         height: 20,
                        //         alignment: Alignment.center,
                        //         decoration: BoxDecoration(
                        //           border: Border.all(
                        //               width: 1,
                        //               color: ColorResources.getPrimary(context)),
                        //           borderRadius: BorderRadius.circular(50),
                        //         ),
                        //         child: Hero(
                        //           tag: 'off-${productModel.id}',
                        //           child: Text(
                        //             '${productVariantPrice?.discountPercent}',
                        //             style: titilliumRegular.copyWith(
                        //                 color: Theme.of(context).hintColor,
                        //                 fontSize: 8),
                        //           ),
                        //         ),
                        //       )
                        //     : SizedBox.shrink(),
                        SizedBox(
                          width: _width * 0.05,
                        ),
                        Hero(
                          tag: 'cutted-price-${productModel.id}',
                          child: Text(
                            '${productModel.originalPrice}',
                            style: titilliumRegular.copyWith(
                                color: Theme.of(context).hintColor,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                        Expanded(child: SizedBox.shrink()),
                        if (productModel.discounted!)
                          Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(_width * 0.01),
                                color: Colors.green,
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    _width * 0.01,
                                    _width * 0.005,
                                    _width * 0.01,
                                    _width * 0.005),
                                child: Text(
                                    "${productModel.productPrice?.discountPercent}%"),
                              ))
                      ])
                    : SizedBox(),

                ProductOptionsWidget(
                    options: productModel.options,
                    selectedOptions: selectedOptions,
                    changeProductOptions: changeProductOptions)

                // Row(children: [
                //   Hero(
                //     tag: 'rating-${productModel.id}',
                //     child: Text(
                //         productModel.rating != null
                //             ? productModel.ratingCount > 0
                //                 ? double.parse(
                //                         productModel.ratingCount.toString())
                //                     .toStringAsFixed(1)
                //                 : '0.0'
                //             : '0.0',
                //         style: titilliumSemiBold.copyWith(
                //           color: Theme.of(context).hintColor,
                //           fontSize: Dimensions.FONT_SIZE_LARGE,
                //         )),
                //   ),
                //   SizedBox(width: 5),
                //   RatingBar(
                //       rating: productModel.rating != null
                //           ? productModel.ratingCount > 0
                //               ? double.parse(
                //                   productModel.ratingCount.toString())
                //               : 0.0
                //           : 0.0),
                //   Expanded(child: SizedBox.shrink()),
                //   Text(
                //       '${details.reviewList != null ? details.reviewList.length : 0} reviews | ',
                //       style: titilliumRegular.copyWith(
                //         color: Theme.of(context).hintColor,
                //         fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                //       )),
                //   Text('${details.orderCount} orders | ',
                //       style: titilliumRegular.copyWith(
                //         color: Theme.of(context).hintColor,
                //         fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                //       )),
                //   Text('${details.wishCount} wish',
                //       style: titilliumRegular.copyWith(
                //         color: Theme.of(context).hintColor,
                //         fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                //       )),
                // ],
                // ),
              ]);
        },
      ),
    );
  }
}

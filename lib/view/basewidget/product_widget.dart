import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/provider/app_config_provider.dart';
import 'package:shopiana/provider/splash_provider.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/screen/product/product_details_screen.dart';
import 'package:shopiana/view/screen/product/widget/add_to_cart_widget.dart';
import 'package:shopiana/view/screen/product/widget/bottom_cart_view.dart';

class ProductWidget extends StatelessWidget {
  final Product productModel;
  ProductWidget({required this.productModel});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    final url = Provider.of<SplashProvider>(context, listen: false)
            .configModel!
            .domainName! +
        '/products/' +
        productModel.description!.friendlyUrl!;
    final productName = productModel.description?.name;
    return Padding(
      padding: EdgeInsets.all(_width * 0.01),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ProductDetails(product: productModel)));
        },
        child: Container(
          height: _height * 0.14,
          child: Card(
            elevation: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Product Image
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Container(
                    width: _width * 0.2,
                    height: _height * 0.225,
                    alignment: Alignment.topLeft,
                    child: Image.network(
                      productModel.image!.imageUrl.toString(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  width: _width * 0.015,
                ),
                Container(
                    width: _width * 0.67,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: _width * 0.55,
                                    child: Text(
                                      productModel.description!.name!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: _width * 0.03,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await Share.share(
                                          "$productName \n\n $url");

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
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[200]!,
                                                spreadRadius: 1,
                                                blurRadius: 5)
                                          ],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.share,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: Dimensions.ICON_SIZE_SMALL),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: _height * 0.01,
                              ),
                              Container(
                                height: _height * 0.06,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (Provider.of<SplashProvider>(context,
                                            listen: false)
                                        .configModel!
                                        .displayProductPrice!)
                                      Column(
                                        children: [
                                          Container(
                                            child: Text(
                                              productModel
                                                  .productPrice!.finalPrice!,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: _width * 0.04),
                                            ),
                                          ),
                                          SizedBox(
                                            height: _height * 0.002,
                                          ),
                                          if (Provider.of<SplashProvider>(
                                                  context,
                                                  listen: false)
                                              .configModel!
                                              .displayProductPrice!)
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                productModel
                                                    .productPrice!.originalPrice
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: _width * 0.03,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                            ),
                                        ],
                                      ),
                                    Container(
                                        child: AddToCart(product: productModel))
                                  ],
                                ),
                              ),

                              /* Container(
                                    width: _width * 0.36,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            productModel
                                                ?.productPrice?.finalPrice,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 30),
                                          ),
                                          /* SizedBox(
                                            width: _width * 0.02,
                                          ), */
                                          Text(
                                            productModel
                                                ?.productPrice?.originalPrice
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 30,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ), */
                            ],
                          ),
                        ),
                        // Text(productModel.description.description),
                        Container(
                          child: Row(
                            children: [
                              /*  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Theme.of(context)
                                                      .primaryColor)),
                                      child: Text("Add to cart"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: _width * 0.05,
                                  ), */
                              /*       Expanded(
                                    child: OutlinedButton.icon(
                                        style: OutlinedButton.styleFrom(
                                            primary:
                                                Theme.of(context).primaryColor),
                                        label: Text("Share"),
                                        onPressed: () async {
                                          await Share.share(
                                              "$productName \n\n $url");
                                        },
                                        icon: Icon(Icons.share)),
                                  ) */
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

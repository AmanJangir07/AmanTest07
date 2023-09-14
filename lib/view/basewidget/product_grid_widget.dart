import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/helper/price_converter.dart';
import 'package:shopiana/provider/theme_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/screen/product/product_details_screen.dart';
import 'package:provider/provider.dart';

class ProductGridWidget extends StatelessWidget {
  final Product productModel;
  ProductGridWidget({required this.productModel});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(_width * 0.01),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ProductDetails(product: productModel)));
        },
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(top: _height * 0.01),
            height: _height * 0.27,
            decoration: BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Product Image
                Expanded(
                  flex: 4,
                  child: Container(
                    // width: _width * 0.40,
                    child: Image.network(
                      productModel.image!.imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: EdgeInsets.all(_width * 0.02),
                    child: Container(
                        // width: _width * 0.40,
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productModel.description!.name!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: _width * 0.04),
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    productModel.finalPrice!,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: _width * 0.04),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Text(productModel.description.description),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                height: _height * 0.04,
                                width: _width * 0.2,
                                child: OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                        primary:
                                            Theme.of(context).primaryColor),
                                    label: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text("Share")),
                                    onPressed: () {},
                                    icon: Container(
                                        width: _width * 0.027,
                                        child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Icon(Icons.share)))),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/provider/product_provider.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/view/basewidget/title_row.dart';
import 'package:shopiana/view/screen/Group/all_product_group_screen.dart';

class ProductGroupWidget extends StatelessWidget {
  ProductProvider product;
  ProductGroupWidget(this.product);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: product.groupProducts!.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleRow(
                title: product.groupProducts!.keys.elementAt(index),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AllProductGroupScreen(
                          products: product.groupProducts!.values
                              .elementAt(index)
                              .products,
                          groupName:
                              product.groupProducts!.keys.elementAt(index)),
                    ),
                  );
                },
              ),
              /* Text(
                          
                          style: TextStyle(
                              fontSize: _width * 0.033,
                              fontWeight: FontWeight.w400),
                        ), */
              SizedBox(
                height: _height * 0.015,
              ),
              Container(
                  child: /* ListView.builder(
                              shrinkWrap: true,
                              itemCount: min(
                                  4,
                                  product.groupProducts.values
                                      .elementAt(index)
                                      .products
                                      .length),
                              itemBuilder: (context, ind) {
                                return;
                              }), */
                      StaggeredGridView.countBuilder(
                crossAxisCount: Constants.PRODUCT_CROSS_AXIS_COUNT,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: _width * 0.02,
                crossAxisSpacing: _width * 0.02,
                itemCount: product.groupProducts!.values
                            .elementAt(index)
                            .products!
                            .length <=
                        4
                    ? product.groupProducts!.values
                        .elementAt(index)
                        .products!
                        .length
                    : 4,
                shrinkWrap: true,
                staggeredTileBuilder: (int i) => StaggeredTile.fit(1),
                itemBuilder: (BuildContext context, int i) {
                  return Material(
                    elevation: 4,
                    child: Container(
                      width: _width * 0.3,
                      height: _height * 0.17,
                      child: Column(
                        children: [
                          SizedBox(
                            height: _height * 0.006,
                          ),
                          Container(
                            width: _width * 0.4,
                            height: _height * 0.13,
                            child: product.groupProducts?.values
                                        .elementAt(index)
                                        .products
                                        ?.elementAt(i)
                                        .image
                                        ?.imageUrl !=
                                    null
                                ? Image.network(
                                    product.groupProducts!.values
                                        .elementAt(index)
                                        .products!
                                        .elementAt(i)
                                        .image!
                                        .imageUrl!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    Images.no_image,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Container(
                            child: Text(
                              product.groupProducts!.values
                                  .elementAt(index)
                                  .products!
                                  .elementAt(i)
                                  .description!
                                  .name!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: false,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ))
            ],
          );
        });
  }
}

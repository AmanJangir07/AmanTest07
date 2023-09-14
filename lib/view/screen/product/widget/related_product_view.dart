import 'package:flutter/material.dart';
import 'package:shopiana/provider/product_provider.dart';
import 'package:shopiana/view/basewidget/product_grid_widget.dart';
import 'package:shopiana/view/basewidget/product_shimmer.dart';
import 'package:shopiana/view/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class RelatedProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        return Column(children: [
          prodProvider.relatedProductList != null
              ? prodProvider.relatedProductList!.length != 0
                  ? StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemCount: prodProvider.relatedProductList!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductGridWidget(
                            productModel:
                                prodProvider.relatedProductList![index]);
                      },
                    )
                  : Center(child: Text('No related Product'))
              : ProductShimmer(
                  isEnabled: Provider.of<ProductProvider>(context)
                          .relatedProductList ==
                      null),
        ]);
      },
    );
  }
}

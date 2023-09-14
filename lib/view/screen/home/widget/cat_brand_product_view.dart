import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/helper/product_type.dart';
import 'package:shopiana/provider/product_provider.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/view/basewidget/product_shimmer.dart';
import 'package:shopiana/view/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/view/screen/more/widget/loading_widget.dart';

class CategoryBrandProductView extends StatefulWidget {
  final ProductType? productType;
  final ScrollController? scrollController;
  final String? sellerId;
  final int id;
  final bool isBrand;
  CategoryBrandProductView(
      {this.productType,
      this.scrollController,
      this.sellerId,
      required this.id,
      required this.isBrand});

  @override
  _CategoryBrandProductViewState createState() =>
      _CategoryBrandProductViewState();
}

class _CategoryBrandProductViewState extends State<CategoryBrandProductView> {
  int _page = 0;
  bool isLoading = false;

  @override
  void initState() {
    var dataProvider = Provider.of<ProductProvider>(context, listen: false);
    dataProvider.initBrandOrCategoryProductList(
        context: context,
        isBrand: widget.isBrand,
        id: widget.id.toString(),
        pageNumber: _page,
        count: Constants.DEFAULT_COUNT);
    widget.scrollController!.addListener(() {
      if (widget.scrollController!.position.pixels ==
          widget.scrollController!.position.maxScrollExtent) {
        dataProvider.setLoadingState(LoadMoreStatus.LOADING);
        dataProvider.initBrandOrCategoryProductList(
            context: context,
            isBrand: widget.isBrand,
            id: widget.id.toString(),
            pageNumber: ++_page,
            count: Constants.DEFAULT_COUNT);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        List<Product> productList;
        productList = prodProvider.brandOrCategoryProductList;
        // if (widget.productType == ProductType.LATEST_PRODUCT) {
        //   productList = prodProvider.latestProductList;
        // } else if (widget.productType == ProductType.SELLER_PRODUCT) {
        //   productList = prodProvider.sellerProductList;
        // }

        return Column(children: [
          !prodProvider.firstLoadingProduct
              ? productList.length != 0
                  ? StaggeredGridView.countBuilder(
                      itemCount: productList.length,
                      crossAxisCount: Constants.PRODUCT_CROSS_AXIS_COUNT,
                      padding: EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                      itemBuilder: (BuildContext context, int index) {
                        // if((index ==  prodProvider.latestProductList.length -1) && prodProvider.latestProductList)
                        return ProductWidget(productModel: productList[index]);
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
    // TODO: implement dispose
    // widget.scrollController.dispose();
    super.dispose();
  }
}

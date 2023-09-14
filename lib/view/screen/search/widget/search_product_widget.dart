import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/provider/search_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/view/basewidget/product_widget.dart';
import 'package:shopiana/view/screen/search/widget/search_filter_bottom_sheet.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class SearchProductWidget extends StatelessWidget {
  final bool? isViewScrollable;
  final List<Product>? products;
  SearchProductWidget({this.isViewScrollable, this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: Provider.of<SearchProvider>(context).isSearching
          ? CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            )
          : Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Search result for \"${Provider.of<SearchProvider>(context).searchText}\" (${products!.length} items)',
                        style: titilliumRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_DEFAULT),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (c) => SearchFilterBottomSheet()),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            horizontal: Dimensions.PADDING_SIZE_SMALL),
                        decoration: BoxDecoration(
                          color: ColorResources.getLowGreen(context),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              width: 1, color: Theme.of(context).hintColor),
                        ),
                        child: Row(children: [
                          Image.asset(Images.filter_image,
                              width: 10,
                              height: 10,
                              color: ColorResources.getPrimary(context)),
                          SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          Text('Filter'),
                        ]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(0),
                    crossAxisCount: 1,
                    itemCount: products!.length,
                    //shrinkWrap: true,
                    staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                    itemBuilder: (BuildContext context, int index) {
                      return ProductWidget(productModel: products![index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/provider/product_details_provider.dart';
import 'package:shopiana/provider/theme_provider.dart';
import 'package:shopiana/provider/wishlist_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/screen/product/product_image_screen.dart';
import 'package:shopiana/view/screen/product/widget/favourite_button.dart';
import 'package:provider/provider.dart';

class ProductImageView extends StatelessWidget {
  final Product productModel;
  ProductImageView({required this.productModel});

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ProductImageScreen(
                  imageList:
                      productModel.images!.map((e) => e.imageUrl).toList(),
                  title: productModel.description!.name))),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(20),
              //     bottomRight: Radius.circular(20)),
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.grey[300], spreadRadius: 1, blurRadius: 5)
              // ],
              // gradient: Provider.of<ThemeProvider>(context).darkTheme
              //     ? null
              //     : LinearGradient(
              //         colors: [ColorResources.WHITE, ColorResources.IMAGE_BG],
              //         begin: Alignment.topLeft,
              //         end: Alignment.bottomRight,
              //       ),
            ),
            child: Stack(children: [
              SizedBox(
                height: MediaQuery.of(context).size.width - 100,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: productModel.images!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
                      child: Hero(
                        tag: 'image-${productModel.id}',
                        child: Image.network(
                          productModel.images![index].imageUrl.toString(),
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    );
                  },
                  onPageChanged: (index) {
                    Provider.of<ProductDetailsProvider>(context, listen: false)
                        .setImageSliderSelectedIndex(index);
                  },
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _indicators(context),
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 20,
              //   right: 20,
              //   child: FavouriteButton(
              //     backgroundColor: ColorResources.getImageBg(context),
              //     favColor: ColorResources.getPrimary(context),
              //     isSelected:
              //         Provider.of<WishListProvider>(context, listen: false)
              //             .isWish,
              //     product: productModel,
              //   ),
              // ), // Favourite Button
            ]),
          ),
        ),

        // Image List
        Container(
          height: 60,
          // margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          alignment: Alignment.center,
          color: Colors.grey[100],
          child: ListView.builder(
            itemCount: productModel.images!.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _controller.animateToPage(index,
                      duration: Duration(microseconds: 300),
                      curve: Curves.easeInOut);
                },
                child: Container(
                  width: 60,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).accentColor,
                    border: Provider.of<ProductDetailsProvider>(context)
                                .imageSliderIndex ==
                            index
                        ? Border.all(
                            color: Theme.of(context).primaryColor, width: 2)
                        : null,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: Image.network(
                      productModel.images![index].imageUrl.toString(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _indicators(BuildContext context) {
    List<Widget> indicators = [];
    for (int index = 0; index < productModel.images!.length; index++) {
      indicators.add(TabPageSelectorIndicator(
        backgroundColor: index ==
                Provider.of<ProductDetailsProvider>(context).imageSliderIndex
            ? Theme.of(context).primaryColor
            : ColorResources.WHITE,
        borderColor: ColorResources.WHITE,
        size: 10,
      ));
    }
    return indicators;
  }
}

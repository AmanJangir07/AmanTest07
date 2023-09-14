import 'package:flutter/material.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/category_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/screen/category/all_category_screen.dart';
import 'package:shopiana/view/screen/product/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CategoryView extends StatelessWidget {
  final bool isHomePage;
  CategoryView({required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    Provider.of<CategoryProvider>(context, listen: false)
        .initCategoryList(context: context);

    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        return categoryProvider.categoryList.length != 0
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: isHomePage
                    ? categoryProvider.categoryList.length > 8
                        ? 8
                        : categoryProvider.categoryList.length
                    : categoryProvider.categoryList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (categoryProvider
                              .categoryList[index].children!.length >
                          0) {
                        categoryProvider.changeSelectedIndex(index);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AllCategoryScreen()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BrandAndCategoryProductScreen(
                                      isBrand: false,
                                      id: categoryProvider
                                          .categoryList[index].id
                                          .toString(),
                                      name: categoryProvider.categoryList[index]
                                          .description!.name,
                                    )));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            Dimensions.PADDING_SIZE_SMALL),
                        color: Theme.of(context).accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          )
                        ],
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 4),
                                child: Image.network(
                                  categoryProvider.categoryList[index].image
                                              ?.path ==
                                          null
                                      ? ''
                                      : categoryProvider
                                          .categoryList[index].image!.path!,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Image.asset(
                                      Constants.DEFAULT_NO_IMAGE_SRC.isEmpty
                                          ? ''
                                          : Constants.DEFAULT_NO_IMAGE_SRC,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Text('No image');
                                      },
                                      fit: BoxFit.fill,
                                    );
                                  },
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    //color: ColorResources.getTextBg(context),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      categoryProvider.categoryList.length != 0
                                          ? categoryProvider.categoryList[index]
                                              .description!.name!
                                          : getTranslated('CATEGORY', context)!,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                          ]),
                    ),
                  );
                },
              )
            : CategoryShimmer();
      },
    );
  }
}

class CategoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: (1.4),
      ),
      itemCount: 4,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: Colors.grey[200]!, spreadRadius: 2, blurRadius: 5)
          ]),
          margin: EdgeInsets.all(3),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
              flex: 7,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                enabled: Provider.of<CategoryProvider>(context)
                        .categoryList
                        .length ==
                    0,
                child: Container(
                    decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                )),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorResources.getTextBg(context),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    enabled: Provider.of<CategoryProvider>(context)
                            .categoryList
                            .length ==
                        0,
                    child: Container(
                        height: 10,
                        color: Colors.white,
                        margin: EdgeInsets.only(left: 15, right: 15)),
                  ),
                )),
          ]),
        );
      },
    );
  }
}

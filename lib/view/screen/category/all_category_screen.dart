import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/category.dart';
import 'package:shopiana/data/model/response/config_model.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/cart_provider.dart';
import 'package:shopiana/provider/category_provider.dart';
import 'package:shopiana/provider/splash_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/view/basewidget/custom_app_bar.dart';
import 'package:shopiana/view/screen/cart/cart_screen.dart';
import 'package:shopiana/view/screen/category/widget/all_sub_category_widget.dart';
import 'package:shopiana/view/screen/category/widget/sub_category_widget.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/view/screen/dashboard/dashboard_screen.dart';

class AllCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NetworkInfo.checkConnectivity(context);
    double _width = MediaQuery.of(context).size.width;
    ConfigModel config =
        Provider.of<SplashProvider>(context, listen: false).configModel!;
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        leading: InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => DashBoardScreen(),
                ),
                (route) => false)),
        title: Text(
          "Category",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          config.allowOnlinePurchase!
              ? Consumer<CartProvider>(builder: (_, cart, ch) {
                  return IconButton(
                    onPressed: () {
                      // if (cart.cartItems.isNotEmpty) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CartScreen()));
                      // }
                    },
                    icon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset(
                          Images.cart_image,
                          color: Theme.of(context).primaryColor,
                          height: Dimensions.ICON_SIZE_DEFAULT,
                          width: Dimensions.ICON_SIZE_DEFAULT,
                        ),
                        Positioned(
                          top: -4,
                          right: -4,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text(cart.cartItems.length.toString(),
                                style: titilliumSemiBold.copyWith(
                                  color: ColorResources.WHITE,
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                )),
                          ),
                        ),
                      ],
                    ),
                  );
                })
              : SizedBox()
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          /*  CustomAppBar(title: getTranslated('CATEGORY', context)), */
          Expanded(child: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
              return categoryProvider.categoryList.length != 0
                  ? Row(children: [
                      Container(
                        width: 100,
                        margin: EdgeInsets.only(top: 3),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          /* boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200]!,
                                spreadRadius: 1,
                                blurRadius: 1)
                          ], */
                        ),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: categoryProvider.categoryList.length,
                          padding: EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            Category _category =
                                categoryProvider.categoryList[index];
                            return InkWell(
                              onTap: () {
                                Provider.of<CategoryProvider>(context,
                                        listen: false)
                                    .changeSelectedIndex(index);
                              },
                              child: CategoryItem(
                                title: _category.description!.name,
                                icon: _category.image!.path,
                                isSelected:
                                    categoryProvider.categorySelectedIndex ==
                                        index,
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: _width * 0.05,
                              left: _width * 0.03,
                              right: _width * 0.03),
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.9,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemCount: categoryProvider
                                      .categoryList[categoryProvider
                                          .categorySelectedIndex!]
                                      .children!
                                      .length +
                                  1,
                              itemBuilder: (BuildContext ctx, index) {
                                if (index == 0) {
                                  return AllSubCategoryWidget(categoryProvider
                                          .categoryList[
                                      categoryProvider.categorySelectedIndex!]);
                                } else {
                                  Children _subCategory = categoryProvider
                                      .categoryList[categoryProvider
                                          .categorySelectedIndex!]
                                      .children![index - 1];
                                  return SubCategoryWidget(_subCategory);
                                }
                              }),
                        ),
                      )
                    ])
                  : Center(
                      child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ));
            },
          )),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String? title;
  final String? icon;
  final bool isSelected;
  CategoryItem(
      {required this.title, required this.icon, required this.isSelected});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Container(
        width: 100,
        height: 100,
        /*  margin: EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: 2), */
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(10),
            color: isSelected ? Colors.white70 : null,
            border: Border(
                left: BorderSide(
                    width: 5,
                    strokeAlign: StrokeAlign.inside,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.transparent))),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: isSelected
                            ? Colors.black
                            : Theme.of(context).hintColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      icon == null ? '' : icon!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Text(title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: titilliumSemiBold.copyWith(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                        color: isSelected
                            ? Colors.black
                            : Theme.of(context).hintColor,
                      )),
                ),
              ]),
        ),
      ),
    );
  }
}

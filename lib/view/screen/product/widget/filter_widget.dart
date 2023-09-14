import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/category.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/category_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/basewidget/custom_app_bar.dart';
import 'package:shopiana/view/screen/category/widget/all_sub_category_widget.dart';
import 'package:shopiana/view/screen/category/widget/sub_category_widget.dart';
import 'package:provider/provider.dart';

class FilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NetworkInfo.checkConnectivity(context);
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        children: [
          CustomAppBar(title: "Filter"),
          Expanded(child: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
              return categoryProvider.categoryList.length != 0
                  ? Row(children: [
                      Container(
                        width: 100,
                        margin: EdgeInsets.only(top: 3),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200]!,
                                spreadRadius: 1,
                                blurRadius: 1)
                          ],
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
                                child: Text("Manufacturer"));
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: _width * 0.03, right: _width * 0.03),
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: _width * 0.2,
                                      childAspectRatio: 2 / 3,
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

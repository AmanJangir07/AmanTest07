import 'package:flutter/material.dart';
import 'package:shopiana/provider/brand_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/screen/product/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BrandView extends StatelessWidget {
  final bool isHomePage;
  BrandView({required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    Provider.of<BrandProvider>(context, listen: false).initBrandList();
    return Consumer<BrandProvider>(
      builder: (context, brandProvider, child) {
        return brandProvider.brandList.length > 0
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: brandProvider.brandList.length != 0
                    ? isHomePage
                        ? brandProvider.brandList.length > 8
                            ? 8
                            : brandProvider.brandList.length
                        : brandProvider.brandList.length
                    : 8,
                shrinkWrap: true,
                physics: isHomePage
                    ? NeverScrollableScrollPhysics()
                    : BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BrandAndCategoryProductScreen(
                              isBrand: true,
                              id: brandProvider.brandList[index].id.toString(),
                              name: brandProvider
                                  .brandList[index].description!.name,
                              // categoryCode: brandProvider.brandList[index].code,
                              image:
                                  'https://cdn.dribbble.com/users/10882/screenshots/15172621/media/cd2246d5d0f54f9a4316bd4d276764b2.png?compress=1&resize=400x300'),
                        ),
                      );
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
                            child: /* Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.15),
                                        blurRadius: 5,
                                        spreadRadius: 1)
                                  ]),
                              child: */ /* ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: */
                                Container(
                              child: brandProvider
                                          .brandList[index].image?.imageUrl !=
                                      null
                                  ? Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Image.network(
                                        brandProvider
                                            .brandList[index].image!.imageUrl!,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Image.asset(
                                        Constants.DEFAULT_NO_IMAGE_SRC,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                            ),
                            /* ), */
                          ),
                          /*    ), */
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
                                    brandProvider
                                        .brandList[index].description!.name!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : BrandShimmer(isHomePage: isHomePage);
      },
    );
  }
}

class BrandShimmer extends StatelessWidget {
  final bool isHomePage;
  BrandShimmer({required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: (1 / 1.3),
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
      ),
      itemCount: isHomePage ? 8 : 30,
      shrinkWrap: true,
      physics: isHomePage ? NeverScrollableScrollPhysics() : null,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          enabled: Provider.of<BrandProvider>(context).brandList.length == 0,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: ColorResources.WHITE, shape: BoxShape.circle))),
            Container(
                height: 10,
                color: ColorResources.WHITE,
                margin: EdgeInsets.only(left: 25, right: 25)),
          ]),
        );
      },
    );
  }
}

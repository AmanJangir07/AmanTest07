import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/category.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/screen/product/brand_and_category_product_screen.dart';

class SubCategoryWidget extends StatelessWidget {
  final Children subCatData;
  SubCategoryWidget(this.subCatData);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BrandAndCategoryProductScreen(
                        isBrand: false,
                        id: subCatData.id.toString(),
                        name: subCatData.description!.name,
                      )));
          // Navigator.of(context).pushNamed(ProductOverviewScreen.routeName,
          //     arguments: subCatData.id);
        },
        child: Container(
            margin: EdgeInsets.fromLTRB(1, 0, 1, 0),
            // width: 80,
            // widthFactor
            // height: 80,
            decoration: BoxDecoration(
                // border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              children: [
                Expanded(
                  flex: 10,
                  child: Container(
                    // width: 80,
                    width: double.infinity,
                    // height: 65,
                    // decoration: BoxDecoration(color: Colors.green),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(7),
                          topLeft: Radius.circular(7)),
                      child: Image.network(
                        subCatData.image!.path == null
                            ? ''
                            : subCatData.image!.path!,
                        // '${API.BASE_URL}/{subCatData.image.path}',
                        // width: 80,
                        // height: 65,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    // width: 80,
                    // height: 13,
                    child: Text(
                      subCatData.description!.name!,
                      style: TextStyle(
                          fontSize: Dimensions.FONT_SIZE_DEFAULT,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        //color: Colors.lightGreen[200],
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(7),
                            bottomRight: Radius.circular(7))),
                  ),
                )
              ],
            )));
  }
}

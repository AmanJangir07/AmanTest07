import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/view/screen/product/product_details_screen.dart';

class AllProductGroupScreen extends StatelessWidget {
  List<Product>? products = [];
  String? groupName;
  AllProductGroupScreen({this.products, this.groupName});
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(groupName!),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              mainAxisSpacing: _width * 0.02,
              crossAxisSpacing: _width * 0.02,
              itemCount: products?.length,
              shrinkWrap: true,
              staggeredTileBuilder: (int i) => StaggeredTile.fit(1),
              itemBuilder: (BuildContext context, int i) {
                return Material(
                  elevation: 4,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ProductDetails(product: products![i])));
                    },
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
                            child:
                                products?.elementAt(i).image?.imageUrl != null
                                    ? Image.network(
                                        products!.elementAt(i).image!.imageUrl!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        Images.no_image,
                                        fit: BoxFit.cover,
                                      ),
                          ),
                          Container(
                            child: Text(
                              products!.elementAt(i).description!.name!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: false,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

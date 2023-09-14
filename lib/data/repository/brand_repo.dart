import 'dart:developer';

import 'package:shopiana/data/model/response/brand_model.dart';
import 'package:shopiana/helper/api.dart';
import 'package:shopiana/helper/api_base_helper.dart';

class BrandRepo {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<BrandModel>> getBrandList() async {
    List<BrandModel> brandList = [];
    dynamic extractedData;
    String url = API.getBrandList();

    final response = await _helper.get(url: url);
    extractedData = response['manufacturers'] as dynamic;
    if (extractedData != null) {
      extractedData.forEach((brand) {
        if (brand != null) {
          BrandModel brandModel = BrandModel.fromJson(brand);
          brandList.add(brandModel);
        }
      });
    }
    return brandList;
  }
}

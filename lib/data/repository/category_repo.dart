import 'dart:developer';

import 'package:shopiana/helper/api.dart';
import 'package:shopiana/helper/api_base_helper.dart';

class CategoryRepo {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<dynamic> getCategoryList() async {
    String url = API.GET_ALL_CATEGORIES_URL;
    log("url is " + url);
    // List<Category> allCategories = [];
    final response = await _helper.get(url: url);
    final extractedData = response as dynamic;
    // if (extractedData != null) {
    //   extractedData.forEach((category) {
    //     Category currCat = Category.fromJson(category);
    //     allCategories.add(currCat);
    //   });
    // }
    return extractedData;
  }

  Future<dynamic> getCategoryDefinitionList() async {
    String url = API.GET_CATEGORY_DEFINITION;
    log("url is " + url);
    // List<Category> allCategories = [];
    final response = await _helper.get(url: url);
    final extractedData = response as dynamic;
    // if (extractedData != null) {
    //   extractedData.forEach((category) {
    //     Category currCat = Category.fromJson(category);
    //     allCategories.add(currCat);
    //   });
    // }
    return extractedData;
  }
}

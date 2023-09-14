import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/data/repository/auth_repo.dart';
import 'package:shopiana/helper/api.dart';
import 'package:shopiana/helper/api_base_helper.dart';
import 'package:shopiana/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRepo {
  final SharedPreferences? sharedPreferences;
  final ApiBaseHelper? apiBaseHelper;
  final AuthRepo? authRepo;
  SearchRepo(
      {required this.sharedPreferences,
      required this.apiBaseHelper,
      required this.authRepo});

  // for save home address
  Future<void> saveSearchAddress(String searchAddress) async {
    List<String> searchKeywordList =
        sharedPreferences!.getStringList(AppConstants.SEARCH_ADDRESS)!;
    if (!searchKeywordList.contains(searchAddress)) {
      searchKeywordList.add(searchAddress);
    }
    await sharedPreferences!.setStringList(
        AppConstants.SEARCH_ADDRESS, searchKeywordList);
  }

  Future<List<String>> getAutoCompleteSearch(dynamic data) async {
    List<String> searchResults = [];
    String url = API.getSearchAutoComplete();
    String token = authRepo!.getUserToken();

    var extractedData;

    extractedData = await apiBaseHelper!.post(url, data, token);
    extractedData['values'].forEach((item) {
      searchResults.add(item);
    });
    return searchResults;
  }

  Future<List<Product>> getSearchProductList(dynamic data) async {
    List<Product> searchResults = [];
    String url = API.getSearchProducts();
    //String token = authRepo.getUserToken();
    var extractedData;
    extractedData = await apiBaseHelper!.post(url, data, "");
    extractedData['products'].forEach((item) {
      Product product = Product.fromJson(item);
      searchResults.add(product);
    });
    return searchResults;
  }

  List<String> getSearchAddress() {
    return sharedPreferences!.getStringList(AppConstants.SEARCH_ADDRESS) ?? [];
  }

  Future<bool> clearSearchAddress() async {
    return sharedPreferences!.setStringList(AppConstants.SEARCH_ADDRESS, []);
  }
}

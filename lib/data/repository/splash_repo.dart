import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/app_config.dart';
import 'package:shopiana/data/model/response/config_model.dart';
import 'package:shopiana/helper/api.dart';
import 'package:shopiana/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopiana/helper/api_base_helper.dart';

class SplashRepo {
  final SharedPreferences? sharedPreferences;
  SplashRepo({required this.sharedPreferences});
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<ConfigModel> getConfig() async {
    String url = API.MOBILE_INITIAL_CONFIG;
    ConfigModel configModel = ConfigModel();
    final response = await _helper.get(url: url);
    print("get config response" + response.toString());
    final extractedData = response as dynamic;
    if (extractedData != null) {
      configModel = ConfigModel.fromJson(extractedData);
    }
    // configModel.currencyList = [];
    // configModel.currencyList.add(CurrencyList(
    //     id: 1, name: 'USD', symbol: '\$', code: 'USD', exchangeRate: '1.00'));
    // configModel.currencyList.add(CurrencyList(
    //     id: 2, name: 'BDT', symbol: '৳', code: 'BDT', exchangeRate: '84.00'));
    // configModel.currencyList.add(CurrencyList(
    //     id: 3,
    //     name: 'Indian Rupi',
    //     symbol: '₹',
    //     code: 'Rupi',
    //     exchangeRate: '60.00'));

    return configModel;
  }

  List<String> getLanguageList() {
    List<String> languageList = ['English', 'Bengali', 'Hindi'];
    return languageList;
  }

  Future<void> initSharedData() async {
    String url = API.GET_INITIAL_CONFIG;
    AppConfig initialConfig;
    final response = await _helper.get(url: url);
    final extractedData = response as dynamic;
    if (extractedData != null) {
      initialConfig = AppConfig.fromJson(extractedData);
      setDisplayWishList(initialConfig.displayWishList!);
      setAllowGuestUser(initialConfig.allowGuestUser!);
    }

    // if (!sharedPreferences.containsKey(AppConstants.CART_LIST)) {
    //   sharedPreferences.setStringList(AppConstants.CART_LIST, []);
    // }
    // if (!sharedPreferences.containsKey(AppConstants.SEARCH_ADDRESS)) {
    //   sharedPreferences.setStringList(AppConstants.SEARCH_ADDRESS, []);
    // }
    // if(!sharedPreferences.containsKey(AppConstants.CURRENCY)) {
    //   sharedPreferences.setString(AppConstants.CURRENCY, 'USD');
    // }
  }

  String getCurrency() {
    return sharedPreferences!.getString(AppConstants.CURRENCY) ?? 'USD';
  }

  bool getDisplayWishList() {
    return sharedPreferences!.getBool(AppConstants.DISPLAY_WISH_LIST) ?? true;
  }

  bool getAllowGuestUser() {
    return sharedPreferences!.getBool(AppConstants.ALLOW_GUEST_USER) ?? true;
  }

  void setCurrency(String currencyCode) {
    sharedPreferences!.setString(AppConstants.CURRENCY, currencyCode);
  }

  void setDisplayWishList(bool value) {
    sharedPreferences!.setBool(AppConstants.DISPLAY_WISH_LIST, value);
  }

  void setAllowGuestUser(bool value) {
    sharedPreferences!.setBool(AppConstants.ALLOW_GUEST_USER, value);
  }
}

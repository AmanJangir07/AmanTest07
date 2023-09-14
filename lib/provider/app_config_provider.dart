import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopiana/data/model/response/app_config.dart';

class AppConfigProvider with ChangeNotifier {
  final SharedPreferences? sharedPreferences;
  // final AppConfigRepo appConfigRepo;

  bool? displayProductList;

  AppConfigProvider({required this.sharedPreferences});
  /*  Future<AppConfig> getAppConfig(String storeCode) async {
    // return appConfigRepo.getAppConfig();
  } */

  bool? getDisplayProductListBool() {
    if (sharedPreferences!.containsKey('displayProductList')) {
      return sharedPreferences!.getBool("displayProductList");
    } else {
      return true;
    }
  }
}

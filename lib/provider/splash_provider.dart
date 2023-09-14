import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/data/model/response/config_model.dart';
import 'package:shopiana/data/repository/splash_repo.dart';
import 'package:shopiana/helper/app_exception.dart';
import 'dart:convert';

import 'package:shopiana/provider/cart_provider.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepo? splashRepo;
  SplashProvider({required this.splashRepo});

  ConfigModel? _configModel;
  // CurrencyList _currency;
  List<String>? _languageList;
  int _currencyIndex = 0;
  int _languageIndex = 0;
  bool _fromSetting = false;
  bool _firstTimeConnectionCheck = true;

  // Initial App Configs
  bool _displayWishList = false;
  bool _allowGuestUser = false;

  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;
  ConfigModel? get configModel => _configModel;
  // CurrencyList get currency => _currency;
  List<String>? get languageList => _languageList;
  int get currencyIndex => _currencyIndex;
  int get languageIndex => _languageIndex;
  bool get fromSetting => _fromSetting;

  bool get dispalyWishList => _displayWishList;
  bool get allowGuestUser => _allowGuestUser;

  Future<bool> initConfig() async {
    try {
      _configModel = await splashRepo!.getConfig();
      this._configModel = _configModel;
    } on AppException catch (e) {
      print(e.message);
    }

    // getCurrencyData(splashRepo.getCurrency());
    // _languageList = splashRepo.getLanguageList();
    // _displayWishList = splashRepo.getDisplayWishList();
    // _allowGuestUser = splashRepo.getAllowGuestUser();

    notifyListeners();
    return Future.value(true);
  }

  // void getCurrencyData(String currencyCode) {
  //   _configModel.currencyList.forEach((currency) {
  //     if (currencyCode == currency.code) {
  //       _currency = currency;
  //       _currencyIndex = _configModel.currencyList.indexOf(currency);
  //       return;
  //     }
  //   });
  // }

  // void setCurrency(int index) {
  //   splashRepo.setCurrency(_configModel.currencyList[index].code);
  //   getCurrencyData(_configModel.currencyList[index].code);
  //   notifyListeners();
  // }

  Future<bool> initSharedPrefData() async {
    try {
      await splashRepo!.initSharedData();
    } on AppException catch (e) {
      print(e.message);
    }
    return Future.value(true);
  }

  void setFromSetting(bool isSetting) {
    _fromSetting = isSetting;
  }

  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/brand_model.dart';
import 'package:shopiana/data/repository/brand_repo.dart';
import 'package:shopiana/helper/app_exception.dart';

class BrandProvider extends ChangeNotifier {
  final BrandRepo? brandRepo;

  BrandProvider({required this.brandRepo});

  List<BrandModel> _brandList = [];

  List<BrandModel> get brandList => _brandList;

  List<BrandModel> _originalBrandList = [];

  void initBrandList() async {
    try {
      if (_brandList.length == 0) {
        _originalBrandList.clear();
        _brandList = await brandRepo!.getBrandList();
        notifyListeners();
      }
    } on AppException catch (e) {
      log(e.message!);
    }
  }

  bool isTopBrand = true;
  bool isAZ = false;
  bool isZA = false;

  void sortBrandLis(String value) {
    // if (value == Strings.top_brand) {
    //   _brandList.clear();
    //   _brandList.addAll(_originalBrandList);
    //   isTopBrand = true;
    //   isAZ = false;
    //   isZA = false;
    // } else if (value == Strings.alphabetically_az) {
    //   _brandList.clear();
    //   _brandList.addAll(_originalBrandList);
    //   _brandList.sort((a, b) => a.name.compareTo(b.name));
    //   isTopBrand = false;
    //   isAZ = true;
    //   isZA = false;
    // } else if (value == Strings.alphabetically_za) {
    //   _brandList.clear();
    //   _brandList.addAll(_originalBrandList);
    //   _brandList.sort((a, b) => a.name.compareTo(b.name));
    //   Iterable iterable = _brandList.reversed;
    //   _brandList = iterable.toList();
    //   isTopBrand = false;
    //   isAZ = false;
    //   isZA = true;
    // }

    notifyListeners();
  }
}

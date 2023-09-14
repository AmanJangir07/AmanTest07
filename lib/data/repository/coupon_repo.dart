import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopiana/data/model/response/coupon_model.dart';
import 'package:shopiana/data/repository/auth_repo.dart';
import 'package:shopiana/helper/api.dart';
import 'package:shopiana/helper/api_base_helper.dart';

class CouponRepo {
  final ApiBaseHelper? apiBaseHelper;
  final SharedPreferences? sharedPreferences;
  CouponRepo({required this.sharedPreferences, required this.apiBaseHelper});

  Future<List<CouponModel>> getCoupons({String? url}) async {
    final url = API.getCoupons();

    final response = await apiBaseHelper!.get(
      url: url,
    );
    var extractedData = response as List?;
    List<CouponModel> couponlist = [];
    if (extractedData != null) {
      couponlist =
          extractedData.map((data) => CouponModel.fromJson(data)).toList();
      return couponlist;
    }
    return couponlist;
  }

  CouponModel getCoupon() {
    CouponModel couponModel = CouponModel(
        id: 1,
        title: '',
        code: 'ABC',
        minPurchase: '100',
        maxDiscount: '1000',
        discount: '60',
        discountType: 'percent');
    return couponModel;
  }
}

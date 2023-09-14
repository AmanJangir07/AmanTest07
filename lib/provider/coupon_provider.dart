import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/coupon_model.dart';
import 'package:shopiana/data/repository/cart_repo.dart';
import 'package:shopiana/data/repository/coupon_repo.dart';
import 'package:shopiana/helper/app_exception.dart';
import 'package:shopiana/utill/snackbar.dart';

class CouponProvider extends ChangeNotifier {
  final CouponRepo? couponRepo;
  final CartRepo? cartRepo;
  CouponProvider({required this.couponRepo, required this.cartRepo});

  CouponModel? _coupon;
  double? _discount;
  bool _isLoading = false;
  List<CouponModel> couponList = [];
  get getCouponList => this.couponList;

  CouponModel? get coupon => _coupon;
  double? get discount => _discount;
  bool get isLoading => _isLoading;

  // Future<void> applyCoupon(String couponCode) async {
  //   dynamic applyCouponResponse;

  //   final String cartCode = cartRepo.getCartCode();

  //   if (cartCode.isNotEmpty) {
  //     applyCouponResponse = CartModel.fromJson(
  //       await cartRepo.applyCoupon(cartCode, couponCode, {}),
  //     );
  //     // cartRepo.getCart(cartCode);

  //   }
  // }

  // Future<void> removeCoupon() async {
  //   final String cartCode = cartRepo.getCartCode();
  //   if (cartCode.isNotEmpty) {
  //     CartModel response =
  //         CartModel.fromJson(await cartRepo.removeCoupon(cartCode));
  //   }
  // }
  Future<void> getCoupons({required BuildContext context}) async {
    try {
      couponList = await couponRepo!.getCoupons();
    } on AppException catch (e) {
      showErrorSnackbar(context, e.message!);
    }
    notifyListeners();
  }

  double? initCoupon() {
    _coupon = couponRepo!.getCoupon();
    if (_coupon!.minPurchase != null &&
        double.parse(_coupon!.minPurchase!) < 1000) {
      if (_coupon!.discountType == 'percentage') {
        _discount = (double.parse(_coupon!.discount!) * 1000 / 100) <
                double.parse(_coupon!.maxDiscount!)
            ? (double.parse(_coupon!.discount!) * 1000 / 100)
            : double.parse(_coupon!.maxDiscount!);
      } else {
        _discount = double.parse(_coupon!.discount!);
      }
    } else {
      _discount = 0;
    }
    notifyListeners();
    return _discount;
  }

  void removePrevCouponData() {
    _coupon = null;
    _isLoading = false;
    _discount = null;
  }
}

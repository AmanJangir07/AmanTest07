import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopiana/data/model/response/cart_model.dart';
import 'package:shopiana/data/repository/auth_repo.dart';
import 'package:shopiana/helper/api.dart';
import 'package:shopiana/helper/api_base_helper.dart';
import 'package:shopiana/utill/app_constants.dart';

class CartRepo {
  final ApiBaseHelper? apiBaseHelper;
  final SharedPreferences? sharedPreferences;
  final AuthRepo? authRepo;
  CartRepo(
      {required this.authRepo,
      required this.sharedPreferences,
      required this.apiBaseHelper});

  List<CartModel> getCartList() {
    // List<String> carts = sharedPreferences.getStringList(AppConstants.CART_LIST);
    List<CartModel> cartList = [];
    // carts.forEach((cart) => cartList.add(CartModel.fromJson(jsonDecode(cart))) );
    return cartList;
  }

  // void addToCartList(List<CartModel> cartProductList) {
  //   List<String> carts = [];
  //   cartProductList.forEach((cartModel) => carts.add(jsonEncode(cartModel)));
  //   sharedPreferences.setStringList(AppConstants.CART_LIST, carts);
  // }

  Future<void> mergeCart() async {
    String guestCartCode = getCartCode();
    // if guest have cart
    if (guestCartCode.isNotEmpty) {
      CartModel cart =
          await (getAuthCart(guestCartCode, authRepo!.getUserToken())
              as Future<CartModel>);
      removeCartCode();
      setShopianaCartCode(cart.code!);
    }
  }

  Future<CartModel?> addToCart(Object data) async {
    final url = API.addToCart;
    CartModel? cartResponse;
    try {
      final response = await apiBaseHelper!.post(url, data, '');
      if (response != null) {
        cartResponse = CartModel.fromJson(response);
        setShopianaCartCode(cartResponse.code!);
      }
      log("add to cart response" + response.toString());
      return cartResponse;
    } catch (error) {
      print("error:" + error.toString());
    }
  }

  Future<dynamic> updateCart(String cartCode, Object data, String token) async {
    final url = API.updateCart(cartCode);
    try {
      final response = await apiBaseHelper!.put(url, data, token);
      return response;
    } catch (error) {}
  }

  Future<CartModel?> getCart(String cartCode) async {
    final url = API.getCart(cartCode);
    CartModel? cartResponse;
    try {
      final response = await apiBaseHelper!.get(url: url);
      cartResponse = CartModel.fromJson(response);
    } catch (error) {}
    return cartResponse;
  }

  Future<dynamic> removeItem(int? productId) async {
    final url = API.removeCartItem(
        sharedPreferences!.getString(AppConstants.CART_CODE), productId, true);
    try {
      log("cartRepo: removeItem");
      final response = await apiBaseHelper!.delete(url: url);
      print('test');

      if (response != null) {
        CartModel cartResponse = CartModel.fromJson(response);
        return cartResponse;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<CartModel?> getAuthCart(String? cartCode, String token) async {
    final url = API.getCartAuth(cartCode);
    print("get auth cart url:" + url);
    CartModel? cartResponse;
    try {
      final response = await apiBaseHelper!.get(url: url, token: token);
      cartResponse = CartModel.fromJson(response);

      print("get cart auth response" + response.toString());
    } catch (error) {
      print("get aurth cart in catch block");
      print("error is " + error.toString());
      if (cartCode!.isNotEmpty && error == 404) {
        authRepo!.clearCart();
        cartResponse = null;
        // try {
        //   final url = API.getCartAuth("");
        //   final response = await apiBaseHelper.get(url: url, token: token);
        //   cartResponse = CartModel.fromJson(response);
        // } catch (e) {}
      }
    }

    return cartResponse;
  }

  void setShopianaCartCode(String cartCode) {
    print("cartCode");
    print(cartCode);
    sharedPreferences!.setString(AppConstants.CART_CODE, cartCode);
  }

  String getCartCode() {
    return sharedPreferences!.getString(AppConstants.CART_CODE) ?? "";
  }

  void removeCartCode() {
    sharedPreferences!.remove(AppConstants.CART_CODE);
  }

  Future<dynamic> applyCoupon(
      String cartCode, String couponCode, Object data) async {
    final url = API.applyCoupon(cartCode, couponCode);
    try {
      final response = await apiBaseHelper!.post(url, data, '');
      return response;
    } catch (error) {
      return error;
    }
  }

  Future<dynamic> removeCoupon(
    String cartCode,
  ) async {
    final url = API.removeCoupon(cartCode);
    try {
      final response = await apiBaseHelper!.put(url, {}, '');
      return response;
    } catch (error) {
      return error;
    }
  }

  Future<dynamic> updateProductQuantity(
      {required String cartCode, required Object data}) async {
    final url = API.updatePoductQuantity(cartCode);
    try {
      final response = await apiBaseHelper!.put(url, data, '');
      return response;
    } catch (error) {
      return error;
    }
  }

  Future<bool?> checkCartCodeValid(String cartCode) async {
    final url = API.checkCartCodeValid(cartCode);
    try {
      var response = await apiBaseHelper!.get(url: url);
      if (response != null) {
        response = response['exists'] as dynamic;
      }
      return response;
    } catch (error) {
      return false;
    }
  }
}

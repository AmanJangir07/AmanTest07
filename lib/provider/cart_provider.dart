import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/cart_model.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/data/repository/auth_repo.dart';
import 'package:shopiana/data/repository/cart_repo.dart';

class CartProvider extends ChangeNotifier {
  final CartRepo? cartRepo;
  final AuthRepo? authRepo;

  CartProvider({required this.cartRepo, required this.authRepo});

  // List<CartModel> _cartList = [];
  List<bool> _isSelectedList = [];
  double _amount = 0.0;
  bool _isSelectAll = true;
  Map<int?, Product> _cartItems = {};
  CartModel? _cartData;

  Map<int?, Product> get cartItems => _cartItems;
  // List<CartModel> get cartList => _cartList;
  List<bool> get isSelectedList => _isSelectedList;
  CartModel? get cartData => _cartData;
  double get amount => _amount;
  bool get isAllSelect => _isSelectAll;
  // set cartData(data) => _cartData = data;

  Future<void> getCartData() async {
    log("in get cart Data");
    _cartItems.clear();
    _isSelectedList.clear();
    _isSelectAll = false;
    bool isLoggedIn = authRepo!.isLoggedIn();
    log("is logged in" + isLoggedIn.toString());
    String sessionCartCode = cartRepo!.getCartCode();
    if (sessionCartCode.isNotEmpty) {
      // cart available in session
      log("cart available in session");
      CartModel? response = await cartRepo!.getCart(cartRepo!.getCartCode());
      if (response != null) {
        response.products!.forEach((cartProduct) {
          _cartItems.putIfAbsent(cartProduct.id, () => cartProduct);
        });
        _cartData = response;
        // cartRepo.setShopianaCartCode(response.code);
      }
    } else {
      //cart not available in session
      log("cart not available in session");
      if (isLoggedIn) {
        CartModel? response = await cartRepo!
            .getAuthCart(cartRepo!.getCartCode(), authRepo!.getUserToken());

        _cartData = response;
        if (response != null) {
          response.products!.forEach((cartProduct) {
            _cartItems.putIfAbsent(cartProduct.id, () => cartProduct);
          });
          cartRepo!.setShopianaCartCode(response.code!);
        }
      }
    }

    // if (isLoggedIn) {
    //   CartModel response = await cartRepo.getAuthCart(
    //       cartRepo.getCartCode(), authRepo.getUserToken());

    //   _cartData = response;
    //   if (response != null) {
    //     response.products.forEach((cartProduct) {
    //       _cartItems.putIfAbsent(cartProduct.id, () => cartProduct);
    //     });
    //     cartRepo.setShopianaCartCode(response.code);
    //   }
    // } else {
    //   CartModel response = await cartRepo.getCart(cartRepo.getCartCode());
    //   if (response != null) {
    //     response.products.forEach((cartProduct) {
    //       _cartItems.putIfAbsent(cartProduct.id, () => cartProduct);
    //     });
    //     _cartData = response;
    //     cartRepo.setShopianaCartCode(response.code);
    //   }
    // }
    print("cart items");
    print(_cartItems);
    print("cart code: " + cartRepo!.getCartCode().toString());
    notifyListeners();
  }

  void addToCart({
    int? productId,
    int? quantity,
    required Map<String?, OptionValue> selectedOptions,
    Map<String?, int?>? variants,
    String? promocode,
  }) async {
    print("add to cart called");
    final data = {
      "product": productId,
      // "promoCode": promocode,
      "quantity": quantity,
      "attributes": selectedOptions.entries
          .map((entry) => {"id": entry.value.id})
          .toList()
    };
    print("add to cart data; " + data.toString());

    // refresh cart
    bool isLoggedIn = authRepo!.isLoggedIn();
    final String cartCode = cartRepo!.getCartCode();
    CartModel? cartResponse;
    if (cartCode.isNotEmpty) {
      cartResponse = CartModel.fromJson(
          await /* ( */ cartRepo!.updateCart(cartCode, data, '')
          /*  as Future<Map<String, dynamic>?>), */
          );
      _cartData = cartResponse;
      _cartItems.putIfAbsent(
          productId,
          () => cartResponse!.products!
              .firstWhere((prod) => prod.id == productId));

      notifyListeners();
    } else {
      // cart does not exist
      cartResponse = await cartRepo!.addToCart(data);
      print("cart provider: response");
      print(cartResponse);
      _cartData = cartResponse;
      _cartItems.putIfAbsent(
          productId,
          () => cartResponse!.products!
              .firstWhere((prod) => prod.id == productId));

      notifyListeners();
    }
    if (isLoggedIn) {
      cartResponse = await cartRepo!
          .getAuthCart(cartResponse!.code, authRepo!.getUserToken());

      // cartRepo.setShopianaCartCode(cartResponse.code);
      // _cartItems.putIfAbsent(
      //     productId,
      //     () =>
      //         cartResponse.products.firstWhere((prod) => prod.id == productId));

      // notifyListeners();
    } else {
      // cartResponse = await cartRepo.getCart(cartResponse.code);
      // cartRepo.setShopianaCartCode(cartResponse.code);
      // _cartItems.putIfAbsent(
      //     productId,
      //     () =>
      //         cartResponse.products.firstWhere((prod) => prod.id == productId));

      // notifyListeners();
    }

    notifyListeners();
  }

  Future<void> removeFromCart(int? productId) async {
    log("cartProvider: remove from cart");
    final response = await cartRepo!.removeItem(productId);
    log("remove from cart response" + response.toString());
    if (response != null) {
      log('cart delete product response' + response.toString());
      cartItems.remove(productId);
      _cartData = response;
    } else {
      // if (cartItems.length == 0) {
      checkCartCodeValid();
      // cartRepo.removeCartCode();
      // }
    }
    notifyListeners();
  }

  Future<bool?> checkCartCodeValid() async {
    final String cartCode = cartRepo!.getCartCode();
    bool? isCartCodeValid;
    if (cartCode.isNotEmpty) {
      var response = await cartRepo!.checkCartCodeValid(cartCode);
      if (response != null && !response) {
        isCartCodeValid = response;
        _cartData = new CartModel();
        _cartItems.clear();
        print(_cartItems);
        cartRepo!.removeCartCode();
        print('object');
        notifyListeners();
      }
    }
    notifyListeners();
    return isCartCodeValid;
  }

  bool isAddedInCart(int? id) {
    return _cartItems.containsKey(id);
  }

  Future<CartModel?> applyCoupon(String couponCode) async {
    CartModel? applyCouponResponse;

    final String cartCode = cartRepo!.getCartCode();

    if (cartCode.isNotEmpty) {
      try {
        var response = await cartRepo!.applyCoupon(cartCode, couponCode, {});
        if (response != null) {
          applyCouponResponse = CartModel.fromJson(response);
          _cartData = applyCouponResponse;
        }
      } catch (e) {
        return applyCouponResponse = null;
      }
    }
    notifyListeners();
    return applyCouponResponse;
  }

  Future<CartModel?> removeCoupon() async {
    final String cartCode = cartRepo!.getCartCode();
    CartModel? cartModelRes;
    if (cartCode.isNotEmpty) {
      var response = await cartRepo!.removeCoupon(cartCode);
      cartModelRes = CartModel.fromJson(response);
      if (cartModelRes != null) {
        _cartData = cartModelRes;
      }
    }
    notifyListeners();
    return cartModelRes;
  }

  Future<void> updateProductQuantity({int? productId, int? quantity}) async {
    final String cartCode = cartRepo!.getCartCode();
    CartModel cartModel;
    CartQuantity cartQuantity =
        CartQuantity(product: productId, quantity: quantity);
    if (cartCode.isNotEmpty) {
      var response = await cartRepo!
          .updateProductQuantity(cartCode: cartCode, data: cartQuantity);
      cartModel = CartModel.fromJson(response);
      if (cartModel != null) {
        _cartData = cartModel;
      }
    }
    notifyListeners();
  }
}

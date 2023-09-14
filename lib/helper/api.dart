import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/store_constant.dart';

class API {
  static const BASE_URL = 'https://api.shopiana.in';
  static const GET_ALL_CATEGORIES_URL =
      '/api/v1/category?store=${StoreConstant.STORE_CODE}&lang=${Constants.DEFAULT_LANG}&count=100';
  static const GET_CATEGORY_DEFINITION =
      '/api/v1/category/definition?store=${StoreConstant.STORE_CODE}&lang=${Constants.DEFAULT_LANG}&count=100';
  static const GET_ALL_PRODUCTS_URL =
      '/api/v1/products?store=${StoreConstant.STORE_CODE}&lang=${Constants.DEFAULT_LANG}';
  static getAllProductsByCategory(int id) {
    return '/api/v1/products?store=${StoreConstant.STORE_CODE}&lang=${Constants.DEFAULT_LANG}&category=$id';
  }

  static getCategoryById({String? categoryId}) {
    return '/api/v1/category/$categoryId?store=${StoreConstant.STORE_CODE}';
  }

  static createQrTransaction() {
    return '/api/v1/auth/qrscan/transaction?store=${StoreConstant.STORE_CODE}';
  }

  static getWalletTransactionList() {
    return '/api/v1/auth/wallet/transaction?store=${StoreConstant.STORE_CODE}&criteriaOrderByField=${Constants.ID}&orderBy=${Constants.DESCENDING}';
  }

  static getSlider() {
    return '/api/v1/store/slider?store=${StoreConstant.STORE_CODE}';
  }

  static getWalletDetail() {
    return '/api/v1/auth/wallet?store=${StoreConstant.STORE_CODE}';
  }

  static getProductsPageWise(int pageNumber) {
    return '/api/v1/products?store=${StoreConstant.STORE_CODE}&lang=${Constants.DEFAULT_LANG}&count=${Constants.DEFAULT_COUNT}&page=$pageNumber';
  }

  static getProductGroups() {
    return '/api/v1/products/groups?store=${StoreConstant.STORE_CODE}';
  }

  static getGroupProduct({String? groupCode}) {
    return '/api/v1/products/group/$groupCode?store=${StoreConstant.STORE_CODE}';
  }

  static getFilteredProduct({
    String? pageNumber = '',
    String category = '',
    String? count = '',
    String language = '',
    String manufacturer = '',
    String name = '',
    String owner = '',
    String sku = '',
    String status = '',
    String store = '',
  }) {
    return '/api/v1/products?store=${StoreConstant.STORE_CODE}&category=$category&count=$count&lang=$language&manufacturer=$manufacturer&name=$name&owner=$owner&page=$pageNumber&sku=$sku&status=$status';
  }

  static const GET_INITIAL_CONFIG =
      "/api/v1/config/initial?store=${StoreConstant.STORE_CODE}&lang=${Constants.DEFAULT_LANG}";
  static const LOGIN =
      '/api/v1/customer/login?store=${StoreConstant.STORE_CODE}';
  static const SIGNUP =
      '/api/v1/customer/register?store=${StoreConstant.STORE_CODE}';

  static const String VALIDATE_OTP =
      '/api/v1/customer/validate/otp?store=${StoreConstant.STORE_CODE}';

  static const String GENERATE_OTP =
      '/api/v1/customer/generate/otp?store=${StoreConstant.STORE_CODE}';

  static const addToCart = '/api/v1/cart?store=${StoreConstant.STORE_CODE}';
  static String getCart(String cartCode) =>
      '/api/v1/cart/$cartCode?store=${StoreConstant.STORE_CODE}&lang=${Constants.DEFAULT_LANG}';

  static String getCartAuth(String? cartCode) =>
      '/api/v1/auth/customer/cart?cart=$cartCode&store=${StoreConstant.STORE_CODE}&lang=${Constants.DEFAULT_LANG}';

  static String updateCart(String cartCode) =>
      '/api/v1/cart/$cartCode?store=${StoreConstant.STORE_CODE}';

  static const USER_PROFILE =
      '/api/v1/auth/customer/profile?store=${StoreConstant.STORE_CODE}';

  static const UPDATE_PROFILE =
      '/api/v1/auth/customer/?store=${StoreConstant.STORE_CODE}';

  static String getPrice(int? productId) =>
      '/api/v1/product/$productId/price?store=${StoreConstant.STORE_CODE}&lang=${Constants.DEFAULT_LANG}';

  static String removeCartItem(String? cartCode, int? productId, bool body) =>
      '/api/v1/cart/$cartCode/product/$productId?store=${StoreConstant.STORE_CODE}&lang=${Constants.DEFAULT_LANG}&body=$body';

  static String applyCoupon(String cartCode, String couponCode) =>
      '/api/v1/cart/$cartCode/promo/$couponCode?store=${StoreConstant.STORE_CODE}';

  static String getCoupons() =>
      '/api/v1/coupon?store=${StoreConstant.STORE_CODE}';

  static String updatePoductQuantity(String cartCode) =>
      '/api/v1/cart/$cartCode?store=${StoreConstant.STORE_CODE}';

  static String removeCoupon(String cartCode) =>
      '/api/v1/cart/$cartCode/promo?store=${StoreConstant.STORE_CODE}';

  static String updateOrder(int? orderId) =>
      '/api/v1/auth/order/$orderId/status?store=${StoreConstant.STORE_CODE}';

  static String guestOrderCheckout(String cartCode) =>
      '/api/v1/cart/$cartCode/checkout?store=${StoreConstant.STORE_CODE}';

  static String authOrderCheckout(String cartCode) =>
      '/api/v1/auth/cart/$cartCode/checkout?store=${StoreConstant.STORE_CODE}';

  static String getPaymentModules() =>
      '/api/v1/modules/payment?store=${StoreConstant.STORE_CODE}';

  static String initOnlineOrder(String cartId) =>
      '/api/v1/cart/$cartId/payment/init?store=${StoreConstant.STORE_CODE}';

  static String authInitOnlineOrder(String cartId) =>
      '/api/v1/auth/cart/$cartId/payment/init?store=${StoreConstant.STORE_CODE}';

  static String authCheckout(String cartId) =>
      '/api/v1/auth/cart/$cartId/checkout?store=${StoreConstant.STORE_CODE}';

  static String guestCheckout(String cartId) =>
      '/api/v1/cart/$cartId/checkout?store=${StoreConstant.STORE_CODE}';

  static String getOrdersByStatus(String orderStatus) =>
      '/api/v1/auth/orders?store=${StoreConstant.STORE_CODE}&status=$orderStatus';
  static String getOrders({
    String? orderStatus,
    String pageNumber = '',
    String count = '',
  }) =>
      '/api/v1/auth/orders?store=${StoreConstant.STORE_CODE}&page=$pageNumber&status=$orderStatus&count=$count';

  static String getAuthShippingCalculation(String? cartCode) =>
      "/api/v1/auth/cart/$cartCode/shipping?store=${StoreConstant.STORE_CODE}";

  static String getMasterItem(String itemKey) =>
      "/api/v1/auth/master/$itemKey?store=${StoreConstant.STORE_CODE}";

  static String orderTotalCalculation(String? cartCode, int? quote) =>
      "/api/v1/auth/cart/$cartCode/total?quote=$quote&store=${StoreConstant.STORE_CODE}";

  static String getShippingCalculation(String? cartCode) =>
      "/api/v1/auth/cart/$cartCode/shipping?store=${StoreConstant.STORE_CODE}";

  static String createShippingCalculation(String cartCode) =>
      "/api/v1/cart/$cartCode/shipping?store=${StoreConstant.STORE_CODE}";

  static String getRelatedProducts(int? prouctId) =>
      '/api/v1/products/$prouctId/related?store=${StoreConstant.STORE_CODE}';

  static String getBrandList() =>
      '/api/v1/manufacturers?page=0&count=1000&store=${StoreConstant.STORE_CODE}';

  static String getSearchAutoComplete() =>
      '/api/v1/search/autocomplete?store=${StoreConstant.STORE_CODE}';

  static String getSearchProducts() =>
      '/api/v1/search?store=${StoreConstant.STORE_CODE}';

  static String validateIsUserExist(String? username) =>
      '/api/v1/customer/username/$username/exist?store=${StoreConstant.STORE_CODE}';

  static String generateResetOtp() =>
      '/api/v1/customer/generate/resetotp/?store=${StoreConstant.STORE_CODE}';

  static String validateResetOtp() =>
      '/api/v1/customer/validate/otp?store=${StoreConstant.STORE_CODE}';

  static String resetUserPin() =>
      '/api/v1/customer/password/reset/otp?store=${StoreConstant.STORE_CODE}';

  static String checkCartCodeValid(String cartCode) =>
      '/api/v1/cart/$cartCode/exist?store=${StoreConstant.STORE_CODE}';

  static const MOBILE_INITIAL_CONFIG =
      '/api/v1/config/mobile/initial?store=${StoreConstant.STORE_CODE}';

  static String authCheckoutDefination(String cartCode) =>
      '/api/v1/auth/cart/$cartCode/checkout/definition?store=${StoreConstant.STORE_CODE}';

  static String guestCheckoutDefination(String cartCode) =>
      '/api/v1/cart/$cartCode/checkout/definition?store=${StoreConstant.STORE_CODE}';

  static String checkoutOrderPayent(String? orderId) =>
      '/api/v1/cart/checkout/order/$orderId/payment?store=${StoreConstant.STORE_CODE}';

  // MASTER URLS -> Starts
  static const MASTER_COUNTRY =
      '/api/v1/country?store=${StoreConstant.STORE_CODE}';

  static String masterStates(String? countryCode) =>
      '/api/v1/zones?code=$countryCode&store=${StoreConstant.STORE_CODE}';
  // MASTER URLS -> Ends

}

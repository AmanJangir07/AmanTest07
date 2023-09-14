// class ConfigModel {
//   String _currencyName;
//   String _currencySymbol;
//   String _primaryColor;
//   String _secondaryColor;
//   String _ternaryColor;
//   bool _allowGuestUser;
//   String _storeLogo;
//   String _allowOnlinePurchase;
//   bool _displaySearchBox;
//   bool _displayContactUs;
//   bool _displayStoreAddress;
//   bool _displayShipping;
//   bool _displayCustomerAgreement;
//   bool _displayDiscountCoupon;
//   bool _displayCustomerReview;
//   bool _displayWishList;

//   // List<CurrencyList> _currencyList;

//   ConfigModel(
//       {String currencyName,
//       String currencySymbol,
//       String primaryColor,
//       String secondaryColor,
//       String ternaryColor,
//       bool allowGuestUser,
//       bool displaySearchBox,
//       bool displayContactUs,
//       bool displayStoreAddress,
//       bool displayShipping,
//       bool displayCustomerAgreement,
//       bool displayDiscountCoupon,
//       bool displayCustomerReview,
//       bool displayWishList}) {
//     this._currencyName = currencyName;
//     this._currencySymbol = currencySymbol;
//     this._primaryColor = primaryColor;
//     this._secondaryColor = secondaryColor;
//     this._ternaryColor = ternaryColor;
//     this._allowGuestUser = allowGuestUser;
//     this._displaySearchBox = displaySearchBox;
//     this._displayContactUs = displayContactUs;
//     this._displayStoreAddress = displayStoreAddress;
//     this._displayShipping = displayShipping;
//     this._displayCustomerAgreement = displayCustomerAgreement;
//     this._displayDiscountCoupon = displayDiscountCoupon;
//     this._displayCustomerReview = displayCustomerReview;
//     this._displayWishList = displayWishList;
//   }

//   // ignore: unnecessary_getters_setters
//   set currencyName(String value) {
//     _currencyName = value;
//   }

//   set currencySymbol(String value) {
//     _currencySymbol = value;
//   }

//   set allowGuestUser(bool value) {
//     _allowGuestUser = value;
//   }

//   set primaryColor(String value) {
//     _primaryColor = value;
//   }

//   set secondaryColor(String value) {
//     _secondaryColor = value;
//   }

//   set ternaryColor(String value) {
//     _ternaryColor = value;
//   }

//   // ignore: unnecessary_getters_setters
//   String get currencyName => _currencyName;
//   String get currencySymbol => _currencySymbol;
//   String get primaryColor => _primaryColor;
//   String get secondaryColor => _secondaryColor;
//   String get ternaryColor => _ternaryColor;
//   bool get allowGuestUser => _allowGuestUser;
//   bool get displaySearchBox => _displaySearchBox;

//   // // ignore: unnecessary_getters_setters
//   // List<CurrencyList> get currencyList => _currencyList;

//   // // ignore: unnecessary_getters_setters
//   // set currencyList(List<CurrencyList> value) {
//   //   _currencyList = value;
//   // }

//   // ConfigModel.fromJson(Map<String, dynamic> json) {
//   //   if (json['currency_list'] != null) {
//   //     _currencyList = [];
//   //     json['currency_list'].forEach((v) {
//   //       _currencyList.add(new CurrencyList.fromJson(v));
//   //     });
//   //   }
//   // }

//   // ConfigModel.fromJson(Map<String, dynamic> json) {

//   // }

//   factory ConfigModel.fromJson(Map<String, dynamic> json) {
//     return json == null
//         ? ConfigModel()
//         : ConfigModel(
//             currencyName: json['currencyName'],
//             currencySymbol: json['currencySymbol'],
//             allowGuestUser: json['allowGuestUser'],
//             primaryColor: json['themeColor']['firstColor'],
//             secondaryColor: json['themeColor']['secondColor'],
//             ternaryColor: json['themeColor']['thirdColor'],
//             displaySearchBox: json['displaySearchBox']);
//   }

//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = new Map<String, dynamic>();
//   //   if (this._currencyList != null) {
//   //     data['currency_list'] =
//   //         this._currencyList.map((v) => v.toJson()).toList();
//   //   }
//   //   return data;
//   // }
// }

// // class CurrencyList {
// //   int _id;
// //   String _name;
// //   String _symbol;
// //   String _code;
// //   String _exchangeRate;
// //   String _status;
// //   String _createdAt;
// //   String _updatedAt;

// //   CurrencyList(
// //       {int id,
// //       String name,
// //       String symbol,
// //       String code,
// //       String exchangeRate,
// //       String status,
// //       String createdAt,
// //       String updatedAt}) {
// //     this._id = id;
// //     this._name = name;
// //     this._symbol = symbol;
// //     this._code = code;
// //     this._exchangeRate = exchangeRate;
// //     this._status = status;
// //     this._createdAt = createdAt;
// //     this._updatedAt = updatedAt;
// //   }

// //   int get id => _id;
// //   String get name => _name;
// //   String get symbol => _symbol;
// //   String get code => _code;
// //   String get exchangeRate => _exchangeRate;
// //   String get status => _status;
// //   String get createdAt => _createdAt;
// //   String get updatedAt => _updatedAt;

// //   CurrencyList.fromJson(Map<String, dynamic> json) {
// //     _id = json['id'];
// //     _name = json['name'];
// //     _symbol = json['symbol'];
// //     _code = json['code'];
// //     _exchangeRate = json['exchange_rate'];
// //     _status = json['status'];
// //     _createdAt = json['created_at'];
// //     _updatedAt = json['updated_at'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['id'] = this._id;
// //     data['name'] = this._name;
// //     data['symbol'] = this._symbol;
// //     data['code'] = this._code;
// //     data['exchange_rate'] = this._exchangeRate;
// //     data['status'] = this._status;
// //     data['created_at'] = this._createdAt;
// //     data['updated_at'] = this._updatedAt;
// //     return data;
// //   }
// // }
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

class ConfigModel {
  ConfigModel(
      {this.facebook,
      this.pinterest,
      this.ga,
      this.instagram,
      this.favicon,
      this.storeCode,
      this.storeName,
      this.storeAddress,
      this.storeMailAddress,
      this.storeContactNumber,
      this.storeLogo,
      this.domainName,
      this.currency,
      this.allowGuestUser,
      this.allowOnlinePurchase,
      this.displaySearchBox,
      this.displayContactUs,
      this.displayStoreAddress,
      this.displayShipping,
      this.displayCustomerSection,
      this.displayAddToCartOnFeaturedItems,
      this.displayCustomerAgreement,
      this.displayPagesMenu,
      this.displayDiscountCoupon,
      this.displayCustomerReview,
      this.displayWishList,
      this.testMode,
      this.debugMode,
      this.allowPurchaseItems,
      this.displaySlider,
      this.displayCategorySection,
      this.displayManufacturerSection,
      this.displayProductGroupSection,
      this.displayFeaturedProductSection,
      this.displayProductPrice,
      this.displayShippingOptions,
      this.displayProductSection,
      this.displayOrderSection,
      this.themeColorFirst,
      this.themeColorSecond,
      this.themeColorThird,
      this.displayProductSectionAtHome,
      this.displayQrscanSection});

  dynamic facebook;
  dynamic pinterest;
  dynamic ga;
  dynamic instagram;
  dynamic favicon;
  String? storeCode;
  String? storeName;
  String? storeAddress;
  String? storeMailAddress;
  String? storeContactNumber;
  dynamic storeLogo;
  String? domainName;
  String? currency;
  String? themeColorFirst;
  String? themeColorSecond;
  String? themeColorThird;
  bool? allowGuestUser;
  bool? allowOnlinePurchase;
  bool? displaySearchBox;
  bool? displayProductSection;
  bool? displayContactUs;
  bool? displayStoreAddress;
  bool? displayShipping;
  bool? displayCustomerSection;
  bool? displayAddToCartOnFeaturedItems;
  bool? displayCustomerAgreement;
  bool? displayPagesMenu;
  bool? displayDiscountCoupon;
  bool? displayCustomerReview;
  bool? displayWishList;
  bool? testMode;
  bool? debugMode;
  bool? allowPurchaseItems;
  bool? displaySlider;
  bool? displayCategorySection;
  bool? displayManufacturerSection;
  bool? displayProductGroupSection;
  bool? displayFeaturedProductSection;
  bool? displayProductPrice;
  bool? displayShippingOptions;
  bool? displayQrscanSection;
  bool? displayOrderSection;
  bool? displayProductSectionAtHome;

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
      facebook: json["facebook"],
      pinterest: json["pinterest"],
      ga: json["ga"],
      instagram: json["instagram"],
      favicon: json["favicon"],
      storeCode: json["storeCode"],
      storeName: json["storeName"],
      storeAddress: json["storeAddress"],
      storeMailAddress: json["storeMailAddress"],
      storeContactNumber: json["storeContactNumber"],
      storeLogo: json["storeLogo"],
      domainName: json["domainName"],
      currency: json["currency"],
      themeColorFirst: json["themeColorFirst"],
      themeColorSecond: json["themeColorSecond"],
      themeColorThird: json["themeColorThird"],
      allowGuestUser: json["allowGuestUser"],
      allowOnlinePurchase: json["allowOnlinePurchase"],
      displaySearchBox: json["displaySearchBox"],
      displayContactUs: json["displayContactUs"],
      displayStoreAddress: json["displayStoreAddress"],
      displayShipping: json["displayShipping"],
      displayCustomerSection: json["displayCustomerSection"],
      displayAddToCartOnFeaturedItems: json["displayAddToCartOnFeaturedItems"],
      displayProductSection: json['displayProductSection'],
      displayCustomerAgreement: json["displayCustomerAgreement"],
      displayPagesMenu: json["displayPagesMenu"],
      displayDiscountCoupon: json["displayDiscountCoupon"],
      displayCustomerReview: json["displayCustomerReview"],
      displayWishList: json["displayWishList"],
      testMode: json["testMode"],
      debugMode: json["debugMode"],
      allowPurchaseItems: json["allowPurchaseItems"],
      displaySlider: json["displaySlider"],
      displayCategorySection: json["displayCategorySection"],
      displayManufacturerSection: json["displayManufacturerSection"],
      displayProductGroupSection: json["displayProductGroupSection"],
      displayFeaturedProductSection: json["displayFeaturedProductSection"],
      displayProductPrice: json["displayProductPrice"],
      displayShippingOptions: json["displayShippingOptions"],
      displayOrderSection: json["displayOrderSection"],
      displayProductSectionAtHome: json["displayProductSectionAtHome"],
      displayQrscanSection: json["displayQrscanSection"]);

  Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "pinterest": pinterest,
        "ga": ga,
        "instagram": instagram,
        "favicon": favicon,
        "storeCode": storeCode,
        "storeName": storeName,
        "storeAddress": storeAddress,
        "storeMailAddress": storeMailAddress,
        "storeContactNumber": storeContactNumber,
        "storeLogo": storeLogo,
        "domainName": domainName,
        "currency": currency,
        "themeColorFirst": themeColorFirst,
        "themeColorSecond": themeColorSecond,
        "themeColorThird": themeColorThird,
        "allowGuestUser": allowGuestUser,
        "allowOnlinePurchase": allowOnlinePurchase,
        "displaySearchBox": displaySearchBox,
        "displayContactUs": displayContactUs,
        "displayStoreAddress": displayStoreAddress,
        "displayShipping": displayShipping,
        "displayCustomerSection": displayCustomerSection,
        "displayAddToCartOnFeaturedItems": displayAddToCartOnFeaturedItems,
        "displayCustomerAgreement": displayCustomerAgreement,
        "displayPagesMenu": displayPagesMenu,
        "displayDiscountCoupon": displayDiscountCoupon,
        "displayCustomerReview": displayCustomerReview,
        "displayWishList": displayWishList,
        "testMode": testMode,
        "debugMode": debugMode,
        "allowPurchaseItems": allowPurchaseItems,
        "displaySlider": displaySlider,
        "displayCategorySection": displayCategorySection,
        "displayManufacturerSection": displayManufacturerSection,
        "displayProductGroupSection": displayProductGroupSection,
        "displayFeaturedProductSection": displayFeaturedProductSection,
        "displayProductPrice": displayProductPrice,
        "displayShippingOptions": displayShippingOptions,
        "displayProductSection": displayProductSection,
        "displayQrscanSection": displayQrscanSection,
        "displayOrderSection": displayOrderSection,
        "displayProductSectionAtHome": displayProductSectionAtHome
      };
}

class ThemeColor {
  ThemeColor({
    this.firstColor,
    this.secondColor,
    this.thirdColor,
  });

  String? firstColor;
  String? secondColor;
  String? thirdColor;

  factory ThemeColor.fromJson(Map<String, dynamic> json) => json == null
      ? ThemeColor()
      : ThemeColor(
          firstColor: json["firstColor"],
          secondColor: json["secondColor"],
          thirdColor: json["thirdColor"],
        );

  Map<String, dynamic> toJson() => {
        "firstColor": firstColor,
        "secondColor": secondColor,
        "thirdColor": thirdColor,
      };
}

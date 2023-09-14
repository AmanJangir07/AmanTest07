import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/data/repository/product_repo.dart';
import 'package:shopiana/helper/api.dart';
import 'package:shopiana/helper/app_exception.dart';
import 'package:shopiana/utill/snackbar.dart';

enum LoadMoreStatus { LOADING, STABLE }

class ProductProvider extends ChangeNotifier {
  final ProductRepo? productRepo;
  ProductProvider({required this.productRepo});
  int? totalPages = 0;
  int? totalProducts = 0;
  int? brandCategoryTotalPages = 0;
  int? brandCategoryTotalProducts = 0;
  List<Product> _productList = [];
  List<Product> _brandOrCategoryProductList = [];
  bool? _hasData;
  bool _firstLoadingProducts = true;
  bool _firstLoadingBrandCategory = true;
  Map<String?, ProductGroupValue>? groupProducts;

  Map<String?, ProductGroupValue>? get getGroupProducts => this.groupProducts;
  set setGroupProducts(Map<String, ProductGroupValue> groupProducts) =>
      this.groupProducts = groupProducts;
  List<Product> get productList => _productList;
  bool get firstLoadingProduct => _firstLoadingProducts;
  bool get firstLoadingBrandCategory => _firstLoadingBrandCategory;

  void initLatestProductList({BuildContext? context}) async {
    _productList = [];

    try {
      _productList.addAll(await productRepo!.getLatestProductList());
      _firstLoadingProducts = false;
    } on AppException catch (e) {
      showErrorSnackbar(context!, e.message!);
    }
    notifyListeners();
  }

  void removeFirstLoading() {
    _firstLoadingProducts = true;
    notifyListeners();
  }

  // Seller products
  List<Product> _sellerAllProductList = [];
  List<Product> _sellerProductList = [];
  List<Product> get sellerProductList => _sellerProductList;

  void initSellerProductList() async {
    _firstLoadingProducts = false;
    // _sellerProductList.addAll(await productRepo.getSellerProductList());
    // _sellerAllProductList.addAll(productRepo.getSellerProductList());
    notifyListeners();
  }

  void filterData(String newText) {
    _sellerProductList.clear();
    if (newText.isNotEmpty) {
      _sellerAllProductList.forEach((product) {
        if (product.description!.name!
            .toLowerCase()
            .contains(newText.toLowerCase())) {
          _sellerProductList.add(product);
        }
      });
    } else {
      _sellerProductList.clear();
      _sellerProductList.addAll(_sellerAllProductList);
    }
    notifyListeners();
  }

  void clearSellerData() {
    _sellerProductList = [];
    notifyListeners();
  }

  List<Product> get brandOrCategoryProductList => _brandOrCategoryProductList;
  bool? get hasData => _hasData;

  Future<void> initBrandOrCategoryProductList(
      {bool? isBrand,
      String? id,
      required int pageNumber,
      int? count,
      required BuildContext context}) async {
    print("id" + id.toString());
    if (pageNumber == 0) {
      _brandOrCategoryProductList.clear();
    }

    if (pageNumber == 0) {
      _brandOrCategoryProductList.clear();
    }
    if ((totalPages == 0) || pageNumber <= totalPages!) {
      dynamic extractedData;
      String url;
      if (isBrand!) {
        url = API.getFilteredProduct(
          pageNumber: pageNumber.toString(),
          count: count.toString(),
          manufacturer: int.parse(id!).toString(),
        );
        try {
          extractedData =
              await productRepo!.getBrandOrCategoryProductList(url: url);
        } on AppException catch (e) {
          showErrorSnackbar(context, e.message!);
        }
      } else {
        url = API.getFilteredProduct(
          pageNumber: pageNumber.toString(),
          count: count.toString(),
          category: int.parse(id!).toString(),
        );
        try {
          extractedData =
              await productRepo!.getBrandOrCategoryProductList(url: url);
        } on AppException catch (e) {
          showErrorSnackbar(context, e.message!);
        }
      }

      // getProductsPageWise(
      //     pageNumber: pageNumber.toString(), count: count.toString());
      final brandCatProductData = extractedData['products'] as dynamic;
      if (_brandOrCategoryProductList == null ||
          _brandOrCategoryProductList.length == 0) {
        brandCategoryTotalPages = extractedData["totalPages"];
        brandCategoryTotalProducts = extractedData["recordsTotal"];
        brandCatProductData.forEach((product) {
          Product currentProduct = Product.fromJson(product);
          _brandOrCategoryProductList.add(currentProduct);
        });
        _firstLoadingBrandCategory = false;
      } else {
        brandCatProductData.forEach((product) {
          Product currentProduct = Product.fromJson(product);
          _brandOrCategoryProductList.add(currentProduct);
        });
      }
    }
    if (pageNumber > brandCategoryTotalPages!) {
      setLoadingState(LoadMoreStatus.STABLE);
    }

    // _latestProductList.addAll();
    // _firstLoadingProducts = false;
    print(_brandOrCategoryProductList);
    notifyListeners();
  }

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;
  getLoadMoreStatus() => _loadMoreStatus;

  void getProducts(
      {required BuildContext context,
      required int pageNumber,
      int? category,
      int? count,
      String? language,
      int? manufacturer,
      String? name,
      int? owner,
      String? sku,
      String? status,
      String? store}) async {
    if (pageNumber == 0) {
      productList.clear();
    }
    if ((totalPages == 0) || pageNumber <= totalPages!) {
      dynamic extractedData;
      try {
        extractedData = await productRepo!.getProductsPageWise(
            pageNumber: pageNumber.toString(), count: count.toString());
      } on AppException catch (e) {
        showErrorSnackbar(context, e.message!);
      }
      // log(extractedData.toString());
      final productData = extractedData['products'] as dynamic;
      if (_productList == null || _productList.length == 0) {
        totalPages = extractedData["totalPages"];
        totalProducts = extractedData["recordsTotal"];
        productData.forEach((product) {
          Product currentProduct = Product.fromJson(product);
          _productList.add(currentProduct);
        });
        _firstLoadingProducts = false;
      } else {
        productData.forEach((product) {
          Product currentProduct = Product.fromJson(product);
          _productList.add(currentProduct);
        });
      }
    }
    if (pageNumber > totalPages!) {
      setLoadingState(LoadMoreStatus.STABLE);
    }

    // _latestProductList.addAll();
    // _firstLoadingProducts = false;

    notifyListeners();
  }

  Future<ProductVariantPrice> getPriceByVariants(
      {int? productId,
      required Map<String?, int?> variantMap,
      required BuildContext context}) async {
    final data = {"options": []};
    variantMap.forEach((key, value) {
      data['options']!.add({"id": value});
    });
    dynamic extractedData;
    try {
      extractedData = await productRepo!.getPriceByVariants(productId, data);
    } on AppException catch (e) {
      showErrorSnackbar(context, e.message!);
    }
    extractedData = ProductVariantPrice.fromJson(extractedData);
    notifyListeners();
    return extractedData;
  }

  // Related products
  List<Product>? _relatedProductList = [];
  List<Product>? get relatedProductList => _relatedProductList;

  void initRelatedProductList(int? productId) async {
    _firstLoadingProducts = false;
    // var _relatedProductList = [];
    _relatedProductList = await productRepo!.getRelatedProductList(productId);

    notifyListeners();
  }

  void removePrevRelatedProduct() {
    _relatedProductList = null;
    notifyListeners();
  }

  Future<void> getProductGroups() async {
    groupProducts = await productRepo!.getProductsGroups();
  }
}

import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/data/repository/search_repo.dart';

class SearchProvider with ChangeNotifier {
  final SearchRepo? searchRepo;
  SearchProvider({required this.searchRepo});

  int _filterIndex = 0;
  List<String> _historyList = [];

  int get filterIndex => _filterIndex;
  List<String> get historyList => _historyList;

  void setFilterIndex(int index) {
    _filterIndex = index;
    notifyListeners();
  }

  void sortSearchList(double startingPrice, double endingPrice) {
    if (_filterIndex == 0) {
      _searchProductList!.clear();
      _searchProductList!.addAll(_filterProductList!);
    } else if (_filterIndex == 1) {
      _searchProductList!.clear();
      if (startingPrice > 0 && endingPrice > startingPrice) {
        _searchProductList!.addAll(_filterProductList!
            .where((product) =>
                (double.parse(product.price)) > startingPrice &&
                (double.parse(product.price)) < endingPrice)
            .toList());
      } else {
        _searchProductList!.addAll(_filterProductList!);
      }
      _searchProductList!
          .sort((a, b) => a.description!.name!.compareTo(b.description!.name!));
    } else if (_filterIndex == 2) {
      _searchProductList!.clear();
      if (startingPrice > 0 && endingPrice > startingPrice) {
        _searchProductList!.addAll(_filterProductList!
            .where((product) =>
                (double.parse(product.price)) > startingPrice &&
                (double.parse(product.price)) < endingPrice)
            .toList());
      } else {
        _searchProductList!.addAll(_filterProductList!);
      }
      _searchProductList!
          .sort((a, b) => a.description!.name!.compareTo(b.description!.name!));
      Iterable iterable = _searchProductList!.reversed;
      _searchProductList = iterable.toList() as List<Product>?;
    } else if (_filterIndex == 3) {
      _searchProductList!.clear();
      if (startingPrice > 0 && endingPrice > startingPrice) {
        _searchProductList!.addAll(_filterProductList!
            .where((product) =>
                (double.parse(product.price)) > startingPrice &&
                (double.parse(product.price)) < endingPrice)
            .toList());
      } else {
        _searchProductList!.addAll(_filterProductList!);
      }
      _searchProductList!.sort(
          (a, b) => double.parse(a.price).compareTo(double.parse(b.price)));
    } else if (_filterIndex == 4) {
      _searchProductList!.clear();
      if (startingPrice > 0 && endingPrice > startingPrice) {
        _searchProductList!.addAll(_filterProductList!
            .where((product) =>
                (double.parse(product.price)) > startingPrice &&
                (double.parse(product.price)) < endingPrice)
            .toList());
      } else {
        _searchProductList!.addAll(_filterProductList!);
      }
      _searchProductList!.sort((a, b) => a.price.compareTo(b.price));
      Iterable iterable = _searchProductList!.reversed;
      _searchProductList = iterable.toList() as List<Product>?;
    }

    notifyListeners();
  }

  List<Product>? _searchProductList;
  List<Product>? _filterProductList;
  bool _isClear = true;
  String _searchText = '';
  bool isSearching = false;
  get getIsSearching => this.isSearching;

  set setIsSearching(isSearching) => this.isSearching = isSearching;

  List<Product>? get searchProductList => _searchProductList;
  List<Product>? get filterProductList => _filterProductList;
  bool get isClear => _isClear;
  String get searchText => _searchText;

  void setSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  void cleanSearchProduct() {
    _searchProductList = [];
    _isClear = true;
    _searchText = '';
    notifyListeners();
  }

  void searchProduct(String query) async {
    _searchText = query;
    _isClear = false;
    _searchProductList = null;
    _filterProductList = null;
    isSearching = true;
    notifyListeners();
    if (query.isEmpty) {
      _searchProductList = [];
    } else {
      var data = {"count": 10, "query": query, "start": 0};
      _searchProductList = [];
      _searchProductList = await searchRepo!.getSearchProductList(data);
    }
    isSearching = false;
    notifyListeners();
  }

  // for save home address
  void initHistoryList() {
    _historyList = searchRepo!.getSearchAddress();
    notifyListeners();
  }

  void saveSearchAddress(String searchAddress) async {
    searchRepo!.saveSearchAddress(searchAddress);
    if (!_historyList.contains(searchAddress)) {
      _historyList.add(searchAddress);
    }
    notifyListeners();
  }

  void clearSearchAddress() async {
    searchRepo!.clearSearchAddress();
    _historyList.clear();
    notifyListeners();
  }

  List<String> _autoCompleteResult = [];
  List<String> get autoCompleteResult => _autoCompleteResult;

  void getautoCompleteData(String searchKeyWord) async {
    if (searchKeyWord.isNotEmpty) {
      var data = {
        "count": 0,
        "query": searchKeyWord,
        "start": 0,
      };
      var response = await searchRepo!.getAutoCompleteSearch(data);
      if (response != null) {
        _autoCompleteResult = response;
      }
    }
  }
}

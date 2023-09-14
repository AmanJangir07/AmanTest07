import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/category.dart';
import 'package:shopiana/data/repository/category_repo.dart';
import 'package:shopiana/helper/app_exception.dart';
import 'package:shopiana/utill/snackbar.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepo? categoryRepo;

  CategoryProvider({required this.categoryRepo});

  List<Category> _categoryList = [];
  int? _categorySelectedIndex;
  List<CategoryDefinition> _categoryDefinitionList = [];
  List<CategoryDefinition> get categoryDefinitionList =>
      this._categoryDefinitionList;

  List<Category> get categoryList => _categoryList;

  int? get categorySelectedIndex => _categorySelectedIndex;

  void initCategoryList({required BuildContext context}) async {
    _categoryList.clear();
    dynamic extractedData;
    try {
      extractedData = await categoryRepo!.getCategoryList();
    } on AppException catch (e) {
      showErrorSnackbar(context, e.message!);
    }
    // log("ca data" + extractedData.toString());
    final catData = extractedData['categories'] as dynamic;

    catData.forEach((category) {
      Category currentCategory = Category.fromJson(category);
      _categoryList.add(currentCategory);
    });

    _categorySelectedIndex = 0;
    notifyListeners();
  }

  void changeSelectedIndex(int selectedIndex) {
    _categorySelectedIndex = selectedIndex;
    notifyListeners();
  }

  Future<void> getCategoryDefinition({required BuildContext context}) async {
    var extractedData;
    _categoryDefinitionList.clear();
    try {
      final response = await categoryRepo!.getCategoryDefinitionList();
      _categoryDefinitionList.clear();
      extractedData = response as dynamic;
    } on AppException catch (e) {
      showErrorSnackbar(context, e.message!);
    }
    if (extractedData != null)
      extractedData.forEach((categoryDefintion) {
        categoryDefinitionList
            .add(CategoryDefinition.fromJson(categoryDefintion));
        return categoryDefinitionList;
      });
  }
}

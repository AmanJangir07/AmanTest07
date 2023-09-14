import 'package:shopiana/data/model/response/product_model.dart';
import 'package:shopiana/helper/api.dart';
import 'package:shopiana/helper/api_base_helper.dart';
import 'package:shopiana/utill/constants.dart';

class ProductRepo {
  ApiBaseHelper _helper = ApiBaseHelper();
  Future<List<Product>> getLatestProductList() async {
    String url = API.GET_ALL_PRODUCTS_URL;
    List<Product> allProducts = [];
    final response = await _helper.get(url: url);
    final extractedData = response['products'] as dynamic;
    if (extractedData != null) {
      extractedData.forEach((product) {
        Product currentProduct = Product.fromJson(product);
        allProducts.add(currentProduct);
      });
    }
    return allProducts;
  }

  Future<dynamic> getProductsPageWise({String? pageNumber, String? count}) async {
    String url = API.getFilteredProduct(pageNumber: pageNumber, count: count);
    dynamic extractedData;
    final response = await _helper.get(url: url);
    extractedData = response as dynamic;
    return extractedData;
  }

  List<Product> getSellerProductList() {
    List<Product> productList = [];

    return productList;
  }

  Future<dynamic> getBrandOrCategoryProductList({required String url}) async {
    dynamic extractedData;
    final response = await _helper.get(url: url);
    extractedData = response as dynamic;
    return extractedData;
  }

  Future<dynamic> getPriceByVariants(int? productId, Object body) async {
    dynamic extractedData;
    final url = API.getPrice(productId);
    final response = await _helper.post(url, body, '');
    extractedData = response as dynamic;

    return extractedData;
  }

  Future<Map<String?, ProductGroupValue>> getProductsGroups() async {
    dynamic extractedData;
    Map<String?, ProductGroupValue> groupProducts =
        Map<String?, ProductGroupValue>();
    final url = API.getProductGroups();
    final response = await _helper.get(url: url);
    extractedData = response as dynamic;
    if (extractedData != null) {
      List<ProductGroup> groupList = [];
      extractedData.forEach((element) {
        groupList.add(ProductGroup.fromJson(element));
      });

      for (ProductGroup group in groupList) {
        final groupUrl = API.getGroupProduct(groupCode: group.code);
        final groupResonse = await _helper.get(url: groupUrl);
        dynamic groupExtractedData = groupResonse as dynamic;
        if (groupExtractedData != null) {
          /* groupExtractedData.forEach((value) {
              groupProducts.putIfAbsent(
                  group.code, () => ProductGroupValue.fromJson(value));
            }); */
          ProductGroupValue value =
              ProductGroupValue.fromJson(groupExtractedData);
          groupProducts.putIfAbsent(group.code, () => value);
          print(groupProducts);
          print(value.toString());
        }
      }
      /* groupList.forEach((element) async {
          final groupUrl = API.getGroupProduct(groupCode: element.code);
          final groupResonse = await _helper.get(url: groupUrl);
          dynamic groupExtractedData = groupResonse as dynamic;
          if (groupExtractedData != null) {
            groupExtractedData.forEach((value) {
              groupProducts.putIfAbsent(
                  element.code, () => ProductGroupValue.fromJson(value));
            });
          }
        }); */
    }
    return groupProducts;
  }

  Future<List<Product>> getRelatedProductList(int? productId) async {
    // List<Product> productList = [];
    String url = API.getRelatedProducts(productId);
    dynamic extractedData;
    List<Product> relatedProducts = [];
    final response = await _helper.get(url: url);

    extractedData = response as dynamic;
    if (extractedData != null) {
      extractedData.forEach((product) {
        Product currentProduct = Product.fromJson(product);
        relatedProducts.add(currentProduct);
      });
    }
    return relatedProducts;
  }
}

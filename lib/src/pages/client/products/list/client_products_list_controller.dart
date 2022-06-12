import 'package:flutter/cupertino.dart';
import 'package:flutter_app_delivery_2/src/models/category.dart';
import 'package:flutter_app_delivery_2/src/models/product.dart';
import 'package:flutter_app_delivery_2/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:flutter_app_delivery_2/src/providers/categories_provider.dart';
import 'package:flutter_app_delivery_2/src/providers/products_provider.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientProductsLisController extends GetxController {
  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();
  List<Category> categories = <Category>[].obs;

  ClientProductsLisController() {
    getCategories();
  }

  void getCategories() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  Future<List<Product>> getProducts(String categoryId) async {
    return await productsProvider.findByCategory(categoryId);
  }

  void openBottonSheet(BuildContext context, Product product) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => ClientProductsDetailPage(),
    );
  }
}

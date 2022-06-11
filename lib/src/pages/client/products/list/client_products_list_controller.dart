import 'package:flutter_app_delivery_2/src/models/category.dart';
import 'package:flutter_app_delivery_2/src/providers/categories_provider.dart';
import 'package:get/get.dart';

class ClientProductsLisController extends GetxController {
  CategoriesProvider categoriesProvider = CategoriesProvider();
  List<Category> categories = <Category>[].obs;

  ClientProductsLisController() {
    getCategories();
  }

  void getCategories() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }
}

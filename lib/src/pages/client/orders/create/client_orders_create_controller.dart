import 'package:flutter_app_delivery_2/src/models/product.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientOrdersCreateController extends GetxController {
  List<Product> selectedProducts = [];

  var counter = 0.obs;

  ClientOrdersCreateController() {
    if (GetStorage().read('shopping_cart') != null) {
      if (GetStorage().read('shopping_cart') is List<Product>) {
        selectedProducts = GetStorage().read('shopping_cart');
      } else {
        selectedProducts =
            Product.fromJsonList(GetStorage().read('shopping_cart'));
      }
    }
  }
}

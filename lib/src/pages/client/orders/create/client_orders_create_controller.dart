import 'package:flutter_app_delivery_2/src/models/product.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientOrdersCreateController extends GetxController {
  List<Product> selectedProducts = <Product>[].obs;

  var total = 0.0.obs;

  ClientOrdersCreateController() {
    if (GetStorage().read('shopping_cart') != null) {
      if (GetStorage().read('shopping_cart') is List<Product>) {
        var result = GetStorage().read('shopping_cart');
        selectedProducts.clear();
        selectedProducts.addAll(result);
      } else {
        var result = Product.fromJsonList(GetStorage().read('shopping_cart'));
        selectedProducts.clear();
        selectedProducts.addAll(result);
      }
      getTotal();
    }
  }
  void addItem(Product product) {
    int index = selectedProducts.indexWhere((p) => p.id == product.id);
    selectedProducts.remove(product);
    product.quantity = product.quantity! + 1;
    selectedProducts.insert(index, product);
    GetStorage().write('shopping_cart', selectedProducts);
    getTotal();
  }

  void deleteItem(Product product) {
    selectedProducts.remove(product);
    GetStorage().write('shopping_cart', selectedProducts);
    getTotal();
  }

  void removeItem(Product product) {
    if (product.quantity! > 1) {
      int index = selectedProducts.indexWhere((p) => p.id == product.id);
      selectedProducts.remove(product);
      product.quantity = product.quantity! - 1;
      selectedProducts.insert(index, product);
      GetStorage().write('shopping_cart', selectedProducts);
      getTotal();
    }
  }

  void getTotal() {
    total.value = 0.0;
    selectedProducts.forEach((product) {
      total.value = total.value + (product.quantity! * product.price!);
    });
  }

  void goToAdressList() {
    Get.toNamed('/client/address/list');
  }
}

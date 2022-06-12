import 'dart:developer';

import 'package:flutter_app_delivery_2/src/models/product.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClientProductsDetailController extends GetxController {
  List<Product> selectedProducts = [];

  ClientProductsDetailController() {}

  void checkIfProductsWasAdded(Product product, var price, var counter) {
    price.value = product.price ?? 0.0;

    if (GetStorage().read('shopping_cart') != null) {
      if (GetStorage().read('shopping_cart') is List<Product>) {
        selectedProducts = GetStorage().read('shopping_cart');
      } else {
        selectedProducts =
            Product.fromJsonList(GetStorage().read('shopping_cart'));
      }
      int index =
          selectedProducts.indexWhere((element) => element.id == product.id);

      if (index != -1) {
        //EL PRODUCTO YA FUE AGREGADO
        counter.value = selectedProducts[index].quantity ?? 0;
        price.value = product.price! * counter.value;
        selectedProducts.forEach(
          (p) {
            print('Product: ${p.toJson()}');
          },
        );
      }
    }
  }

  void addToCart(Product product, var price, var counter) {
    if (counter.value > 0) {
      int index = selectedProducts.indexWhere(
        (p) => p.id == product.id,
      );
      if (index == -1) {
        if (product.quantity == null) {
          if (counter.value > 0) {
            product.quantity = counter.value;
          } else {
            product.quantity = 1;
          }
        }
        selectedProducts.add(product);
      } else {
        // YA HA SIDO AGREGADO EN STORAGE
        selectedProducts[index].quantity = counter.value;
      }
      GetStorage().write('shopping_cart', selectedProducts);
      Fluttertoast.showToast(
          msg: "Producto Agregado",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Debes Selecciona al menos 1 producto",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
    //VALIDAR SI EL PRODUCTO YA FUE AGREGADO CON GETSTRAGE A LA SESSION DEL DISPOSITIVO
  }

  void addItem(Product product, var price, var counter) {
    counter.value++;
    print('PRODUCTO AGREGADO: ${product.toJson()}');
    price.value = product.price! * counter.value;
  }

  void removeItem(Product product, var price, var counter) {
    if (counter.value > 0) {
      counter.value--;
      price.value = product.price! * counter.value;
    }
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_app_delivery_2/src/models/category.dart';
import 'package:flutter_app_delivery_2/src/models/response_api.dart';
import 'package:flutter_app_delivery_2/src/providers/categories_provider.dart';
import 'package:get/get.dart';

class RestaurantCategoriesCreateController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CategoriesProvider categoriesProvider = CategoriesProvider();

  void createCategory() async {
    String name = nameController.text;
    String description = descriptionController.text;

    print('Name: ${name}');
    print('Description: ${description}');
    if (name.isNotEmpty && description.isNotEmpty) {
      Category category = Category(
        name: name,
        description: description,
      );
      ResponseApi responseApi = await categoriesProvider.create(category);
      Get.snackbar('Proceso terminado', responseApi.message ?? '');

      if (responseApi.success == true) {
        clearForm();
      }
    } else {
      Get.snackbar('Formulario no valido',
          'Ingresa todos los campos para crear la categoria');
    }
  }

  void clearForm() {
    nameController.text = '';
    descriptionController.text = '';
  }
}

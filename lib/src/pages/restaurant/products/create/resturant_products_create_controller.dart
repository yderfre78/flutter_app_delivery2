import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_delivery_2/src/models/product.dart';
import 'package:flutter_app_delivery_2/src/models/response_api.dart';
import 'package:flutter_app_delivery_2/src/providers/products_provider.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RestaurantProductsCreateController extends GetxController {
  
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  ProductsProvider productsProvider = ProductsProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;

  void createProduct() async {
    String name = nameController.text;
    String description = descriptionController.text;

    print('Name: ${name}');
    print('Description: ${description}');
    if (name.isNotEmpty && description.isNotEmpty) {
      Product product = Product(
        name: name,
        description: description,
        price: priceController.text,
      );
      ResponseApi responseApi = await productsProvider.create(product);
      Get.snackbar('Proceso terminado', responseApi.message ?? '');

      if (responseApi.success == true) {
        clearForm();
      }
    } else {
      Get.snackbar('Formulario no valido',
          'Ingresa todos los campos para crear un producto');
    }
  }

  Future selectImage(ImageSource imageSource, int numberFile) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      if (numberFile == 1) {
        imageFile1 = File(image.path);
      } else if (numberFile == 2) {
        imageFile2 == File(image.path);
      } else if (numberFile == 3) {
        imageFile3 == File(image.path);
      }

      update();
    }
  }

  void showAlertDialog(BuildContext context, int numberFile) {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.gallery, numberFile);
      },
      child: Text(
        'GALERIA',
        style: TextStyle(color: Colors.black),
      ),
    );
    Widget cameraButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.camera, numberFile);
      },
      child: Text(
        'CAMARA',
        style: TextStyle(color: Colors.black),
      ),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona una opcion'),
      actions: [
        galleryButton,
        cameraButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  void clearForm() {
    nameController.text = '';
    descriptionController.text = '';
  }
}

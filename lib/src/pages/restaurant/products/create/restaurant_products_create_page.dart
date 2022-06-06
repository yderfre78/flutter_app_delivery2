import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_delivery_2/src/pages/restaurant/products/create/resturant_products_create_controller.dart';
import 'package:get/get.dart';

class RestaurantProductscreatePage extends StatelessWidget {
  RestaurantProductsCreateController con =
      Get.put(RestaurantProductsCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          Column(
            children: [
              _textNewCategory(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.12,
        left: 30,
        right: 30,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            blurRadius: 15,
            offset: Offset(0, 0.75),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldName(),
            _textFielDescription(),
            _textFieldPrice(),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<RestaurantProductsCreateController>(
                    builder: (value) => _cardImage(context, con.imageFile1, 1),
                  ),
                  SizedBox(width: 5),
                  GetBuilder<RestaurantProductsCreateController>(
                    builder: (value) => _cardImage(context, con.imageFile2, 2),
                  ),
                  SizedBox(width: 5),
                  GetBuilder<RestaurantProductsCreateController>(
                    builder: (value) => _cardImage(context, con.imageFile3, 3),
                  ),
                ],
              ),
            ),
            _buttomCreate(context),
          ],
        ),
      ),
    );
  }

  Widget _cardImage(BuildContext context, File? imageFile, int numberFile) {
    return GestureDetector(
      onTap: () => con.showAlertDialog(context, numberFile),
      child: Card(
        elevation: 3,
        child: Container(
            padding: EdgeInsets.all(10),
            height: 70,
            width: MediaQuery.of(context).size.width * 0.18,
            child: imageFile != null
                ? Image.file(
                    imageFile,
                    fit: BoxFit.cover,
                  )
                : Image(
                    image: AssetImage('assets/img/cover_image.png'),
                  )),
      ),
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.42,
      color: Colors.amber,
    );
  }

  Widget _textNewCategory(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: const Text(
          'Nuevo Producto',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: const EdgeInsets.only(
        top: 15,
      ),
      child: const Text(
        'INGRESA ESTA INFORMACION',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _textFielDescription() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: TextField(
        controller: con.descriptionController,
        keyboardType: TextInputType.text,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: 'Descripcion',
          prefixIcon: Container(
            margin: EdgeInsets.only(bottom: 50),
            child: Icon(
              Icons.description,
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: con.nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Nombre',
          prefixIcon: Icon(
            Icons.category,
          ),
        ),
      ),
    );
  }

  Widget _textFieldPrice() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: con.priceController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Precio',
          prefixIcon: Icon(
            Icons.attach_money,
          ),
        ),
      ),
    );
  }

  Widget _buttomCreate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: ElevatedButton(
        onPressed: () {
          con.createProduct();
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        child: const Text(
          'CREAR PRODUCTO',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

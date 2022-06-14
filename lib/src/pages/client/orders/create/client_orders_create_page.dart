import 'package:flutter/material.dart';
import 'package:flutter_app_delivery_2/src/models/product.dart';
import 'package:flutter_app_delivery_2/src/pages/client/orders/create/client_orders_create_controller.dart';
import 'package:flutter_app_delivery_2/src/widgets/no_data_widget.dart';
import 'package:get/get.dart';

class ClientOrdersCreatePage extends StatelessWidget {
  ClientOrdersCreateController con = Get.put(ClientOrdersCreateController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: Container(
          color: const Color.fromRGBO(245, 245, 245, 1),
          height: 100,
          child: _totalToPay(context),
          margin: EdgeInsets.only(bottom: 30),
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Mi Orden',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: con.selectedProducts.length > 0
            ? ListView(
                children: con.selectedProducts.map((Product product) {
                return _cardProduct(product);
              }).toList())
            : Container(
                alignment: Alignment.center,
                child: NoDataWidget(text: 'No hay productos en el carrito')),
      ),
    );
  }

  Widget _totalToPay(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total: \$ ${con.total.value} ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(height: 1, color: Colors.grey[400]),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () => con.goToAdressList(),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
                child: const Text(
                  'CONFIRMAR ORDEN',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _imageProduct(product),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 7),
              _buttonsAddOrRemove(product),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              _textPrice(product),
              _iconDelete(product),
            ],
          )
        ],
      ),
    );
  }

  Widget _iconDelete(Product product) {
    return IconButton(
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onPressed: () => con.deleteItem(product),
    );
  }

  Widget _textPrice(Product product) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(
        '\$${product.price! * product.quantity!}',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buttonsAddOrRemove(Product product) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => con.removeItem(product),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: const Text(
              '-',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          color: Colors.grey[200],
          child: Text('${product.quantity ?? 0}'),
        ),
        GestureDetector(
          onTap: () => con.addItem(product),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: const Text(
              '+',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _imageProduct(Product product) {
    return SizedBox(
      width: 70,
      height: 70,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage(
          image: product.image1 != null
              ? NetworkImage(product.image1!)
              : const AssetImage('assets/img/no-image.png') as ImageProvider,
          placeholder: const AssetImage('assets/img/no-image.png'),
          fadeInDuration: const Duration(milliseconds: 50),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

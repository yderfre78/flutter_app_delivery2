import 'package:flutter/material.dart';
import 'package:flutter_app_delivery_2/src/pages/client/adress/list/client_adress_list_controller.dart';
import 'package:get/get.dart';

class ClientAddressListPage extends StatelessWidget {
  ClientAddressListController con = Get.put(ClientAddressListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      title: const Text(
        'Mis Direcciones',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      actions: <Widget>[_iconAddressCreate()],
    ));
  }

  Widget _iconAddressCreate() {
    return IconButton(
      onPressed: con.goToAddressCreate,
      icon: const Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }
}

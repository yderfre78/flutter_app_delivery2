import 'package:flutter/material.dart';
import 'package:flutter_app_delivery_2/src/models/Rol.dart';
import 'package:get/get.dart';
import 'package:flutter_app_delivery_2/src/pages/roles/roles_controller.dart';

class RolesPage extends StatelessWidget {
  RolesController con = Get.put(RolesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Seleccionar Rol',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.13),
        child: ListView(
          children: con.user.roles != null
              ? con.user.roles!.map((Rol rol) {
                  return _cardRol(rol);
                }).toList()
              : [],
        ),
      ),
    );
  }

  Widget _cardRol(Rol rol) {
    return GestureDetector(
      onTap: () => con.goToPageRol(rol),
      child: SizedBox(
        height: 140,
        child: Column(
          children: [
            Text(
              rol.name ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 100,
              child: FadeInImage(
                placeholder: AssetImage(('assets/img/no-image.png')),
                image: NetworkImage(rol.image ??
                    'https://firebasestorage.googleapis.com/v0/b/delivery-app-a9bd9.appspot.com/o/restaurant.png?alt=media&token=13ad18f7-aa14-4bc2-b540-441beacce3ba'),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

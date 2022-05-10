import 'package:flutter/material.dart';
import 'package:flutter_app_delivery_2/src/pages/home/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text(
            'Cerrar session',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () => con.signOut(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app_delivery_2/src/pages/delivery/orders/list/delivery_orders_list_controllers.dart';
import 'package:get/get.dart';

class DeliveryOrdersListPage extends StatelessWidget {
  DeliveryOrdersListController con = Get.put(DeliveryOrdersListController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Delivery Orders List Page'),
      ),
    );
  }
}

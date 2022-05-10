import 'package:flutter/material.dart';
import 'package:flutter_app_delivery_2/src/pages/restaurant/orders/list/restaurant_orders_list_controllers.dart';
import 'package:get/get.dart';

class RestaurantOrdersListPage extends StatelessWidget {
 RestaurantOrdersListController con = Get.put(RestaurantOrdersListController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Restaurant Orders List'),
      ),
    );
  }
}

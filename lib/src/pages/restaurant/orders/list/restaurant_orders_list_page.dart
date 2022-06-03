import 'package:flutter/material.dart';
import 'package:flutter_app_delivery_2/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:flutter_app_delivery_2/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:flutter_app_delivery_2/src/pages/restaurant/categories/create/resturant_categories_create_controller.dart';

import 'package:flutter_app_delivery_2/src/pages/restaurant/orders/list/restaurant_orders_list_controllers.dart';
import 'package:flutter_app_delivery_2/src/utils/custom_animated_bottom_bar.dart';
import 'package:get/get.dart';

class RestaurantOrdersListPage extends StatelessWidget {
  RestaurantOrdersListController con =
      Get.put(RestaurantOrdersListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('RestaurantOrdersListPage')),
    );
  }
}

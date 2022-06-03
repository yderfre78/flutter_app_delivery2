import 'package:flutter/material.dart';
import 'package:flutter_app_delivery_2/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:flutter_app_delivery_2/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:flutter_app_delivery_2/src/pages/register/register_page.dart';
import 'package:flutter_app_delivery_2/src/pages/restaurant/orders/list/restaurant_orders_list_controllers.dart';
import 'package:flutter_app_delivery_2/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:flutter_app_delivery_2/src/utils/custom_animated_bottom_bar.dart';
import 'package:get/get.dart';

import 'client_products_list_controller.dart';

class ClientProductsListPage extends StatelessWidget {
  ClientProductsLisController con = Get.put(ClientProductsLisController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('ClientProductsListPage')),
    );
  }
}

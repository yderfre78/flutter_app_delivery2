import 'package:flutter/material.dart';
import 'package:flutter_app_delivery_2/src/models/category.dart';
import 'package:flutter_app_delivery_2/src/models/product.dart';
import 'package:flutter_app_delivery_2/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:flutter_app_delivery_2/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:flutter_app_delivery_2/src/pages/register/register_page.dart';
import 'package:flutter_app_delivery_2/src/pages/restaurant/orders/list/restaurant_orders_list_controllers.dart';
import 'package:flutter_app_delivery_2/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:flutter_app_delivery_2/src/utils/custom_animated_bottom_bar.dart';
import 'package:flutter_app_delivery_2/src/widgets/no_data_widget.dart';
import 'package:get/get.dart';

import 'client_products_list_controller.dart';

class ClientProductsListPage extends StatelessWidget {
  ClientProductsLisController con = Get.put(ClientProductsLisController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: con.categories.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.amber,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey[600],
                tabs: List<Widget>.generate(con.categories.length, (index) {
                  return Tab(
                    text: con.categories[index].name ?? '',
                  );
                }),
              ),
            ),
          ),
          body: TabBarView(
              children: con.categories.map((Category category) {
            return FutureBuilder(
              future: con.getProducts(category.id ?? '1'),
              builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (_, index) {
                        return _cardProduct(context, snapshot.data![index]);
                      },
                    );
                  } else {
                    return Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: NoDataWidget(
                            text: 'No hay productos para mostrar'));
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          }).toList()),
        ),
      ),
    );
  }

  Widget _cardProduct(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () => con.openBottonSheet(context, product),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListTile(
              title: Text(product.name ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    product.description ?? '',
                    maxLines: 2,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '\$${product.price!.toString()}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
              trailing: SizedBox(
                width: 70,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FadeInImage(
                    image: product.image1 != null
                        ? NetworkImage(product.image1!)
                        : const AssetImage('assets/img/no-image.png')
                            as ImageProvider,
                    placeholder: const AssetImage('assets/img/no-image.png'),
                    fadeInDuration: const Duration(milliseconds: 50),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            indent: 37,
            endIndent: 37,
          ),
        ],
      ),
    );
  }
}

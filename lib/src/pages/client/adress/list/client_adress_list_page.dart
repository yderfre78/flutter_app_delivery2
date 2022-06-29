import 'package:flutter/material.dart';
import 'package:flutter_app_delivery_2/src/models/address.dart';
import 'package:flutter_app_delivery_2/src/pages/client/adress/list/client_adress_list_controller.dart';
import 'package:flutter_app_delivery_2/src/widgets/no_data_widget.dart';
import 'package:get/get.dart';

class ClientAddressListPage extends StatelessWidget {
  ClientAddressListController con = Get.put(ClientAddressListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text('Ubica tus direcciones',
              style: TextStyle(color: Colors.black)),
          actions: <Widget>[_iconAddressCreate()],
        ),
        body: GetBuilder<ClientAddressListController>(
          builder: (value) => Stack(
            children: [
              _textSelectAddress(),
              _listAddress(context),
            ],
          ),
        ));
  }

  Widget _listAddress(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: FutureBuilder(
        future: con.getAddress(),
        builder: (context, AsyncSnapshot<List<Address>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                itemBuilder: (_, index) {
                  return _readioselectorAddress(snapshot.data![index], index);
                },
              );
            } else {
              return Center(
                child: NoDataWidget(
                  text: 'No hay Direcciones',
                ),
              );
            }
          } else {
            return Center(
              child: NoDataWidget(
                text: 'No hay Direcciones',
              ),
            );
          }
        },
      ),
    );
  }

  Widget _readioselectorAddress(Address address, int index) {
    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                    value: index,
                    groupValue: con.radioValue.value,
                    onChanged: con.handleRadioValueChanged),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    address.address ?? '',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    address.neighborhood ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ])
              ],
            ),
            Divider(
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _textSelectAddress() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: const Text(
        'Elige donde recivir el pedido',
        style: TextStyle(
          color: Colors.black,
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
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

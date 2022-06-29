import 'package:flutter/material.dart';
import 'package:flutter_app_delivery_2/src/models/address.dart';
import 'package:flutter_app_delivery_2/src/models/response_api.dart';
import 'package:flutter_app_delivery_2/src/models/user.dart';
import 'package:flutter_app_delivery_2/src/pages/client/adress/map/client_adress_map_page.dart';
import 'package:flutter_app_delivery_2/src/providers/address_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientAddressCreateController extends GetxController {
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController refPointController = TextEditingController();

  double latRefPoint = 0;
  double lngRefPoint = 0;
  User user = User.fromJson(GetStorage().read('user') ?? {});

  AddressProvider addressProvider = AddressProvider();

  void goToAdressList() {
    Get.offAllNamed('/client/address/list');
  }

  void openGoogleMaps(BuildContext context) async {
    Map<String, dynamic> refpointMap = await showMaterialModalBottomSheet(
      context: context,
      builder: (context) => ClientAddressMapPage(),
      isDismissible: false,
      enableDrag: false,
    );
    refPointController.text = refpointMap['adress'];
    print('REF POINT: ${refpointMap['adress']}');
    latRefPoint = refpointMap['lat'];
    lngRefPoint = refpointMap['lng'];
  }

  void createAdress() async {
    String addressName = addressController.text;
    String neighborhood = neighborhoodController.text;
    if (isValidForm(addressName, neighborhood)) {
      Address address = Address(
        address: addressName,
        neighborhood: neighborhood,
        lat: latRefPoint,
        lng: lngRefPoint,
        idUser: user.id,
      );
      ResponseApi responseApi = await addressProvider.create(address);
      Fluttertoast.showToast(
        msg: responseApi.message ?? '',
      );
      Get.back();
    }
  }

  bool isValidForm(
    String address,
    String neighborhood,
  ) {
    if (address.isEmpty) {
      Get.snackbar('Formulario no valido', 'Ingresa el nombre de la direccón');
      return false;
    }

    if (neighborhood.isEmpty) {
      Get.snackbar('Formulario no valido', 'Ingresa el nombre del barrio');
      return false;
    }
    if (latRefPoint == 0) {
      Get.snackbar('Formulario no valido', 'Ingresa el punto de referencia');
      return false;
    }
    if (lngRefPoint == 0) {
      Get.snackbar('Formulario no valido', 'Ingresa el punto de referencia');
      return false;
    }

    return true;
  }
}

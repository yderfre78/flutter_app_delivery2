import 'package:flutter/material.dart';
import 'package:flutter_app_delivery_2/src/pages/client/adress/map/client_adress_map_page.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientAddressCreateController extends GetxController {
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController refPointController = TextEditingController();
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
  }
}

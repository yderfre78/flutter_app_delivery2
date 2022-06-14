import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ClientAddressCreateController extends GetxController {
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController refPointController = TextEditingController();
  void goToAdressList() {
    Get.offAllNamed('/client/address/list');
  }
}

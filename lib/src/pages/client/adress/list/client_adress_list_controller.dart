import 'package:flutter_app_delivery_2/src/models/address.dart';
import 'package:flutter_app_delivery_2/src/models/user.dart';
import 'package:flutter_app_delivery_2/src/providers/address_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientAddressListController extends GetxController {
  List<Address> address = [];
  AddressProvider addressProvider = AddressProvider();
  User user = User.fromJson(GetStorage().read('user') ?? {});

  var radioValue = 0.obs;

  Future<List<Address>> getAddress() async {
    address = await addressProvider.findByUser(user.id ?? '');
    return address;
  }

  void handleRadioValueChanged(int? value) {
    radioValue.value = value!;
    print('VALOR SELECCIONADO: ${value}');
  }

  void goToAddressCreate() {
    Get.toNamed('/client/address/create');
  }
}

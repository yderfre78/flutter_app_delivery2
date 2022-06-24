import 'package:flutter_app_delivery_2/src/environment/environment.dart';
import 'package:flutter_app_delivery_2/src/models/address.dart';
import 'package:flutter_app_delivery_2/src/models/category.dart';
import 'package:flutter_app_delivery_2/src/models/response_api.dart';
import 'package:flutter_app_delivery_2/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddressProvider extends GetConnect {
  String url = Environment.API_URL + 'api/address';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  // Future<List<Category>> getAll() async {
  //   Response response = await get('$url/getAll', headers: {
  //     'Content-Type': 'application/json',
  //     'Authorization': userSession.sessionToken ?? ''
  //   }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

  //   if (response.statusCode == 401) {
  //     Get.snackbar('Peticion denegada',
  //         'Tu usuario no tiene permitido leer esta informacion');
  //     return [];
  //   }

  //   List<Category>? categories = Category.fromJsonList(response.body);

  //   return categories;
  // }

  Future<ResponseApi> create(Address address) async {
    Response response = await post('$url/create', address.toJson(), headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessionToken ?? ''
    }); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}

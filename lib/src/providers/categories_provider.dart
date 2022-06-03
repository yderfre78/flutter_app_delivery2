import 'package:flutter_app_delivery_2/src/environment/environment.dart';
import 'package:flutter_app_delivery_2/src/models/category.dart';
import 'package:flutter_app_delivery_2/src/models/response_api.dart';
import 'package:flutter_app_delivery_2/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CategoriesProvider extends GetConnect {
  String url = Environment.API_URL + 'api/categories';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<ResponseApi> create(Category category) async {
    Response response = await post(
      '$url/create',
      category.toJson(),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': userSession.sessionToken!,
      },
    );
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA
    return responseApi;
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_app_delivery_2/src/environment/environment.dart';
import 'package:flutter_app_delivery_2/src/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_delivery_2/src/models/user.dart';
import 'package:path/path.dart';

class ProductsProvider extends GetConnect {
  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<Stream> create(Product product, List<File> images) async {
    Uri uri = Uri.http(Environment.API_URL_OLD, '/api/products/create');
    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = userSession.sessionToken ?? '';

    for (int i = 0; i < images.length; i++) {
      request.files.add(http.MultipartFile(
          'image',
          http.ByteStream(images[i].openRead().cast()),
          await images[i].length(),
          filename: basename(images[i].path)
      ));
    }
    request.fields['product'] = json.encode(product);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter_app_delivery_2/src/models/response_api.dart';
import 'package:flutter_app_delivery_2/src/models/user.dart';
import 'package:flutter_app_delivery_2/src/pages/client/profile/info/client_profile_info_controller.dart';
import 'package:flutter_app_delivery_2/src/providers/users_provider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class ClientProfileUpdatePageController extends GetxController {
  User user = User.fromJson(GetStorage().read('user'));
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  ImagePicker picker = ImagePicker();

  UsersProvider usersProvider = UsersProvider();

  ClientProfileInfoController clientProfileInfoController = Get.find();

  ClientProfileUpdatePageController() {
    nameController.text = user.name ?? '';
    lastNameController.text = user.lastname ?? '';
    phoneController.text = user.phone ?? '';
  }
  void updateInfo(BuildContext context) async {
    String name = nameController.text;
    String lastname = lastNameController.text;
    String phone = phoneController.text.trim();

    if (isvalidForm(
      name,
      lastname,
      phone,
    )) {
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Actualizando datos...');

      User myUser = User(
        id: user.id,
        name: name,
        lastname: lastname,
        phone: phone,
        sessionToken: user.sessionToken,
      );

      if (imageFile == null) {
        ResponseApi responseApi = await usersProvider.update(myUser);
        print('Response Api Update: ${responseApi.data}');
        Get.snackbar('Proceso Terminado', responseApi.message ?? '');
        progressDialog.close();
        if (responseApi.success == true) {
          GetStorage().write('user', responseApi.data);
          clientProfileInfoController.user.value =
              User.fromJson(GetStorage().read('user') ?? {});
        }
      } else {
        Stream stream = await usersProvider.updateWithImage(myUser, imageFile!);
        stream.listen((res) {
          progressDialog.close();
          ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
          Get.snackbar('Proceso Terminado', responseApi.message ?? '');
          if (responseApi.success == true) {
            GetStorage().write('user', responseApi.data);
            clientProfileInfoController.user.value =
                User.fromJson(GetStorage().read('user') ?? {});
          } else {
            Get.snackbar('Resgistro Fallido', responseApi.message ?? '');
          }
          progressDialog.close();
        });
      }

      // Stream stream = await usersProvider.createWithImage(user, imageFile!);
      // stream.listen((res) {
      //   progressDialog.close();
      //   ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      //   if (responseApi.success == true) {
      //     GetStorage().write('user', responseApi.data);
      //     // gotoHomePage();
      //     gotoRolesPage();
      //   } else {
      //     Get.snackbar('Registro Faliido', responseApi.message ?? '');
      //   }
      // });
    }
  }

  bool isvalidForm(
    String name,
    String lastName,
    String phone,
  ) {
    if (name.isEmpty) {
      Get.snackbar('formulario no valido ', 'Debes ingresar  Nombre');
    }
    if (lastName.isEmpty) {
      Get.snackbar('formulario no valido ', 'Debes ingresar Apellido');
    }
    if (phone.isEmpty) {
      Get.snackbar(
          'formulario no valido ', 'Debes ingresar Número de Teléfono');
    }

    return true;
  }

  File? imageFile;
  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.gallery);
      },
      child: Text(
        'GALERIA',
        style: TextStyle(color: Colors.black),
      ),
    );
    Widget cameraButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.camera);
      },
      child: Text(
        'CAMARA',
        style: TextStyle(color: Colors.black),
      ),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona una opcion'),
      actions: [
        galleryButton,
        cameraButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}

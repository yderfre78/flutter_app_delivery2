import 'package:flutter/material.dart';
import 'package:flutter_app_delivery_2/src/pages/client/profile/update/client_profile_update_page_controller.dart';
import 'package:get/get.dart';

class ClientProfileUpdatePage extends StatelessWidget {
  ClientProfileUpdatePageController con =
      Get.put(ClientProfileUpdatePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _buttomBack(),
          Column(
            children: [
              _imageUser(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.24,
        left: 30,
        right: 30,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            blurRadius: 15,
            offset: Offset(0, 0.75),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldName(),
            _textFieldLastName(),
            _textFieldPhone(),
            _buttomUpdate(context),
          ],
        ),
      ),
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.42,
      color: Colors.amber,
    );
  }

  Widget _imageUser(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: GestureDetector(
            onTap: () => con.showAlertDialog(context),
            child: GetBuilder<ClientProfileUpdatePageController>(
              builder: (value) => CircleAvatar(
                backgroundImage: con.imageFile != null
                    ? FileImage(con.imageFile!)
                    : AssetImage('assets/img/user_profile.png')
                        as ImageProvider,
                radius: 60,
                backgroundColor: Colors.white,
              ),
            )),
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: const EdgeInsets.only(
        top: 15,
      ),
      child: Text(
        'INGRESA ESTA INFORMACION',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: con.nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Nombre',
          prefixIcon: Icon(
            Icons.person,
          ),
        ),
      ),
    );
  }

  Widget _textFieldLastName() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: con.lastNameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Apellido',
          prefixIcon: Icon(
            Icons.person_outline,
          ),
        ),
      ),
    );
  }

  Widget _textFieldPhone() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: con.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: 'Tel??fono',
          prefixIcon: Icon(Icons.phone),
        ),
      ),
    );
  }

  Widget _buttomUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        child: Text(
          'ACTUALIZAR',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buttomBack() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

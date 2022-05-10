import 'package:flutter/material.dart';
import 'package:flutter_app_delivery_2/src/pages/client/profile/info/client_profile_info_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class ClientProfileInfoPage extends StatelessWidget {
  ClientProfileInfoController con = Get.put(ClientProfileInfoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          Column(
            children: [
              _imageUser(context),
            ],
          ),
          _buttomSignOut()
        ],
      ),
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.53,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.28,
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
        child: Container(
          margin: EdgeInsets.only(top: 18),
          child: Column(
            children: [
              _textName(),
              _textEmail(),
              _textPhone(),
              _buttomUpdate(context),
            ],
          ),
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
        child: CircleAvatar(
          backgroundImage: con.user.image != null
              ? NetworkImage(con.user.image!)
              : AssetImage('assets/img/user_profile.png') as ImageProvider,
          radius: 60,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _textName() {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text('Nombre del usuario'),
      subtitle: Text('${con.user.name ?? ''} '),
    );
  }

  Widget _textEmail() {
    return ListTile(
      leading: Icon(Icons.email),
      title: Text('Email'),
      subtitle: Text('${con.user.email ?? ''} '),
    );
  }

  Widget _textPhone() {
    return ListTile(
      leading: const Icon(Icons.phone),
      title: const Text('Télefono'),
      subtitle: Text('${con.user.phone ?? ''} '),
    );
  }

  Widget _buttomUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: ElevatedButton(
        onPressed: () => con.goToProfileUpdate(),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: const Text(
          'ACTUALIZAR DATOS',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buttomSignOut() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(right: 15),
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () => con.signOut(),
          icon: Icon(
            Icons.power_settings_new,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

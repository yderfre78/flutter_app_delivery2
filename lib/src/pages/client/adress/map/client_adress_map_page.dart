import 'package:flutter/material.dart';
import 'package:flutter_app_delivery_2/src/pages/client/adress/map/client_address_map_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientAddressMapPage extends StatelessWidget {
  ClientAddressMapController con = Get.put(ClientAddressMapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Ubica tu punto de referencia en el mapa',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Stack(
          children: [
            _googleMaps(),
            _cardAdress(context),
            _iconMyLocation(),
            _buttonAccept(context)
          ],
        ));
  }

  Widget _googleMaps() {
    return GoogleMap(
      initialCameraPosition: con.initialPosition,
      mapType: MapType.normal,
      onMapCreated: con.onMapCreated,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      onCameraMove: (position) {
        con.initialPosition = position;
      },
    );
  }

  Widget _cardAdress(context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.symmetric(
        vertical: 20,
      ),
      height: MediaQuery.of(context).size.height * 0.1,
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: const Text(
            'Name Address',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        color: Color(0xFF1E221F).withOpacity(0.6),
        margin: const EdgeInsets.all(8),
      ),
    );
  }

  Widget _iconMyLocation() {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        'assets/img/my_location_yellow.png',
        width: 65,
        height: 65,
      ),
    );
  }

  Widget _buttonAccept(context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: const Text(
          'Seleccionar este punto',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(10)
        ),
      ),
    );
  }
}

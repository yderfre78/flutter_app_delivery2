import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;

class ClientAddressMapController extends GetxController {
  CameraPosition initialPosition = const CameraPosition(
    target: LatLng(4.6206918, -74.191437),
    zoom: 14,
  );

  LatLng? adressLatLng;
  var adressName = ''.obs;

  Completer<GoogleMapController> mapController = Completer();

  Position? position;
  ClientAddressMapController() {
    checkGPS(); //VERIFICA SI EL GPS ESTA ACTIVO
  }

  Future setLocationDraggableInfo() async {
    double lat = initialPosition.target.latitude;
    double lng = initialPosition.target.longitude;
    List<Placemark> adress = await placemarkFromCoordinates(lat, lng);
    if (adress.isNotEmpty) {
      String direction = adress[0].thoroughfare ?? '';
      String street = adress[0].subThoroughfare ?? '';
      String city = adress[0].locality ?? '';
      String department = adress[0].administrativeArea ?? '';
      String country = adress[0].country ?? '';
      adressName.value = '$direction # $street, $city, $department,';
      adressLatLng = LatLng(lat, lng);
      print('LAT LNG: $lat, $lng');
    }
  }

  void checkGPS() async {
    bool isLoactionEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLoactionEnabled == true) {
      updateLocation();
    } else {
      bool locationGPS = await location.Location().requestService();
      if (locationGPS == true) {
        updateLocation();
      }
    }
    ;
  }

  void updateLocation() async {
    try {
      await _determinePosition();
      position =
          await Geolocator.getLastKnownPosition(); //LAT Y LNG (POSITION ACTUAL)
      animateCameraPosition(
          position?.latitude ?? 4.6206918, position?.longitude ?? -74.191437);
    } catch (e) {
      print('Error: $e');
    }
  }

  void selectRefOption(BuildContext context) {
    if (adressLatLng != null) {
      Map<String, dynamic> data = {
        'adress': adressName.value,
        'lat': adressLatLng!.latitude,
        'lng': adressLatLng!.longitude,
      };
      Navigator.pop(context, data);
    }
  }

  Future animateCameraPosition(double lat, double lng) async {
    GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, lng), zoom: 14, bearing: 0),
    ));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(
        '[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]');
    mapController.complete(controller);
  }
}

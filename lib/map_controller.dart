import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_marker/marker_icon.dart';
import 'model.dart';


class MapController extends GetxController {
  late GoogleMapController mapController;
  Rx<LatLng> sourceLoc = Rx(const LatLng(0, 0));
  RxList markerList=RxList();

  late PageController controllerPage;
  int prevPage=0;

  @override
  void onInit() {
    super.onInit();
    getList();
    controllerPage=PageController(initialPage: 1,viewportFraction: 0.8)..addListener(_onScroll);
  }
  void getList() async {
    for (var element in list) {
      markerList.add(Marker(
          markerId: MarkerId(element.name),
          draggable: false,
          infoWindow: InfoWindow(title:element.name,snippet: element.address),
          position: element.cordinates,
          icon: await MarkerIcon.downloadResizePictureCircle(element.image, size: 150,
              addBorder: true,
              borderColor: Colors.white,
              borderSize: 15),
      ));
    }
  }

  void _onScroll() {
    if (controllerPage.page != prevPage) {
      prevPage = controllerPage.page!.toInt();
      moveCamera();
    }
  }

  void moveCamera() async{
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: list[controllerPage.page!.toInt()].cordinates,zoom: 14,bearing: 45,tilt: 45,),
    ));
  }

  onmapCreate(GoogleMapController controller) {
    mapController = controller;
    moveCamera();
    // getCurrentPosition(controller);
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }


}
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../model/model_google_place_list.dart';
import 'app_config_controller.dart';

extension GetLatLong on Position {
  LatLng get latLong {
    return LatLng(latitude, longitude);
  }
}

class LocationController extends GetxController {
  Position? userLocation;
  RxInt refreshInt = 0.obs;
  StreamSubscription<ServiceStatus>? locationSubscription;
  StreamSubscription<Position>? getPositionStream;
  ModelGoogleResponse? selectedPlace;
  bool nearBy = false;

  Function()? onServiceEnable;
  Function(Position v)? onPositionChange;

  Future<Position?> determinePosition({
    required Function() locationServiceNotEnabled,
    required Function() permissionDenied,
  }) async {
    locationSubscription ??= Geolocator.getServiceStatusStream().listen((e) {
      if (e == ServiceStatus.enabled) {
        onServiceEnable?.call();
      }
    });
    getPositionStream ??= Geolocator.getPositionStream().listen((Position v) {
      onPositionChange?.call(v);
      userLocation = v;
      updateUI();
    });
    bool serviceEnabled;

    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationServiceNotEnabled();
      throw Exception('Location services are disabled.');
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // return Future.error('Location services are disabled.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        nearBy = false;

        fetchAllMosques();
        // Assign latitude and longitude to userLocation
        userLocation = Position(
          latitude: 26.2535,
          longitude: 50.6083,
            speedAccuracy:0.0,
          timestamp: DateTime.now(), // Set a timestamp
          accuracy: 10.0,
          altitude: 50.0,
          heading: 45.0, // Set a heading value
          headingAccuracy: 5.0,
          speed: 10.0, // Set a speed value
          altitudeAccuracy: 2.0,
          // Set other properties as needed
        );
        print('----LOCATIONm---${userLocation}');

        return userLocation;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();

      nearBy = false;

      fetchAllMosques();
      userLocation = Position(
        latitude: 26.2535,
        longitude: 50.6083,
        speedAccuracy:0.0,
        timestamp: DateTime.now(), // Set a timestamp
        accuracy: 10.0,
        altitude: 50.0,
        heading: 45.0, // Set a heading value
        headingAccuracy: 5.0,
        speed: 10.0, // Set a speed value
        altitudeAccuracy: 2.0,
        // Set other properties as needed
      );
      print('----LOCATIONs---${userLocation}');

      return userLocation;
    }

    await Geolocator.requestPermission();

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    userLocation = await Geolocator.getCurrentPosition();
    if (userLocation != null) {
      nearBy = true;
      fetchNearbyMosques();
    }
    updateUI();
    return userLocation;
  }

  updateUI() {
    refreshInt.value = DateTime.now().millisecondsSinceEpoch;
  }

  Set<Marker> markers = {};

  Future fetchNearbyMosques() async {
    final appConfigController = Get.put(AppConfigController());
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=${appConfigController.googleApiKey}&location=${userLocation!.latitude},${userLocation!.longitude}&radius=1000&keyword=mosque';
    // Uint8List destinationImageData = await convertAssetToUnit8List(Images.destinationMarker, width: 150);
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    if (data['status'] == 'OK') {
      final results = data['results'] as List;
      List<ModelGoogleResponse> resultsList = results.map((e) => ModelGoogleResponse.fromJson(e)).toList();
      BitmapDescriptor markerIcon = await BitmapDescriptor.asset(ImageConfiguration(
        size: Size(40, 40)
      ), "assets/images/mosque_icon.png");
      // log("results....   ${jsonEncode(results)}");
      for (final result in resultsList) {
        // final geometry = result['geometry'] as Map;
        // final location = geometry['location'] as Map;
        final lat = result.geometry?.location?.lat ?? 0;
        final lng = result.geometry?.location?.lng ?? 0;
        final name = result.name;
        final vicinity = result.vicinity;

        markers.add(Marker(
          markerId: MarkerId(result.placeId.toString()),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: name,
            snippet: vicinity,
          ),
          onTap: () {
            selectedPlace = result;
            updateUI();
          },
          icon: markerIcon,
        ));
      }
    }
  }
  Future fetchAllMosques() async {

    final appConfigController = Get.put(AppConfigController());
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=${appConfigController.googleApiKey}&location=${26.2535},${50.6083}&radius=1000&keyword=mosque';
    // Uint8List destinationImageData = await convertAssetToUnit8List(Images.destinationMarker, width: 150);
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    if (data['status'] == 'OK') {
      final results = data['results'] as List;
      List<ModelGoogleResponse> resultsList = results.map((e) => ModelGoogleResponse.fromJson(e)).toList();
      BitmapDescriptor markerIcon = await BitmapDescriptor.asset(ImageConfiguration(
          size: Size(40, 40)
      ), "assets/images/mosque_icon.png");
      for (final result in resultsList) {
        // final geometry = result['geometry'] as Map;
        // final location = geometry['location'] as Map;
        final lat = result.geometry?.location?.lat ?? 0;
        final lng = result.geometry?.location?.lng ?? 0;
        final name = result.name;
        final vicinity = result.vicinity;

        markers.add(Marker(
          markerId: MarkerId(result.placeId.toString()),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: name,
            snippet: vicinity,
          ),
          onTap: () {
            selectedPlace = result;
            updateUI();
          },
          icon: markerIcon,
        ));


      }
    }
  }

}

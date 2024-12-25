import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:donation_app/widgets/app_image_widget.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controller/app_config_controller.dart';
import '../controller/home_controller.dart';
import '../controller/location_controller.dart';
import '../helpers/helper.dart';
import '../resources/app_colors.dart';
import '../widgets/show_no_service_enable_widget.dart';
import 'checkout_screen.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  GoogleMapController? googleMapController;

  final locationController = Get.put(LocationController(), permanent: true);
  final homeController = Get.put(HomeController());
  final appConfigController = Get.put(AppConfigController());

  locationServiceNotEnabled() {
    if (mounted) {
      ShowNoServiceEnableWidget.showLocationDialog(context);
    }
  }

  permissionDenied() {}

  getLocation() {
    locationController.determinePosition(
        locationServiceNotEnabled: locationServiceNotEnabled, permissionDenied: permissionDenied);
  }

  onLocationUpdate(Position v) {}

  @override
  void initState() {
    super.initState();
    locationController.selectedPlace = null;
    locationController.onServiceEnable = (getLocation);
    locationController.onPositionChange = (onLocationUpdate);
    getLocation();
  }

  @override
  void dispose() {
    super.dispose();
    locationController.onServiceEnable = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: AppText(
          "Choose Mosques",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SafeArea(
        child: Obx(() {
          if (locationController.refreshInt.value > 0) {}
          return Stack(
            children: [
              Positioned.fill(
                child: locationController.nearBy
                    ? GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: locationController.userLocation!.latLong,
                          zoom: 14.4746,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId("User"),
                            position: locationController.userLocation!.latLong,
                          ),
                          ...locationController.markers
                        },
                        onMapCreated: (GoogleMapController c) {
                          googleMapController = c;
                        },
                      )
                    :GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(26.2535,50.6083),
                    zoom: 14.4746,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId("User"),
                      position: LatLng(26.2535,50.6083),
                    ),
                    ...locationController.markers
                  },
                  onMapCreated: (GoogleMapController c) {
                    googleMapController = c;
                  },
                )
                // Center(
                //         child: CircularProgressIndicator(),
                //       ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child:Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: homeController.productsList?.map((e) {
                                final item = e;
                                bool selected = homeController.productId == item.id.toString();
                                if (selected == false) {
                                  return SizedBox.shrink();
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: SizedBox(
                                    width: context.width * .32,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => PlacesScreen());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Colors.white,
                                            boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 6)]),
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: context.width * .32,
                                              height: context.width * .2,
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(8),
                                                  child: Container(
                                                      child: AppImageWidget(
                                                        imageUrl: item.image.toString(),
                                                        userBaseUrl: true,
                                                      ))),
                                            ),
                                            Gap(4),
                                            Column(
                                              children: [
                                                Directionality(
                                                  textDirection: ui.TextDirection.ltr,

                                                  child: AppText(
                                                    item.name,
                                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                                  ),
                                                ),
                                                if ((item.size ?? "").toString().isNotEmpty)
                                                  AppText(
                                                    item.size ?? "",
                                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12,color: Colors.grey.withOpacity(0.9)),
                                                  ),
                                                AppText(
                                                  addCurrency((item.price ?? "").toString()),
                                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                                ),

                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList() ??
                              [],
                        ),
                      ),
                      Gap(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ).copyWith(bottom: 10),
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          child: ElevatedButton(
                              onPressed: locationController.selectedPlace != null
                                  ? () async {
                                      if (locationController.selectedPlace == null) {
                                        await Get.closeCurrentSnackbar();
                                        Get.showSnackbar(GetSnackBar(
                                          title: "Select Mosque Location",
                                          message: "Select nearby mosque location",
                                          snackPosition: SnackPosition.TOP,
                                          isDismissible: true,
                                          snackStyle: SnackStyle.GROUNDED,
                                          duration: 5.seconds,
                                        ));
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(SnackBar(content: AppText("Select Mosque Location",style: TextStyle(
                                        //   color: Colors.white
                                        // ),)));
                                        return;
                                      }
                                      Get.to(() => CheckoutScreen());
                                      // if (count == null) {
                                      //   homeController.addToCart(item.id.toString());
                                      // }
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                // visualDensity: VisualDensity.compact
                              ),
                              child: AppText(
                                "Continue",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                              )),
                        ),
                      ),
                    ],
                  ) ),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      if (locationController.selectedPlace != null)
                        AnimatedSwitcher(
                          duration: 500.milliseconds,
                          child: Container(
                            key: ValueKey(locationController.selectedPlace),
                            margin: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 18),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 6)]),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 46,
                                  height: 46,
                                  child: AppImageWidget(
                                    imageUrl: locationController.selectedPlace?.icon.toString() ?? "",
                                    userBaseUrl: true,
                                    errorBuilder: () {
                                      return AppImageWidget.appIcon;
                                    },
                                  ),
                                ),
                                Gap(16),
                                Expanded(
                                    child: AppText(
                                  locationController.selectedPlace?.name ?? "",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ))
                              ],
                            ),
                          ),
                        ),
                    ],
                  )),
            ],
          );
        }),
      ),
    );
  }
}

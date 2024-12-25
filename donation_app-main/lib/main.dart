import 'package:donation_app/controller/home_controller.dart';
import 'package:donation_app/controller/location_controller.dart';
import 'package:donation_app/widgets/show_no_service_enable_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/app_config_controller.dart';
import 'resources/app_colors.dart';
import 'resources/translation.dart';
import 'screens/splash_screen.dart';

bool englishLanguage = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // sharedPreferences.setBool('englishLanguage', englishLanguage);

  englishLanguage = sharedPreferences.getBool('englishLanguage') ?? false;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appConfigController = Get.put(AppConfigController(), permanent: true);
  GoogleMapController? googleMapController;

  final locationController = Get.put(LocationController(), permanent: true);
  final homeController = Get.put(HomeController());
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
    appConfigController.getAppConfig();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saqya Connect',
      translations: AppTranslations(),
      locale: englishLanguage ? Locale('en', 'US') : Locale('ar', 'SA'),
      fallbackLocale: kDebugMode ? Locale('en', 'US') : Locale('ar', 'SA'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.primary),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

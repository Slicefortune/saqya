import 'dart:convert';

import 'package:donation_app/repository/api_urls.dart';
import 'package:donation_app/repository/common_repo.dart';
import 'package:get/get.dart';

import '../model/model_app_config.dart';

// enum BaseUrlType {
//   banner,
//   product,
// }

class AppConfigController extends GetxController {
  ModelAppConfig? modelAppConfig;
  RxInt refreshInt = 0.obs;

  static String localMapKey = "AIzaSyAwEmv3whQry4abe7SnIuPS4ttniNdkLuI";

  String get baseUrl {
    return "${ApiUrls.baseUrl.toString() ?? ""}/storage/";
    String item = "";
    // if (type == BaseUrlType.product) {
    //   item = "${modelAppConfig!.baseUrls?.productImageUrl.toString() ?? ""}/";
    // }
    // if (type == BaseUrlType.banner) {
    //   item = "${modelAppConfig!.baseUrls?.bannerImageUrl.toString() ?? ""}/";
    // }
    // final kk = item.split("storage").first;
    // if (kk.isNotEmpty) {
    //   return "${kk}storage/";
    // }
    return item;
  }

  String get googleApiKey {
    return (modelAppConfig?.mapApiServerKey ?? localMapKey).toString();
  }

  getAppConfig() {
    _getAppConfig();
    Repositories().getApi(url: ApiUrls.configUrl, saveToLocal: true).then((v) {
      modelAppConfig = ModelAppConfig.fromJson(jsonDecode(v));
      updateUI();
    });
  }

  _getAppConfig() {
    Repositories.getFromLocal(ApiUrls.configUrl).then((v) {
      if (v == null) return;
      modelAppConfig = ModelAppConfig.fromJson(jsonDecode(v));
      updateUI();
    });
  }

  updateUI() {
    refreshInt.value++;
  }
}

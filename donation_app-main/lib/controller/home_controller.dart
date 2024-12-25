import 'dart:convert';

import 'package:donation_app/repository/api_urls.dart';
import 'package:donation_app/repository/common_repo.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../model/model_banners_list.dart';
import '../model/model_products_list.dart';
import '../screens/places_screen.dart';

class HomeController extends GetxController {
  RxInt refreshInt = 0.obs;

  List<ModelBannersList>? bannersList;
  List<ModelProductsList>? productsList;

  // Map<String, int> cartItems = {};

  ModelProductsList? get selectedProduct {
    if (productsList == null) return null;
    if (productId == null) return null;
    return productsList!.firstWhere((element) => element.id.toString() == productId);
  }

  String? productId;
  addToCart(dynamic v) {
    productId = v.toString();
    updateUI();
  }

  Future getProducts() async {
    _getProducts();
    await Repositories().getApi(url: ApiUrls.productsUrl, saveToLocal: true).then((v) {
      final _list = jsonDecode(v) as List<dynamic>;
      productsList = _list.map((e) => ModelProductsList.fromJson(e)).toList();
      updateUI();
    });
  }

  _getProducts() {
    Repositories.getFromLocal(ApiUrls.productsUrl).then((v) {
      if (v == null) return;
      final _list = jsonDecode(v) as List<dynamic>;
      productsList = _list.map((e) => ModelProductsList.fromJson(e)).toList();
      updateUI();
    });
  }

  getAppBanners() {
    _getAppBanners();
    Repositories().getApi(url: ApiUrls.bannersUrl, saveToLocal: true).then((v) {
      final _list = jsonDecode(v) as List<dynamic>;
      bannersList = _list.map((e) => ModelBannersList.fromJson(e)).toList();
      updateUI();
    });
  }

  _getAppBanners() {
    Repositories.getFromLocal(ApiUrls.bannersUrl).then((v) {
      if (v == null) return;
      final _list = jsonDecode(v) as List<dynamic>;
      bannersList = _list.map((e) => ModelBannersList.fromJson(e)).toList();
      updateUI();
    });
  }

  updateUI() {
    refreshInt.value = DateTime.now().millisecondsSinceEpoch;
  }
}

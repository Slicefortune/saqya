import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/app_config_controller.dart';

class AppImageWidget extends StatefulWidget {
  const AppImageWidget({super.key, required this.imageUrl, this.errorBuilder, this.fit, required this.userBaseUrl});

  final String imageUrl;
  final Widget Function()? errorBuilder;
  final BoxFit? fit;
  final bool userBaseUrl;

  static Widget get appIcon {
    return Image.asset("assets/images/app_icon.png");
  }

  @override
  State<AppImageWidget> createState() => _AppImageWidgetState();
}

class _AppImageWidgetState extends State<AppImageWidget> {
  final appConfigController = Get.put(AppConfigController());
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      log("widget.imageUrl....   ${widget.userBaseUrl ? appConfigController.baseUrl : ""}${widget.imageUrl}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (appConfigController.refreshInt.value > 0) {}
      return CachedNetworkImage(
        imageUrl: "${widget.userBaseUrl ? appConfigController.baseUrl : ""}${widget.imageUrl}",
        fit: widget.fit,
        placeholder: (c, s) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade100,
            highlightColor: Colors.white,
            child: Container(
              width: context.width,
              height: context.height,
              color: Colors.white,
            ),
          );
        },
        errorWidget: (_, __, ___) {
          // return Shimmer.fromColors(
          //   baseColor: Colors.red,
          //   highlightColor: Colors.yellow,
          //   child: SizedBox(
          //     width: context.width,
          //     height: context.height,
          //   ),
          // );
          // log("widget.imageUrl...errorWidget.   ${widget.imageUrl}");
          // log("url....   ${item.image.toString()}");
          return widget.errorBuilder != null ? widget.errorBuilder!() : Center(child: SizedBox());
        },
      );
    });
  }
}

extension MakeShimmers on Widget {
  Widget get makeShimmer {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Colors.white,
      child: this,
    );
  }
}

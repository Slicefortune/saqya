import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controller/app_config_controller.dart';
import '../controller/home_controller.dart';
import '../controller/location_controller.dart';
import '../helpers/helper.dart';
import '../model/model_order_create_data.dart';
import '../repository/api_urls.dart';
import '../repository/common_repo.dart';
import '../resources/app_colors.dart';
import '../widgets/app_text.dart';
import 'payment_screen.dart';

class PaymentOptionScreen extends StatefulWidget {
  const PaymentOptionScreen(
      {super.key,
      required this.sub_total,
      required this.total,
      required this.count,
      required this.receiverName,
      required this.phoneNumber,
      required this.description});
  final String sub_total;
  final String total;
  final String count;
  final TextEditingController receiverName;
  final TextEditingController phoneNumber;
  final TextEditingController description;

  @override
  State<PaymentOptionScreen> createState() => _PaymentOptionScreenState();
}

class _PaymentOptionScreenState extends State<PaymentOptionScreen> {
  final locationController = Get.put(LocationController(), permanent: true);
  final homeController = Get.put(HomeController());
  final appConfigController = Get.put(AppConfigController());

  placePaymentAPI() {
    final uri = Uri.parse(ApiUrls.donationUrl).replace(queryParameters: {
      "receiver_name": widget.receiverName.text.trim(),
      "receiver_contact": widget.phoneNumber.text.trim(),
      "description": widget.description.text.trim(),
      "mosque_name": (locationController.selectedPlace?.name).toString(),
      "mosque_address": (locationController.selectedPlace?.vicinity).toString(),
      "sub_total": widget.sub_total,
      "payment_method": "1",
      "total": widget.total,
      "quantity": widget.count,
      "product_id": homeController.productId,
    });

    Repositories().postApi(url: uri.toString(), context: context).then((v) {
      ModelOrderCreateData modelOrderCreateData = ModelOrderCreateData.fromJson(jsonDecode(v));
      if (modelOrderCreateData.redirectUrl != null) {
        if (mounted) {
          Get.to(() => PaymentScreen(
                paymentUrl: modelOrderCreateData.redirectUrl.toString(),
              ));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: context.width,
      height: context.height,
      child: Stack(
        children: [
          Positioned.fill(
              child: Image.network(
            "https://images.pexels.com/photos/337904/pexels-photo-337904.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
            fit: BoxFit.cover,
          )),
          Positioned.fill(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                  ))),
          Positioned.fill(
            child: Scaffold(
              appBar: AppBar(
                leading: BackButton(
                  color: Colors.white,
                ),
                title: AppText(
                  "Card Details",
                  style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
                ),
                backgroundColor: AppTheme.primaryColor,
              ),
              backgroundColor: Colors.transparent,
              body: Container(
                width: context.width,
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Gap(100),
                    SizedBox(
                        width: context.width * .4,
                        height: context.width * .4,
                        child: SvgPicture.asset(
                          "assets/svgs/payment_icon.svg",
                          fit: BoxFit.cover,
                        )),
                    Gap(50),
                    FractionallySizedBox(
                      widthFactor: 1,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(color: Colors.grey.shade50, blurRadius: 5)]),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          child: AppText(
                            "${"Total Amount".tr} : ${addCurrency(widget.total.toString())} ",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          )),
                    ),
                    Gap(50),
                    GestureDetector(
                      onTap: () {
                        placePaymentAPI();
                      },
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(color: Colors.grey.shade50, blurRadius: 5)]),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset("assets/svgs/card_icon.svg"),
                                Gap(10),
                                Flexible(
                                  child: AppText(
                                    "Debit Card",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

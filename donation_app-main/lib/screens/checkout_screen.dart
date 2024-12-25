import 'dart:convert';
import 'dart:ui' as ui;

import 'package:donation_app/main.dart';
import 'package:donation_app/repository/api_urls.dart';
import 'package:donation_app/repository/common_repo.dart';
import 'package:donation_app/resources/app_colors.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controller/app_config_controller.dart';
import '../controller/home_controller.dart';
import '../controller/location_controller.dart';
import '../helpers/helper.dart';
import '../model/model_order_create_data.dart';
import 'payment_screen.dart';
import 'questions_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final locationController = Get.put(LocationController(), permanent: true);
  final homeController = Get.put(HomeController());
  final appConfigController = Get.put(AppConfigController());
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: AppText(
          "Summary",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Stack(
          children: [
            // Stack(
            //   children: [
            //     Image.network(
            //         "https://images.pexels.com/photos/337904/pexels-photo-337904.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
            //   ],
            // ),
            Positioned.fill(
              child: ListView(
                // padding: EdgeInsets.all(16),
                children: [
                  Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          "https://images.pexels.com/photos/337904/pexels-photo-337904.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(180),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 10)]),
                            padding: EdgeInsets.all(14),
                            child: Row(
                              children: [
                                Expanded(
                                    child: AppText(
                                  "${locationController.selectedPlace?.name ?? "Mosque"}",
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                )),
                                Row(
                                  children: [
                                    IconButton(
                                        visualDensity: VisualDensity.compact,
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          if (count == 1) return;
                                          count--;
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.remove)),
                                    Gap(4),
                                    AppText(
                                      count.toString(),
                                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                                    ),
                                    Gap(4),
                                    IconButton(
                                        visualDensity: VisualDensity.compact,
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          count++;
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.add)),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Gap(20),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(16),
                        AppText(
                          "Summary",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        Gap(30),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 10)]),
                          padding: EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 5),
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      locationController.selectedPlace?.name ?? "",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                    Gap(12),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [BoxShadow(color: Colors.grey.shade500, blurRadius: 4)],
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                child: Directionality(
                                                  textDirection: ui.TextDirection.ltr,

                                                  child: AppText(
                                                    homeController.selectedProduct!.name,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ))),
                                        Gap(12),
                                        Expanded(
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [BoxShadow(color: Colors.grey.shade500, blurRadius: 4)],
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                child: Directionality(
                                                  textDirection: ui.TextDirection.ltr,

                                                  child: AppText(
                                                    // englishLanguage
                                                    //     ?
                                                    "${homeController.selectedProduct!.price ?? 0} x ${count}pcs",
                                                        // : "${homeController.selectedProduct!.price ?? 0} ${count}pcs x",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ))),
                                      ],
                                    )
                                  ],
                                )),
                                Gap(20),
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppTheme.primaryColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10000),
                                        bottomLeft: Radius.circular(10000),
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      )),
                                  padding: EdgeInsets.only(left: 18, right: 4),
                                  alignment: Alignment.center,
                                  child: AppText(
                                    (homeController.selectedProduct!.priceDouble * count).toStringAsFixed(2),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Gap(50),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 10)]),
                          padding: EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 16),
                          child: Row(
                            children: [
                              AppText("Total", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                              Spacer(),
                              AppText(
                                addCurrency((homeController.selectedProduct!.priceDouble * count).toStringAsFixed(2)),
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Gap(50),
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.to(() => QuestionsScreen(
                                    sub_total: (homeController.selectedProduct!.priceDouble * count).toInt().toString(),
                                    total: (homeController.selectedProduct!.priceDouble * count).toInt().toString(),
                                    count: count.toString()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CupertinoColors.activeGreen,
                                padding: EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                // visualDensity: VisualDensity.compact
                              ),
                              child: AppText(
                                "Proceed",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:donation_app/controller/app_config_controller.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';
import '../controller/location_controller.dart';
import '../model/model_order_create_data.dart';
import '../repository/api_urls.dart';
import '../repository/common_repo.dart';
import '../resources/app_colors.dart';
import '../widgets/common_text_field.dart';
import 'payment_option_screen.dart';
import 'payment_screen.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.sub_total, required this.total, required this.count});
  final String sub_total;
  final String total;
  final String count;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final locationController = Get.put(LocationController(), permanent: true);
  final homeController = Get.put(HomeController());
  final appConfigController = Get.put(AppConfigController());
  final TextEditingController receiverName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: AppText(
          "Add Notes",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: context.width * .56,
            child: Image.network(
              "https://images.pexels.com/photos/337904/pexels-photo-337904.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
              fit: BoxFit.cover,
            ),
          ),
          Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(()=> PaymentOptionScreen(
                    count: widget.count,
                    sub_total: widget.sub_total,
                    total: widget.total,
                    description: description,
                    phoneNumber: phoneNumber,
                    receiverName: receiverName,
                  ));

                },
                child: AppText(
                  "Skip Receiver Details",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color:Theme.of(context).primaryColor ),
                ),
              ),
            ],
          ),
          Gap(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SizedBox(width: 18, height: 18, child: Image.asset("assets/images/mosque_icon.png")),
                Gap(10),
                Flexible(child: AppText(locationController.selectedPlace?.name)),
              ],
            ),
          ),
          Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  "Receiver Name (Optional)",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(10),
                CommonTextField(
                  controller: receiverName,
                ),
                Gap(20),
                AppText(
                  "Phone Number (Optional)",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(10),
                CommonTextField(
                  controller: phoneNumber,
                ),
                Gap(20),
                AppText(
                  "Description (Optional)",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(10),
                CommonTextField(
                  controller: description,
                  maxLines: 6,
                  minLines: 6,
                ),
              ],
            ),
          ),
          Gap(50),
          FractionallySizedBox(
            widthFactor: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Get.to(()=> PaymentOptionScreen(
                      count: widget.count,
                      sub_total: widget.sub_total,
                      total: widget.total,
                      description: description,
                      phoneNumber: phoneNumber,
                      receiverName: receiverName,
                    ));

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
          ),
        ],
      ),
    );
  }
}

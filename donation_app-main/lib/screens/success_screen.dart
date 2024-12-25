import 'package:donation_app/helpers/helper.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../resources/app_colors.dart';
import 'home_page.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (b, v) {
        Get.offAll(() => HomePage());
      },
      child: Scaffold(
        body: SizedBox(
          width: context.width,
          height: context.height,
          key: kDebugMode ? UniqueKey() : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                "Payment Successfully Done",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Gap(20),
              Icon(
                Icons.check_circle,
                size: 80,
                color: Colors.green,
              ).animate().scale().fade(),
              Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.offAll(() => HomePage());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        // visualDensity: VisualDensity.compact
                      ),
                      child: AppText(
                        "Go to Home",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                      )),
                ),
              )
            ]
                // .animate().scale()
                // .animate(interval: GetNumUtils(100).milliseconds).fade()
                // .slideY(),
          ),
        ),
      ),
    );
  }
}

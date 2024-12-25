import 'package:donation_app/controller/app_config_controller.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../policy_pages.dart';
import 'change_language_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final appConfig = Get.put(AppConfigController());
  bool? englishLanguage;
  // Home , change Language , Privacy Policy , terms & conditions
  @override
  Widget build(BuildContext context) {

    return Drawer(
      backgroundColor: Colors.white,

      child: Obx(() {
        if (appConfig.refreshInt.value > 0) {}
        return Column(
          children: [
            DrawerHeader(child: Image.asset("assets/images/app_icon.png")),
            Gap(20),
            ListTile(
              onTap: () {
                Get.to(() => ChangeLanguageScreen());
              },
              leading: Icon(Icons.language),
              title: AppText("Change Language"),
            ),
            if (appConfig.modelAppConfig?.privacyPolicyEn != null)
              ListTile(
                onTap: () async{
                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  englishLanguage = sharedPreferences.getBool('englishLanguage');

                  Get.to(() => PolicyPages(
                        title: "Privacy Policy",
                        url:englishLanguage == true ? appConfig.modelAppConfig!.privacyPolicyEn.toString(): appConfig.modelAppConfig!.privacyPolicyAr.toString(),
                      ));
                },
                leading: Icon(Icons.privacy_tip_outlined),
                title: AppText("Privacy Policy"),
              ),
            if (appConfig.modelAppConfig?.termsAndConditionsEn != null)
              ListTile(
                onTap: ()async {
                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  englishLanguage = sharedPreferences.getBool('englishLanguage');
                  Get.to(() => PolicyPages(
                        title: "Terms & Conditions",
                        url:englishLanguage == true ?appConfig.modelAppConfig!.termsAndConditionsEn.toString() : appConfig.modelAppConfig!.termsAndConditionsAr.toString(),
                      ));
                },
                leading: Icon(Icons.event_note_sharp),
                title: AppText("Terms & Conditions"),
              ),

          ],
        );
      }),
    );
  }
}

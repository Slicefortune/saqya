import 'package:donation_app/resources/app_colors.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: AppText("Change Language",

          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18)),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: ListView(
        children: [
          ListTile(
            title: AppText('English'),
            onTap: () async {
              Get.updateLocale(Locale('en', 'US'));
              englishLanguage = true;
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setBool('englishLanguage', englishLanguage);
            },
          ),
          ListTile(
            title: AppText('العربية'), // Arabic text for "Arabic"
            onTap: () async {
              Get.updateLocale(Locale('ar', 'SA'));
              englishLanguage = false;
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setBool('englishLanguage', englishLanguage);
            },
          ),
        ],
      ),
    );
  }
}

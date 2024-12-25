import 'dart:io';
import 'dart:ui' as ui;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:donation_app/resources/app_colors.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../controller/app_config_controller.dart';
import '../controller/home_controller.dart';
import '../helpers/helper.dart';
import '../widgets/app_image_widget.dart';
import 'drawer_screens/drawer_screen.dart';
import 'places_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Here we create a instance of controller
  final homeController = Get.put(HomeController());
  final appConfigController = Get.put(AppConfigController());
  @override
  void initState() {
    super.initState();
    homeController.productId == null;
    SchedulerBinding.instance.addPostFrameCallback((v) {
      homeController.getAppBanners();
      homeController.getProducts();
    });
  }

  String url() {
    if (Platform.isIOS) {
      // add the [https]
      return "https://wa.me/${appConfigController.modelAppConfig!.whatsapp.toString()}/?text=${Uri.parse("Welcome")}"; // new line
    } else {
      // add the [https]
      return "whatsapp://send?phone=${appConfigController.modelAppConfig!.whatsapp.toString()}=${Uri.parse("Hi")}"; // new line
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: DrawerButton(color: Colors.white,),
        title: const AppText('Home',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18)),
      backgroundColor: AppTheme.primaryColor,
      ),
      body: Obx(() {
        if (homeController.refreshInt.value > 0) {}
        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(0), // Adjust the radius as needed
              child: AnimatedContainer(
                width: context.width,
                height: context.width * .5625,
                duration: 300.milliseconds,
                child: CarouselSlider(
                  options: CarouselOptions(height: context.width * .5625, viewportFraction: 1),
                  items: homeController.bannersList?.map((e) {
                    return AppImageWidget(
                      imageUrl: e.image.toString(),
                      userBaseUrl: true,
                      fit: BoxFit.cover,
                    );
                  }).toList() ??
                      [
                        Container(
                          color: Colors.white,
                          height: context.height,
                          width: context.width,
                        ).makeShimmer
                      ],
                ),
              ),
            ),

            Expanded(
                child: AnimatedSwitcher(
              duration: 300.milliseconds,
              child: RefreshIndicator(
                onRefresh: () {
                  return homeController.getProducts();
                },
                child: GridView.builder(
                    itemCount: homeController.productsList?.length ?? 4,
                    padding: EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      // crossAxisCount: 2,
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 12,
                      mainAxisExtent: (context.width / 2) * 1.2,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (c, i) {
                      if (homeController.productsList == null) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          height: context.height,
                          width: context.width,
                        ).makeShimmer;
                      }
                      final item = homeController.productsList![i];
                      bool selected = homeController.productId == item.id.toString();
                      return GestureDetector(
                        onTap: () {
                          // if (count == null) {
                          homeController.addToCart(item.id.toString());
                          Future.delayed(10.milliseconds).then((v) {
                            Get.to(() => PlacesScreen());
                          });
                          // }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 6)]),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Expanded(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: SizedBox(
                                          width: context.width,
                                          child: AppImageWidget(
                                            imageUrl: item.image.toString(),
                                            userBaseUrl: true,
                                          )))),
                              Gap(4),
                              Column(
                                children: [
                                  Directionality(
                                    textDirection: ui.TextDirection.ltr,
                                    child: AppText(
                                      item.name,
                                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                    ),
                                  ),
                                  Gap(2),
                                  AppText(
                                    item.size ?? "",
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12,color: Colors.grey.withOpacity(0.9)),
                                  ),

                                  AppText(
                                    addCurrency((item.price ?? " ").toString()),
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                  // if (count == null)
                                  // ElevatedButton(
                                  //     onPressed: () {
                                  //       // if (count == null) {
                                  //       homeController.addToCart(item.id.toString());
                                  //       Future.delayed(10.milliseconds).then((v) {
                                  //         Get.to(() => PlacesScreen());
                                  //       });
                                  //       // }
                                  //     },
                                  //     style: ElevatedButton.styleFrom(
                                  //         backgroundColor: AppTheme.primaryColor,
                                  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  //         visualDensity: VisualDensity.compact),
                                  //     child: AppText(
                                  //       selected ? "Added" : "Select",
                                  //       style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                                  //     ))
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ))
          ],
        );
      }),
      floatingActionButton: Obx(() {
        if (appConfigController.refreshInt.value > 0) {}
        return appConfigController.modelAppConfig!.whatsapp != null
            ? IconButton(
                onPressed: () {
                  launchUrlString(url());
                },
                icon: SizedBox(width: 50, height: 50, child: SvgPicture.asset("assets/svgs/whatsapp_icon.svg")))
            : SizedBox();
      }),
    );
  }
}

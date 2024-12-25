import 'dart:async';
import 'dart:developer';
import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
// import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../resources/app_colors.dart';
import '../widgets/app_text.dart';
import 'loader_widget.dart';

class Helper {
  // static Future showLocationPicker(
  //     {required BuildContext context,
  //     required Function(Prediction? place) onPlaceSelected,
  //     Function(PlacesDetailsResponse detail)? onDetails}) async {
  //   Prediction? place = await PlacesAutocomplete.show(
  //       hint: "Search your location",
  //       context: context,
  //       apiKey: ApiUrl.googleApikey,
  //       mode: Mode.fullscreen,
  //       types: [],
  //       strictbounds: false,
  //       onError: (err) {
  //         log("error.....   ${err.errorMessage}");
  //       });
  //   if (place != null) {
  //     log("Got Location......   ${place.toJson()}");
  //     onPlaceSelected(place);
  //     // address = (place.description ?? "Location").toString();
  //     // addressController.text = address!;
  //
  //     // / If Lat long and other details required.....
  //     if (onDetails != null && place.placeId != null) {
  //       final plist = GoogleMapsPlaces(
  //         apiKey: ApiUrl.googleApikey,
  //         apiHeaders: await const GoogleApiHeaders().getHeaders(),
  //       );
  //       String placeId = place.placeId ?? "0";
  //       PlacesDetailsResponse detail = await plist.getDetailsByPlaceId(placeId);
  //       onDetails(detail);
  //       // log("Got detail......   ${detail.toJson()}");
  //       // final geometry = detail.result.geometry!;
  //       // final lat = geometry.location.lat;
  //       // final lang = geometry.location.lng;
  //       // if(mounted)setState(() {
  //       //   address = (place.description ?? "Location").toString();
  //       // });
  //       // }
  //     }
  //   }
  // }

  // static Future<List<File>?> addMultiImagePicker({int imageQuality = 30}) async {
  //   try {
  //     final result = await FilePicker.platform.pickFiles(
  //       allowMultiple: true,
  //       type: FileType.custom,
  //       allowedExtensions: ['jpg', 'png', 'jpeg', 'heic', 'mp4', 'mov', 'hevc'],
  //     );
  //
  //     if (result == null) {
  //       return null;
  //     } else {
  //       List<File> files = result.files.map((file) => File(file.path.toString())).toList();
  //       return files;
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // static Future addImagePicker({ImageSource imageSource = ImageSource.gallery, int imageQuality = 30}) async {
  //   try {
  //     final item = await ImagePicker().pickImage(source: imageSource, imageQuality: imageQuality);
  //     if (item == null) {
  //       return null;
  //     } else {
  //       return File(item.path);
  //     }
  //   } on PlatformException catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // static Future addFilePicker() async {
  //   try {
  //     final item = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['jpg', 'png', 'jpeg'],
  //     );
  //     if (item == null) {
  //       return null;
  //     } else {
  //       // print(item.files.first.bytes!);
  //       return kIsWeb ? item.files.first.bytes! : File(item.files.first.path!);
  //     }
  //   } on PlatformException catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // static Future<File?> addFilePickerMedia({
  //   required Function(File image) gotImage,
  // })
  // async {
  //   try {
  //     final item = await FilePicker.platform.pickFiles(
  //       type: FileType.media,
  //       allowMultiple: true,
  //     );
  //     if (item != null) {
  //       for (var e in item.files) {
  //         if (e.path != null) {
  //           gotImage(File(e.path!));
  //         }
  //       }
  //       return File(item.files.first.path ?? "");
  //     } else {
  //       return null;
  //     }
  //     // if (item == null) {
  //     //   return null;
  //     // } else {
  //     //   print(item.files.first.bytes!);
  //     // return kIsWeb ? item.files.first.bytes! : File(item.files.first.path!);
  //     // }
  //   } on PlatformException catch (e) {
  //     throw Exception(e);
  //   }
  // }

  static OverlayEntry overlayLoader({Color? color, required BuildContext? context}) {
    OverlayEntry loader = OverlayEntry(builder: (c) {
      final size = MediaQuery.of(c).size;
      return Positioned(
        height: size.height,
        width: size.width,
        top: 0,
        left: 0,
        child: LoaderWidget(
          color: color,
        ),
      );
    });
    if (context != null) {
      Future.delayed(GetNumUtils(15).seconds).then((v) {
        log("Hiding Loader..... ");
        hideLoader(loader);
      });
    }
    return loader;
  }

  static hideLoader(OverlayEntry loader) {
    // return;
    Timer(const Duration(milliseconds: 250), () {
      try {
        if (loader.mounted) {
          loader.remove();
        }
        // ignore: empty_catches
      } catch (e) {}
    });
  }

  // static showImagePickerSheet({
  //   required Function(File image) gotImage,
  //   Function(bool image)? removeImage,
  //   required BuildContext context,
  //   String? title,
  //   bool? removeOption,
  //   bool? filePicker,
  // }) {
  //   showCupertinoModalPopup<void>(
  //     context: context,
  //     builder: (BuildContext context) => CupertinoActionSheet(
  //       title: AppText(
  //         title ?? 'Select Image',
  //         style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18, color: AppTheme.primaryColor),
  //       ),
  //       cancelButton: CupertinoActionSheetAction(
  //         child: AppText(
  //           'Cancel',
  //           style: GoogleFonts.poppins(),
  //         ),
  //         onPressed: () {
  //           Navigator.of(context, rootNavigator: true).pop("Cancel");
  //         },
  //       ),
  //       actions: <CupertinoActionSheetAction>[
  //         CupertinoActionSheetAction(
  //           child: AppText(
  //             'Gallery',
  //             style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: AppTheme.primaryColor),
  //           ),
  //           onPressed: () {
  //             // pickImage(
  //             //     ImageSource.gallery);
  //             addImagePicker(imageSource: ImageSource.gallery).then((value) async {
  //               if (value == null) return;
  //               Navigator.pop(context);
  //               gotImage(await FlutterExifRotation.rotateImage(path: value.path));
  //             });
  //           },
  //         ),
  //         CupertinoActionSheetAction(
  //           child: AppText(
  //             'Camera',
  //             style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: AppTheme.primaryColor),
  //           ),
  //           onPressed: () {
  //             addImagePicker(imageSource: ImageSource.camera).then((value) async {
  //               if (value == null) return;
  //               Navigator.pop(context);
  //               gotImage(await FlutterExifRotation.rotateImage(path: value.path));
  //             });
  //           },
  //         ),
  //         if (filePicker == true)
  //           CupertinoActionSheetAction(
  //             child: AppText(
  //               'Files',
  //               style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: AppTheme.primaryColor),
  //             ),
  //             onPressed: () {
  //               addFilePickerMedia(gotImage: (File image) {
  //                 gotImage(image);
  //               }).then((value) {
  //                 if (value == null) return;
  //                 Navigator.pop(context);
  //               });
  //             },
  //           ),
  //         if (removeOption == true)
  //           CupertinoActionSheetAction(
  //             child: AppText(
  //               'Remove',
  //               style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: AppTheme.secondaryColor),
  //             ),
  //             onPressed: () {
  //               Get.back();
  //               if (removeImage != null) {
  //                 removeImage(true);
  //               }
  //             },
  //           ),
  //       ],
  //     ),
  //   );
  // }

  static String? validateEmail(String? v) {
    if (v == null || v.isEmpty) {
      return "Please enter email";
    }
    if (!v.trim().isEmail) {
      return "Please enter valid email";
    }
    return null;
  }

  static String? phoneValidation(String? v) {
    if (v == null || v.isEmpty) {
      return "Please enter phone number";
    }
    if (!v.trim().isPhoneNumber) {
      return "Please enter valid phone number";
    }
    return null;
  }

  static String? emptyValidation(String? v, {required String message}) {
    if (v == null || v.isEmpty) {
      return message;
    }
    return null;
  }
}

showToast(message) {
  if (kReleaseMode && message == null) return;
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.black,
      textColor: AppTheme.primary,
      fontSize: 14);
}

loading() {
  return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
    color: AppTheme.primary,
    size: 40,
  ));
}

extension DateOnlyCompare on DateTime {
  bool isSmallerThen(DateTime other) {
    return (year == other.year && month == other.month && day < other.day) ||
        (year == other.year && month < other.month) ||
        (year < other.year);
  }

  bool get isPreviousDay {
    DateTime now = DateTime.now();
    return DateTime(year, month, day).difference(DateTime(now.year, now.month, now.day)).inDays == -1;
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension ManageHeroes on Widget {
  Widget makeHero(String tag) {
    return Hero(
        tag: tag,
        transitionOnUserGestures: true,
        child: Material(
          color: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          child: this,
        ));
  }
}

String addCurrency(String v) {
  return " ${"BD ".tr}${v.tr}";
}

String subtitle = 'Rrow itself, let it be sorrow let him love it let him pursue it,'
    ' ishing for its acquisitiendum. Because he will a hold uniess but through concer,'
    ' and also of those who resist. Now a pure snore disturbeded';

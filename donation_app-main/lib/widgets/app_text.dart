import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

enum FontFamilyType { poppins, oswald, roboto }

class AppText extends StatelessWidget {
  const AppText(this.text, {super.key, this.style, this.maxLines, this.overflow, this.textAlign, this.fontFamily});
  final dynamic text;
  final String? fontFamily;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  AppText get makeWeight500 {
    TextStyle gg = style ?? const TextStyle();
    gg = gg.copyWith(fontWeight: FontWeight.w500);
    return AppText(text, style: gg, maxLines: maxLines, overflow: overflow, textAlign: textAlign);
  }

  AppText get makeWeight600 {
    TextStyle gg = style ?? const TextStyle();
    gg = gg.copyWith(fontWeight: FontWeight.w600);
    return AppText(text, style: gg, maxLines: maxLines, overflow: overflow, textAlign: textAlign);
  }

  Widget get addCountAnimation {
    return AnimatedFlipCounter(
      wholeDigits: 2,
      duration: 300.milliseconds,
      value: num.tryParse(text) ?? 0,
      fractionDigits: 0,
      textStyle: _getStyle,
    );
  }

  TextStyle get _getStyle {
    return GoogleFonts.poppins(
      // fontFamily ?? "Poppins",
      fontSize: style?.fontSize ?? 14,
      color: style?.color ?? Colors.black,
      backgroundColor: style?.backgroundColor,
      fontWeight: style?.fontWeight ?? FontWeight.w400,
      fontStyle: style?.fontStyle,
      letterSpacing: style?.letterSpacing,
      wordSpacing: style?.wordSpacing,
      textBaseline: style?.textBaseline,
      height: style?.height,
      locale: style?.locale,
      foreground: style?.foreground,
      background: style?.background,
      shadows: style?.shadows,
      fontFeatures: style?.fontFeatures,
      decoration: style?.decoration,
      decorationColor: style?.decorationColor,
      decorationStyle: style?.decorationStyle,
      decorationThickness: style?.decorationThickness,
    );
  }

  makeRich(String text, {TextStyle? style, int? maxLines, TextOverflow? overflow, TextAlign? textAlign}){
    RichText(
      text: const TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'world',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          TextSpan(
            text: '!',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.red),
          ),
        ],
      ),
    );
  }

  static List<String>? richTexts;

  @override
  Widget build(BuildContext context) {
    return Text(text.toString().tr, maxLines: maxLines, overflow: overflow, textAlign: textAlign, style: _getStyle);
  }
}

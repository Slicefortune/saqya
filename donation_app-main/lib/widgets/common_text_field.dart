import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_text.dart';
import 'border_elevation.dart';

DateTime validationTime = DateTime.now();

validationNavigation() {}

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    super.key,
    this.controller,
    this.manageObscureText,
    this.validator,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.labelText,
    this.readOnly,
    this.onTap,
    this.maxLines,
    this.contentPadding,
    this.maxLength,
    this.minLines,
    this.onChanged,
    this.inputFormatters,
    this.enabled,
    this.title,
    this.titleTextStyle,
    this.externalPadding,
  });
  final TextEditingController? controller;
  final bool? manageObscureText;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final EdgeInsets? externalPadding;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final String? hintText;
  final String? title;
  final TextStyle? titleTextStyle;
  final String? labelText;
  final bool? readOnly;
  final bool? enabled;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    if (widget.manageObscureText == true) {
      obscureText = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(widget.externalPadding?.top ?? 0),
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: AppText(
              widget.title!,
              style: widget.titleTextStyle,
            ),
          ),
        TextFormField(
          // key: widget.controller?.getKey,
          expands: false,
          onChanged: widget.onChanged,
          readOnly: widget.readOnly ?? false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: widget.inputFormatters,
          onTap: widget.onTap,
          enabled: widget.enabled,
          minLines: widget.minLines,
          maxLines: widget.maxLines ?? 1,
          maxLength: widget.maxLength,
          controller: widget.controller,
          obscureText: obscureText,
          validator: (v) {
            return widget.validator?.call(v);
          },
          keyboardType: widget.keyboardType,
          cursorColor: Colors.blue,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            counterText: "",
            hintText: widget.hintText,
            errorMaxLines: 2,
            labelText: widget.labelText,
            contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 15),
            hintStyle: TextStyle().copyWith(fontWeight: FontWeight.w400, color: const Color(0xff1C1243), fontSize: 14),
            fillColor: Colors.white,
            labelStyle: TextStyle().copyWith(
              color: const Color(0xff1C1243),
              fontSize: 14,
            ),
            filled: true,
            enabled: true,
            enabledBorder: DecoratedInputBorder(
              child: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.white, width: 1.5),
              ),
              shadow: BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
              ),
            ),
            border: DecoratedInputBorder(
              child: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.white, width: 1.5),
              ),
              shadow: BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
              ),
            ),
            // enabledBorder: OutlineInputBorder(
            //     borderSide: const BorderSide(color: Color(0xffE4E0E0), width: 1.5),
            //     borderRadius: BorderRadius.circular(12)),
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.manageObscureText == true
                ? IconButton(
                    onPressed: () {
                      obscureText = !obscureText;
                      setState(() {});
                    },
                    icon: Icon(obscureText ? Icons.visibility_off_rounded : Icons.visibility_rounded))
                : widget.suffixIcon,
            // suffixIcon: const Icon(
            //   Icons.phone,
            //   size: 26,
            //   color: AppThemes.primaryColor,
            // )
          ),
        ),
      ],
    );
  }
}

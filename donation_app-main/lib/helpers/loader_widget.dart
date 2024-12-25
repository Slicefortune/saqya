import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../resources/app_colors.dart';

class LoaderWidget extends StatefulWidget {
  const LoaderWidget({super.key, this.color});
  final Color? color;

  @override
  State<LoaderWidget> createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.black.withOpacity(.08),
        child: SizedBox(
            height: 35,
            width: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LoadingAnimationWidget.fourRotatingDots(
                  size: 32,
                  color: widget.color ?? AppTheme.primary,
                ).animate().scale().fade()
              ],
            )));
  }
}

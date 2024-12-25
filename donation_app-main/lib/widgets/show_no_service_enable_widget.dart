import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'app_text.dart';

class ShowNoServiceEnableWidget extends StatefulWidget {
  const ShowNoServiceEnableWidget({super.key});

  static Future showLocationDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowNoServiceEnableWidget();
      },
    );
  }

  @override
  State<ShowNoServiceEnableWidget> createState() => _ShowNoServiceEnableWidgetState();
}

class _ShowNoServiceEnableWidgetState extends State<ShowNoServiceEnableWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: AppText("Enable Location Service"),
      content: AppText("Location services are disabled. Please enable them to proceed."),
      actions: <Widget>[
        TextButton(
          child: AppText("Go to Settings"),
          onPressed: () async {
            Navigator.of(context).pop();
            await Geolocator.openLocationSettings().then((v) {}); // Opens location settings
          },
        ),
        TextButton(
          child: AppText("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

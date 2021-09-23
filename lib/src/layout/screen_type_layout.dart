import 'package:flutter/material.dart';
import 'package:ha_firestore_realtime_paginate/src/layout/responsive_builder.dart';
import 'package:ha_firestore_realtime_paginate/src/layout/ui_utils.dart';

class ScreenTypeLayout extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ScreenTypeLayout({Key? key, this.mobile, this.tablet, this.desktop})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          if (tablet != null) {
            return tablet;
          }
        }

        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          if (desktop != null) {
            return desktop;
          } else {
            return tablet ?? mobile;
          }
        }

        return mobile;
      },
    );
  }
}

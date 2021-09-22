import 'package:flutter/material.dart';
import 'package:ha_firestore_paginated_list/layout/responsive_builder.dart';
import 'package:ha_firestore_paginated_list/layout/ui_utils.dart';

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
        if (sizingInformation.deviceScreenType == DeviceScreenType.Tablet) {
          if (tablet != null) {
            return tablet;
          }
        }

        if (sizingInformation.deviceScreenType == DeviceScreenType.Desktop) {
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

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum DeviceScreenType { mobile, tablet, desktop }

DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  double? deviceWidth = mediaQuery.size.shortestSide;

  if (deviceWidth > 950) {
    return DeviceScreenType.desktop;
  }

  if (deviceWidth > 600) {
    return DeviceScreenType.tablet;
  }

  return DeviceScreenType.mobile;
}

const kwSmallCircularProgress = Padding(
  padding: EdgeInsets.symmetric(horizontal: 8),
  child: SizedBox(
      width: 15, height: 15, child: CircularProgressIndicator(strokeWidth: 2)),
);

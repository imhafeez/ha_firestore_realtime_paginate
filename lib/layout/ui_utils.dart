import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum DeviceScreenType { Mobile, Tablet, Desktop }

DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  double? deviceWidth = mediaQuery.size.shortestSide;

  if (deviceWidth > 950) {
    return DeviceScreenType.Desktop;
  }

  if (deviceWidth > 600) {
    return DeviceScreenType.Tablet;
  }

  return DeviceScreenType.Mobile;
}

const kwSmallCircularProgress = Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8),
  child: SizedBox(
      width: 15, height: 15, child: CircularProgressIndicator(strokeWidth: 2)),
);

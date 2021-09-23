import 'package:flutter/material.dart';
import 'package:ha_firestore_realtime_paginate/layout/ui_utils.dart';

class SizingInformation {
  final DeviceScreenType? deviceScreenType;
  final Size? screenSize;
  final Size? localWidgetSize;

  SizingInformation({
    this.deviceScreenType,
    this.screenSize,
    this.localWidgetSize,
  });

  @override
  String toString() {
    return 'DeviceType:$deviceScreenType ScreenSize:$screenSize LocalWidgetSize:$localWidgetSize';
  }
}

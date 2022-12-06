import 'package:flutter/material.dart';

class DeviceDimension {
  static final DeviceDimension _instance = DeviceDimension._internal();

  factory DeviceDimension() => _instance;

  DeviceDimension._internal();

  bool _isInit = true;

  static late final double screenWidth;
  static late final double screenHeight;

  static double get padding => screenWidth * 0.05;

  void initValue(BuildContext context) {
    if (!_isInit) return;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    _isInit = false;
  }
}

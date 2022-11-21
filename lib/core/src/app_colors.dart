import 'package:flutter/material.dart';


class AppColors {
  AppColors._();

  static Color primary = HexColor('#190152');
  static Color white = HexColor("#FFFFFF");
  static Color black = HexColor("#000000");
  static Color blue600  = HexColor('#4285F4');
  static Color primaryBackground = HexColor("FFFFFF");
  static Color secondaryBackground = HexColor("B5C3D4");
  static Color lightGrey = HexColor("D3D3D3");
  static Color grey = HexColor("#747474");
  static Color textLabel = HexColor("#748AA5");
  static Color greyMedium = HexColor("#E1E3E6");
}


class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

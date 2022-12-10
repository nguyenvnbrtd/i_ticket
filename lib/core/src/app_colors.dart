import 'package:flutter/material.dart';


class AppColors {
  AppColors._();

  static Color primary = HexColor('#190152');
  static Color white = HexColor("#FFFFFF");
  static Color black = HexColor("#000000");
  static Color red = HexColor("#ef3327");
  static Color blue500  = HexColor('#4285F4');
  static Color blue600  = HexColor('#3E548D');
  static Color lightGrey = HexColor("D3D3D3");
  static Color grey = HexColor("#747474");
  static Color grey400 = HexColor("#6F6F6F");
  static Color green = HexColor("#3bcd94");
  static Color green400 = HexColor("#4CCB9E");
  static Color greyBlueDark = HexColor("#0b1b32");
  static Color textLabel = HexColor("#748AA5");
  static Color textHint = HexColor("#cccdd4");
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

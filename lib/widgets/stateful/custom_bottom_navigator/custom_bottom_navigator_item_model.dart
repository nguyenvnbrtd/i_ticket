import '../../../core/src/assets.dart';

class CustomBottomNavigatorItemModel {
  final String name;
  final String icon;
  final double iconSize;

  const CustomBottomNavigatorItemModel({this.name = 'none', this.icon = Assets.eyeIcon, this.iconSize = 25});
}
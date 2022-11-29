import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/app_colors.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/widgets/staless/base_tab_widget.dart';
import 'package:flutter_animation/widgets/staless/custom_image.dart';

class UserAvatar extends StatelessWidget {
  final String avatar;

  const UserAvatar({Key? key, this.avatar = ''}) : super(key: key);
  final defaultAvatar = 'https://storage.needpix.com/rsynced_images/avatar-1577909_1280.png';

  @override
  Widget build(BuildContext context) {
    final avatarSize = DeviceDimension.screenWidth * 0.4;
    final String avatarImage = avatar.isNotEmpty ? avatar : defaultAvatar;

    return Stack(
      children: [
        Container(
          width: avatarSize,
          height: avatarSize,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(avatarSize / 2)),
          child: Center(
            child: CustomImage(
              source: avatarImage,
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: BaseTabWidget(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(avatarSize * 0.4),
                color: AppColors.red,
              ),
              child: Icon(Icons.camera_alt_outlined, color: AppColors.white),
            ),
          ),
        ),
      ],
    );
  }
}

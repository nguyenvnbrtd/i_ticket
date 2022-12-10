import 'package:flutter/material.dart';
import 'package:flutter_animation/widgets/staless/bounce_scroll.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/src/app_colors.dart';
import '../../../core/utils/dimension.dart';
import '../../../core/utils/utils_helper.dart';
import '../../../injector.dart';
import '../../../models/user_info.dart';
import '../../../repos/user_repository.dart';
import '../../../widgets/base_screen/origin_screen.dart';
import '../../../widgets/staless/primary_button.dart';
import '../../../widgets/staless/spacer.dart';
import '../../../widgets/stateful/text_input.dart';
import '../blocs/user_info_bloc.dart';
import '../event/user_info_event.dart';
import '../repos/user_info_repository.dart';

class UserInfoUpdate extends StatefulWidget{
  const UserInfoUpdate({Key? key}) : super(key: key);

  @override
  State<UserInfoUpdate> createState() => _UserInfoUpdateState();
}

class _UserInfoUpdateState extends State<UserInfoUpdate> {
  final UserInfoRepository userInfoRepository = it();
  final UserInfoBloc userInfoBloc = UserInfoBloc();

  //text edit controller
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;

  // string
  final String h1 = 'Update Information';
  final String information = 'Information';
  final String name = 'Full name';
  final String nameHint = 'Update your name';
  final String email = 'Email';
  final String emailHint = 'Update your email';
  final String phone = 'Phone number';
  final String phoneHint = 'Update your phone';
  final String address = 'Address';
  final String addressHint = 'Update your Address';
  final String save = 'Continue';
  final String back = 'Back';

  final String termsAndService = 'Terms and Service';

  final termsContent = '''(*) Passenger information must be correct, or else it will
unable to board or cancel/change tickets.

(*) If you have transit needs, please
Contact phone number 1900 **** before booking.

(*) Please come and receive your bus ticket 30 minutes before
departure car.''';

  final lastAlert = 'By continuing to booking, you will accept our terms and services!';

  @override
  void initState() {

    nameController = TextEditingController(text: userInfoRepository.userInfo?.name ?? '');
    phoneController = TextEditingController(text: userInfoRepository.userInfo?.phone ?? '');
    addressController = TextEditingController(text: userInfoRepository.userInfo?.address ?? '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paddingSize = DeviceDimension.screenWidth * 0.05;
    final ThemeData theme = Theme.of(context);

    return BlocProvider(
      create: (_) => userInfoBloc,
      child: OriginScreen(
        child: BounceScroll(
          child: Container(
            height: DeviceDimension.screenHeight * 0.95,
            padding: EdgeInsets.all(paddingSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(information, style: theme.textTheme.headlineLarge),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: DeviceDimension.padding / 2),
                      child: Text(name, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                    ),
                    TextInput(controller: nameController, hint: nameHint, borderWidth: 0.5),
                    const SpaceVertical(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left: DeviceDimension.padding / 2),
                      child: Text(phone, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                    ),
                    TextInput(controller: phoneController, hint: phoneHint, borderWidth: 0.5),
                    const SpaceVertical(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left: DeviceDimension.padding / 2),
                      child: Text(address, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                    ),
                    TextInput(controller: addressController, hint: addressHint, borderWidth: 0.5),
                    const SpaceVertical(height: 10),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(DeviceDimension.padding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(DeviceDimension.padding),
                    border: Border.all(width: 0.5, color: AppColors.primary)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(termsAndService, style: theme.textTheme.headlineSmall),
                      SpaceVertical(height: DeviceDimension.padding / 2),
                      Text(termsContent),
                    ],
                  ),
                ),
                Text(lastAlert, style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.red)),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        label: back,
                        onPress: onBack,
                        color: AppColors.white,
                        textColor: AppColors.primary,
                        borderColor: AppColors.primary,
                      ),
                    ),
                    const SpaceHorizontal(),
                    Expanded(
                      child: PrimaryButton(
                        label: save,
                        onPress: onSave,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSave() {
    userInfoBloc.add(OnAcceptTermsPress(
      userInfo: UserInfo(
        name: nameController.text,
        phone: phoneController.text,
        address: addressController.text,
      ),
    ));
  }

  void onBack() {
    UtilsHelper.pop();
  }
}
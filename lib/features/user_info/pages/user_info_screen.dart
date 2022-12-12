import 'package:flutter/material.dart';
import 'package:flutter_animation/core/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_animation/core/blocs/authentication/authentication_state.dart';
import 'package:flutter_animation/core/src/app_colors.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/features/user_info/blocs/user_info_bloc.dart';
import 'package:flutter_animation/features/user_info/event/user_info_event.dart';
import 'package:flutter_animation/features/user_info/states/user_info_state.dart';
import 'package:flutter_animation/injector.dart';
import 'package:flutter_animation/widgets/base_screen/origin_screen.dart';
import 'package:flutter_animation/widgets/staless/loading_button.dart';
import 'package:flutter_animation/widgets/staless/primary_button.dart';
import 'package:flutter_animation/widgets/staless/spacer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../base/blocs/base_state.dart';
import '../../../core/blocs/authentication/authentication_event.dart';
import '../../../core/utils/utils_helper.dart';
import '../models/user_info.dart';
import '../repos/user_info_repository.dart';
import 'components/user__info_input.dart';
import 'components/user_divider.dart';
import 'widgets/user_avatar.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserInfoScreen();
}

class _UserInfoScreen extends State<UserInfoScreen> {
  final UserInfoRepository userInfoRepository = it();
  final UserInfoBloc userInfoBloc = UserInfoBloc();

  //text edit controller
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;

  // string
  final String profile = 'Profile';
  final String name = 'Full name';
  final String nameHint = 'Update your name';
  final String email = 'Email';
  final String emailHint = 'Update your email';
  final String phone = 'Phone number';
  final String phoneHint = 'Update your phone';
  final String address = 'Address';
  final String addressHint = 'Update your Address';
  final String save = 'Save';
  final String logoutLabel = 'Log out';

  @override
  void initState() {
    final user = userInfoRepository.userInfo;

    nameController = TextEditingController(text: user?.name ?? '');
    emailController = TextEditingController(text: user?.email ?? '');
    phoneController = TextEditingController(text: user?.phone ?? '');
    addressController = TextEditingController(text: user?.address ?? '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final topSize = DeviceDimension.screenHeight * 0.3;
    final padding = DeviceDimension.screenHeight * 0.03;

    return BlocProvider(
      create: (context) => userInfoBloc,
      child: OriginScreen(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: topSize,
                  color: AppColors.greyBlueDark,
                  alignment: Alignment.center,
                  child: UserAvatar(avatar: userInfoRepository.userInfo?.avatar ?? ''),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
                  child: Column(
                    children: [
                      UserInfoInput(title: name, hint: nameHint, controller: nameController, onChanged: onValueChange),
                      const UserDivider(),
                      UserInfoInput(title: email, hint: emailHint, controller: emailController, onChanged: onValueChange),
                      const UserDivider(),
                      UserInfoInput(title: phone, hint: phoneHint, controller: phoneController, onChanged: onValueChange),
                      const UserDivider(),
                      UserInfoInput(title: address, hint: addressHint, controller: addressController, onChanged: onValueChange),
                      const UserDivider(),
                      const SpaceVertical(),
                      BlocBuilder<UserInfoBloc, UserInfoState>(
                        buildWhen: (previous, current) =>
                            previous.isLoading != current.isLoading || previous.isInfoChanged != current.isInfoChanged,
                        builder: (context, state) {
                          return Visibility(
                            visible: state.isInfoChanged,
                            child: LoadingButton(
                              label: save,
                              onPress: onSave,
                              color: AppColors.green,
                              isLoading: state.isLoading,
                            ),
                          );
                        },
                      ),
                      PrimaryButton(
                        onPress: logOut,
                        label: logoutLabel,
                        color: AppColors.white,
                        textColor: AppColors.red,
                        borderColor: AppColors.red,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSave() async {
    UtilsHelper.dismissKeyBoard();
    userInfoBloc.add(
      OnSavePress(
        userInfo: UserInfo(
          name: nameController.text,
          phone: phoneController.text,
          email: emailController.text,
          avatar: '',
          address: addressController.text,
        ),
      ),
    );
  }

  void logOut() {
    context.read<AuthenticationBloc>().add(AuthenticationEventLoggingOut());
  }

  void onValueChange(String value) {
    userInfoBloc.add(OnInfoChanged(changed: true));
  }
}

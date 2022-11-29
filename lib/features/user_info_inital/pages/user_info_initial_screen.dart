import 'package:flutter/material.dart';
import 'package:flutter_animation/features/user_info/blocs/user_info_bloc.dart';
import 'package:flutter_animation/repos/user_repository.dart';
import 'package:flutter_animation/route/page_routes.dart';
import 'package:flutter_animation/widgets/staless/primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/blocs/base_state.dart';
import '../../../core/src/app_colors.dart';
import '../../../core/utils/dimension.dart';
import '../../../core/utils/utils_helper.dart';
import '../../../injector.dart';
import '../../../models/user_info.dart';
import '../../../widgets/base_screen/origin_screen.dart';
import '../../../widgets/staless/base_tab_widget.dart';
import '../../../widgets/staless/loading_button.dart';
import '../../../widgets/staless/spacer.dart';
import '../../../widgets/stateful/text_input.dart';
import '../../user_info/event/user_info_event.dart';
import '../../user_info/repos/user_info_repository.dart';

class UserInfoInitialScreen extends StatefulWidget {
  final String uid;
  final String email;
  
  const UserInfoInitialScreen({Key? key, required this.uid, required this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserInfoInitialScreen();
}

class _UserInfoInitialScreen extends State<UserInfoInitialScreen> {
  final UserInfoRepository userInfoRepository = it();
  final UserRepository userRepository = it();
  final UserInfoBloc userInfoBloc = UserInfoBloc();

  //text edit controller
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;

  // string
  final String h1 = 'Update Profile';
  final String h2 = 'Last step before we start.';
  final String information = 'Information';
  final String name = 'Full name';
  final String nameHint = 'Update your name';
  final String email = 'Email';
  final String emailHint = 'Update your email';
  final String phone = 'Phone number';
  final String phoneHint = 'Update your phone';
  final String address = 'Address';
  final String addressHint = 'Update your Address';
  final String save = 'Save';
  final String notNow = 'Don\' want to update now?\n';
  final String backTo = 'Back to ';
  final String skip = 'Skip to main';

  @override
  void initState() {
    nameController = TextEditingController(text: '');
    emailController = TextEditingController(text: widget.email ?? '');
    phoneController = TextEditingController(text: '');
    addressController = TextEditingController(text: '');

    userInfoBloc.add(OnInitData(userInfo: UserInfo(id: widget.uid, email: widget.email)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paddingSize = DeviceDimension.screenWidth * 0.05;
    final ThemeData theme = Theme.of(context);

    return BlocProvider(
      create: (_) => userInfoBloc,
      child: OriginScreen(
        child: Padding(
          padding: EdgeInsets.all(paddingSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(h1, style: theme.textTheme.headlineSmall),
                        const SpaceHorizontal(width: 10),
                        const Icon(Icons.person_outline_rounded),
                      ],
                    ),
                    const SpaceVertical(height: 10),
                    Text(h2, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
              const SizedBox(),
              const SizedBox(),
              Text(information, style: theme.textTheme.headlineLarge),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextInput(controller: nameController, hint: nameHint, borderWidth: 0.5),
                  const SpaceVertical(height: 10),
                  TextInput(controller: phoneController, hint: phoneHint, borderWidth: 0.5),
                  const SpaceVertical(height: 10),
                  TextInput(controller: emailController, hint: emailHint, borderWidth: 0.5),
                  const SpaceVertical(height: 10),
                  TextInput(controller: addressController, hint: addressHint, borderWidth: 0.5),
                  const SpaceVertical(height: 10),
                ],
              ),
              PrimaryButton(
                label: save,
                onPress: onSave,
                color: AppColors.green,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingSize * 2),
                child: BaseTabWidget(
                  onTap: loginNow,
                  child: RichText(
                    textAlign: TextAlign.center,
                    softWrap: true,
                    maxLines: 2,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: notNow,
                          style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                        ),
                        TextSpan(
                          text: skip,
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void loginNow() async {
    final user = await userRepository.getUser();
    if(user == null) return;
    UtilsHelper.login(user.uid);
  }

  void updateData(){
    userInfoBloc.add(OnSavePress(
      userInfo: UserInfo(
        name: nameController.text,
        phone: phoneController.text,
        email: emailController.text,
        avatar: '',
        address: addressController.text,
      ),
    ));
  }

  void onSave() {
    UtilsHelper.dismissKeyBoard();
    updateData();
    loginNow();
  }
}

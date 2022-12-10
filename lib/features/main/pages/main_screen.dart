import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/assets.dart';
import 'package:flutter_animation/features/home/pages/home_screen.dart';
import 'package:flutter_animation/features/travel_route/pages/travel_route_screen.dart';
import 'package:flutter_animation/features/user_info/pages/user_info_screen.dart';
import 'package:flutter_animation/widgets/base_screen/origin_screen.dart';
import 'package:flutter_animation/widgets/stateful/custom_bottom_navigator/custom_bottom_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/blocs/authentication/authentication_bloc.dart';
import '../../../core/blocs/authentication/authentication_event.dart';
import '../../../widgets/stateful/custom_bottom_navigator/custom_bottom_navigator_item_model.dart';
import '../../../widgets/stateful/custom_bottom_navigator/navigate_indicator_cubit.dart';
import '../../booking/pages/booking_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  late final List<Widget> screens;
  late final navigateIndicator = NavigateIndicatorCubit(initValue: 0);

  @override
  void initState() {

    screens = [
      const HomeScreen(),
      const TravelRouteScreen(),
      const BookingScreen(),
      const UserInfoScreen(),
      Container(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigateIndicatorCubit>(
      create: (context) => navigateIndicator,
      child: OriginScreen(
        onBackPress: logOut,
        bottomNavigator: BlocBuilder<NavigateIndicatorCubit, int>(
          builder: (context, state) {
            return CustomBottomNavigator(
              height: 60,
              items: const [
                CustomBottomNavigatorItemModel(name: 'Home', icon: Assets.homeIcon, iconSize: 20),
                CustomBottomNavigatorItemModel(name: 'Route', icon: Assets.routeIcon, iconSize: 20),
                CustomBottomNavigatorItemModel(name: 'Booking', icon: Assets.bookingIcon, iconSize: 20),
                CustomBottomNavigatorItemModel(name: 'User', icon: Assets.userIcon, iconSize: 20),
                CustomBottomNavigatorItemModel(name: 'Setting', icon: Assets.settingIcon, iconSize: 20),
              ],
              onSelectedChange: onSelectedScreenChange,
              selectedIndex: state,
            );
          },
        ),
        child: BlocBuilder<NavigateIndicatorCubit, int>(
          builder: (context, state) => IndexedStack(
            index: state,
            children: screens,
          ),
        ),
      ),
    );
  }

  void onSelectedScreenChange(int index) {
    if(navigateIndicator.state == index) return;
    navigateIndicator.changeToIndex(index: index);
  }

  Future<bool> logOut() async {
    context.read<AuthenticationBloc>().add(AuthenticationEventLoggingOut());
    return false;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/assets.dart';
import 'package:flutter_animation/features/home/pages/home_screen.dart';
import 'package:flutter_animation/features/travel_route/pages/travel_route_screen.dart';
import 'package:flutter_animation/features/user_info/pages/user_info_screen.dart';
import 'package:flutter_animation/features/user_info/repos/user_info_repository.dart';
import 'package:flutter_animation/widgets/base_screen/origin_screen.dart';
import 'package:flutter_animation/widgets/stateful/custom_bottom_navigator/custom_bottom_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/blocs/authentication/authentication_bloc.dart';
import '../../../core/blocs/authentication/authentication_event.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/utils_helper.dart';
import '../../../injector.dart';
import '../../../widgets/stateful/custom_bottom_navigator/custom_bottom_navigator_item_model.dart';
import '../../../widgets/stateful/custom_bottom_navigator/navigate_indicator_cubit.dart';
import '../../booking/pages/booking_screen.dart';
import '../../history/pages/history_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  late final List<Widget> screens;
  late final navigateIndicator = NavigateIndicatorCubit(initValue: 0);
  late final List<CustomBottomNavigatorItemModel> bottomNaviItems;

  @override
  void initState() {

    if((it<UserInfoRepository>().userInfo?.role ?? Constants.ROLE_NORMAL) == Constants.ROLE_ADMIN){
      screens = [
        // const HomeScreen(),
        const TravelRouteScreen(),
        const UserInfoScreen(),
      ];
      bottomNaviItems = const [
        // CustomBottomNavigatorItemModel(name: 'Home', icon: Assets.homeIcon, iconSize: 20),
        CustomBottomNavigatorItemModel(name: 'Route', icon: Assets.routeIcon, iconSize: 20),
        CustomBottomNavigatorItemModel(name: 'User', icon: Assets.userIcon, iconSize: 20),
      ];
    }else{
      screens = [
        // const HomeScreen(),
        const BookingScreen(),
        const UserInfoScreen(),
        const HistoryScreen(),
      ];

      bottomNaviItems = const [
        // CustomBottomNavigatorItemModel(name: 'Home', icon: Assets.homeIcon, iconSize: 20),
        CustomBottomNavigatorItemModel(name: 'Booking', icon: Assets.bookingIcon, iconSize: 20),
        CustomBottomNavigatorItemModel(name: 'User', icon: Assets.userIcon, iconSize: 20),
        CustomBottomNavigatorItemModel(name: 'History', icon: Assets.historyIcon, iconSize: 22),
      ];
    }


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
              items: bottomNaviItems,
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
    UtilsHelper.logout();
    return false;
  }
}

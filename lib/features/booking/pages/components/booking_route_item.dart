import 'package:flutter/material.dart';
import 'package:flutter_animation/core/utils/constants.dart';
import 'package:flutter_animation/core/utils/dialog_utils.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/features/travel_route/models/travle_route.dart';
import 'package:flutter_animation/features/travel_route/pages/components/travel_route_item.dart';
import 'package:flutter_animation/features/user_info/repos/user_info_repository.dart';
import 'package:flutter_animation/route/page_routes.dart';
import 'package:flutter_animation/widgets/staless/primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/src/app_colors.dart';
import '../../../../core/utils/dimension.dart';
import '../../../../injector.dart';
import '../../../../models/navigator_agruments/payment_argument.dart';
import '../../../../widgets/stateful/expand_widget.dart';
import '../../../travel_route/models/item_selected.dart';
import '../../../travel_route/pages/widgets/seats_status.dart';
import '../../../travel_route/repos/travel_route_repository.dart';
import '../../blocs/booking_cubit.dart';
import '../../states/booking_state.dart';

class BookingRouteItem extends TravelRouteItem {
  const BookingRouteItem({Key? key, required TravelRoute item}) : super(key: key, item: item);

  @override
  TravelRouteItemState createState() => _BookingRouteItemState();
}

class _BookingRouteItemState extends TravelRouteItemState with WidgetsBindingObserver{
  final String conti = 'Continue';

  late final BookingCubit bookingBloc;

  @override
  void initState() {
    bookingBloc = BookingCubit(widget.item);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    bookingBloc.clearTempTicket();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(AppLifecycleState.paused == state){
      bookingBloc.clearTempTicket();
    }if(AppLifecycleState.resumed == state){
      bookingBloc.tempTicket();
    }
  }

  @override
  Widget build(BuildContext context) {
    bookingBloc.onRefreshData(widget.item.seats ?? []);

    return BlocProvider(
      create: (_) => bookingBloc,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(DeviceDimension.padding),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4.5),
              color: AppColors.lightGrey.withOpacity(0.8),
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ],
        ),
        child: buildContent(context),
      ),
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500);

    return ExpandWidget(
      main: Padding(
        padding: EdgeInsets.all(DeviceDimension.padding),
        child: super.buildContent(context),
      ),
      child: Column(
        children: [
          SeatsStatus(
            travelRoute: widget.item,
            booking: true,
            onItemTab: bookingBloc.onItemTab,
          ),
          Padding(
            padding: EdgeInsets.all(DeviceDimension.padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BlocBuilder<BookingCubit, BookingState>(
                    buildWhen: (previous, current) => previous.selectedIndexs != current.selectedIndexs,
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${state.selectedIndexs.length} tickets', style: text),
                          Text(
                            'Price: ${UtilsHelper.formatMoney(state.selectedIndexs.length * (widget.item.price ?? 0))} ${Constants.PRICE_TYPE}',
                            style: text,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                BlocBuilder<BookingCubit, BookingState>(
                  buildWhen: (previous, current) => previous.selectedIndexs.isEmpty != current.selectedIndexs.isEmpty,
                  builder: (context, state) {
                    return Visibility(
                      visible: state.selectedIndexs.isNotEmpty,
                      child: PrimaryButton(
                        onPress: continueTab,
                        label: conti,
                        color: AppColors.primary,
                        borderRadius: DeviceDimension.screenWidth * 0.1,
                        width: DeviceDimension.screenWidth * 0.3,
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget buildAction(BuildContext context) {
    return Container();
  }

  @override
  Widget buildEmptySeatsNumber(BuildContext context) {
    final theme =Theme.of(context);

    int empty = 0;
    for(String item in widget.item.seats ?? []){
      if(item.isEmpty){
        empty ++;
      }
    }

    return Container(
      margin: EdgeInsets.only(top: DeviceDimension.padding / 2),
      padding: EdgeInsets.symmetric(horizontal: paddingSize / 1.5, vertical: paddingSize / 3),
      decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(paddingSize)),
      child: Text('$empty seats left', style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.grey)),
    );
  }

  void continueTab() async {
    if(it<UserInfoRepository>().userInfo?.acceptTerms ?? false){
      bookingBloc.tempTicket();
      gotoPayment();
    }else{
      bookingBloc.tempTicket();
      await UtilsHelper.pushNamed(Routes.userInfoUpdate);
      if(it<UserInfoRepository>().userInfo?.acceptTerms ?? false){
        gotoPayment();
      }else{
        bookingBloc.clearTempTicket();
      }
    }
  }

  void gotoPayment() async {
    await UtilsHelper.pushNamed(Routes.payment, PaymentArgument(bookingBloc));
    bookingBloc.clearTempTicket();
  }
}

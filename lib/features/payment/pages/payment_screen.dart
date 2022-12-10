import 'package:flutter/material.dart';
import 'package:flutter_animation/core/utils/constants.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/features/booking/states/booking_state.dart';
import 'package:flutter_animation/features/user_info/repos/user_info_repository.dart';
import 'package:flutter_animation/widgets/base_screen/origin_screen.dart';
import 'package:flutter_animation/widgets/staless/bounce_scroll.dart';
import 'package:flutter_animation/widgets/staless/loading_button.dart';
import 'package:flutter_animation/widgets/staless/main_label.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/src/app_colors.dart';
import '../../../injector.dart';
import '../../../widgets/staless/primary_button.dart';
import '../../../widgets/staless/spacer.dart';
import '../../../widgets/stateful/filter_item_list.dart';
import '../../booking/blocs/booking_cubit.dart';

class PaymentScreen extends StatefulWidget {
  final BookingCubit bookingCubit;

  const PaymentScreen({Key? key, required this.bookingCubit}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final UserInfoRepository userInfoRepository = it();

  final String payment = 'Payment';
  final String paymentInfo = 'Payment information';
  final String customerInfo = 'Customer information';
  final String routeInfo = 'Route information';
  final String total = 'Total';
  final String choose = 'Choose a payment method';
  final radioButtonType = 'PaymentType';
  final paymentTypes = ['Cash', 'Momo', 'ZaloPay', 'VNPay', 'ShopeePay'];

  String booking = 'Booking';
  String back = 'Back';

  String defaultPayMethod = 'Cash';
  String payMethod = 'Cash';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = userInfoRepository.userInfo?.name ?? '';
    final phone = userInfoRepository.userInfo?.phone ?? '';
    final email = userInfoRepository.userInfo?.email ?? '';
    final address = userInfoRepository.userInfo?.address ?? '';

    final routeName = widget.bookingCubit.travelRoute.name ?? '';
    final routeTime = widget.bookingCubit.travelRoute.departureTime ?? '';
    final numOfSeats = widget.bookingCubit.state.selectedIndexs.length.toString();
    final seats = widget.bookingCubit.state.selectedIndexs.map((e) => UtilsHelper.getSeatName(e)).join(', ');
    final licensePlate = widget.bookingCubit.travelRoute.licensePlate ?? '';
    final double totalPrice = widget.bookingCubit.state.selectedIndexs.length * (widget.bookingCubit.travelRoute.price ?? 0);

    return BlocProvider(
      create: (context) => widget.bookingCubit,
      child: OriginScreen(
        child: BounceScroll(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(DeviceDimension.padding),
                child: MainLabel(label: payment, alignment: MainAxisAlignment.start),
              ),
              const SpaceVertical(),
              Container(
                width: DeviceDimension.screenWidth,
                color: AppColors.primary,
                alignment: Alignment.center,
                padding: EdgeInsets.all(DeviceDimension.padding),
                child: Text(paymentInfo, style: theme.textTheme.headlineSmall?.copyWith(color: AppColors.white)),
              ),
              PaymentInfo(
                label: customerInfo,
                contents: [
                  PaymentInfoItem(label: 'Name', content: name),
                  PaymentInfoItem(label: 'Phone', content: phone),
                  PaymentInfoItem(label: 'Email', content: email),
                  PaymentInfoItem(label: 'Address', content: address),
                ],
              ),
              PaymentInfo(
                label: paymentInfo,
                contents: [
                  PaymentInfoItem(label: 'Route', content: routeName),
                  PaymentInfoItem(label: 'Time', content: routeTime),
                  PaymentInfoItem(label: 'Num of seats', content: numOfSeats),
                  PaymentInfoItem(label: 'Seats', content: seats),
                  PaymentInfoItem(label: 'License plate', content: licensePlate),
                ],
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: DeviceDimension.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(total, style: theme.textTheme.bodyLarge),
                    Text(
                      '${UtilsHelper.formatMoney(totalPrice)} ${Constants.PRICE_TYPE}',
                      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500, color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: DeviceDimension.padding),
                child: Column(
                  children: [
                    Text(choose, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 18)),
                    SpaceVertical(height: DeviceDimension.padding * 0.5),
                    FilterSearchList<String>(
                      items: paymentTypes,
                      onSelectedChange: (value) {
                        payMethod = value;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: DeviceDimension.padding),
                child: Row(
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
                      child: BlocBuilder<BookingCubit, BookingState>(
                        buildWhen: (previous, current) => previous.isLoading != current.isLoading,
                        builder: (context, state) {
                          return LoadingButton(
                            isLoading: state.isLoading,
                            label: booking,
                            onPress: onSave,
                            color: AppColors.primary,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void onSave() {
    widget.bookingCubit.bookTicket(payMethod != defaultPayMethod);
  }

  void onBack() {
    UtilsHelper.pop();
  }
}

class PaymentInfo extends StatelessWidget {
  final String label;
  final List<PaymentInfoItem> contents;

  const PaymentInfo({Key? key, required this.label, required this.contents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          width: DeviceDimension.screenWidth,
          padding: EdgeInsets.all(DeviceDimension.padding),
          color: AppColors.greyMedium,
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(DeviceDimension.padding),
          child: Column(
            children: contents,
          ),
        ),
      ],
    );
  }
}

class PaymentInfoItem extends StatelessWidget {
  final String label;
  final String content;

  const PaymentInfoItem({Key? key, required this.label, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('$label:', style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.grey400, height: 1.4)),
          ),
        ),
        Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: Text(content))),
      ],
    );
  }
}

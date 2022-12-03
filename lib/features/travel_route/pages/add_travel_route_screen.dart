import 'package:flutter/material.dart';
import 'package:flutter_animation/base/blocs/base_state.dart';
import 'package:flutter_animation/core/src/app_colors.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/features/travel_route/blocs/travel_route_bloc.dart';
import 'package:flutter_animation/features/travel_route/event/travel_route_event.dart';
import 'package:flutter_animation/features/travel_route/states/travel_route_state.dart';
import 'package:flutter_animation/widgets/base_screen/origin_screen.dart';
import 'package:flutter_animation/widgets/staless/loading_button.dart';
import 'package:flutter_animation/widgets/staless/primary_button.dart';
import 'package:flutter_animation/widgets/staless/spacer.dart';
import 'package:flutter_animation/widgets/stateful/text_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../../core/utils/unique_id_generator.dart';
import '../../../widgets/staless/bounce_scroll.dart';
import '../../../widgets/staless/primary_app_bar.dart';
import '../models/travle_route.dart';

class AddTravelRouteScreen extends StatefulWidget {
  const AddTravelRouteScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddTravelRouteScreen();
}

class _AddTravelRouteScreen extends State<AddTravelRouteScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _departureController;
  late final TextEditingController _destinationController;
  late final TextEditingController _licensePlatesController;
  late final TextEditingController _distanceController;

  late final TravelRouteBloc travelRouteBloc;

  final String title = 'Add Route';
  final String nameHint = 'Name';
  final String departureHint = 'Departure';
  final String destinationHint = 'Destination';
  final String licenseHint = 'License Plates';
  final String timeMovingHint = 'Time Moving';
  final String departureTimeHint = 'Departure Time';
  final String destinationTimeHint = 'Destination Time';
  final String _distanceHint = 'Distance (km)';
  final String addLabel = 'Add';

  @override
  void initState() {
    _nameController = TextEditingController();
    _departureController = TextEditingController();
    _destinationController = TextEditingController();
    _licensePlatesController = TextEditingController();
    _distanceController = TextEditingController();

    travelRouteBloc = TravelRouteBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paddingSize = DeviceDimension.screenWidth * 0.05;
    final ThemeData theme = Theme.of(context);

    return BlocProvider(
      create: (_) => travelRouteBloc,
      child: OriginScreen(
        appbar: const PrimaryAppBar(),
        child: BounceScroll(
          child: Container(
            height: DeviceDimension.screenHeight - (50 + paddingSize*2),
            padding: EdgeInsets.all(paddingSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(),
                Text(title, style: theme.textTheme.headlineLarge),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextInput(controller: _nameController, hint: nameHint, borderWidth: 0.5),
                    const SpaceVertical(height: 10),
                    TextInput(controller: _departureController, hint: departureHint, borderWidth: 0.5),
                    const SpaceVertical(height: 10),
                    TextInput(controller: _destinationController, hint: destinationHint, borderWidth: 0.5),
                    const SpaceVertical(height: 10),
                    TextInput(controller: _licensePlatesController, hint: licenseHint, borderWidth: 0.5),
                    const SpaceVertical(height: 10),
                    TextInput(controller: _distanceController, hint: _distanceHint, borderWidth: 0.5),
                    const SpaceVertical(height: 10),
                    BlocBuilder<TravelRouteBloc, TravelRouteState>(
                      buildWhen: (previous, current) => previous.departureTime != current.departureTime,
                      builder: (context, state) {
                        final text = state.departureTime.isNotEmpty ? state.departureTime : departureTimeHint;
                        final color = state.departureTime.isNotEmpty ? AppColors.textLabel : AppColors.greyMedium;
                        return PrimaryButton(
                          borderWidth: 0.5,
                          color: AppColors.white,
                          borderColor: AppColors.primary,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              text,
                              style: theme.textTheme.bodyMedium?.copyWith(color: color),
                            ),
                          ),
                          onPress: openSelectDepartureTime,
                        );
                      },
                    ),
                    const SpaceVertical(height: 10),
                    BlocBuilder<TravelRouteBloc, TravelRouteState>(
                      buildWhen: (previous, current) => previous.destinationTime != current.destinationTime,
                      builder: (context, state) {
                        final text = state.destinationTime.isNotEmpty ? state.destinationTime : destinationTimeHint;
                        final color = state.destinationTime.isNotEmpty ? AppColors.textLabel : AppColors.greyMedium;

                        return PrimaryButton(
                          borderWidth: 0.5,
                          color: AppColors.white,
                          borderColor: AppColors.primary,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              text,
                              style: theme.textTheme.bodyMedium?.copyWith(color: color),
                            ),
                          ),
                          onPress: openSelectDestinationTime,
                        );
                      },
                    ),
                  ],
                ),
                BlocBuilder<TravelRouteBloc, BaseState>(
                  builder: (context, state) => SizedBox(
                    height: 55,
                    child: LoadingButton(
                      label: addLabel,
                      onPress: onAddRoute,
                      isLoading: state.isLoading,
                    ),
                  ),
                ),
                const SpaceVertical(height: 10),
                const SpaceVertical(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  openSelectDepartureTime() {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (date) {
        travelRouteBloc.add(OnChangeDepartureTime(time: date));
      },
      currentTime: DateTime.now(),
      locale: LocaleType.vi,
    );
  }

  openSelectDestinationTime() {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (date) {
        travelRouteBloc.add(OnChangeDestinationTime(time: date));
      },
      currentTime: DateTime.now(),
      locale: LocaleType.vi,
    );
  }

  onAddRoute() {
    travelRouteBloc.add(
      OnAddNewRoute(
        route: TravelRoute(
          id: UniqueIdGenerator.uniqueId,
          name: _nameController.text,
          departureName: _departureController.text,
          destinationName: _destinationController.text,
          departureTime: travelRouteBloc.state.departureTime,
          destinationTime: travelRouteBloc.state.destinationTime,
          distance: _distanceController.text,
          licensePlate: _licensePlatesController.text,
        ),
      ),
    );
  }
}

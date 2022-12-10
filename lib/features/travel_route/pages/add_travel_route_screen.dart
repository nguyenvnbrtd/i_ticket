import 'package:flutter/material.dart';
import 'package:flutter_animation/base/blocs/base_state.dart';
import 'package:flutter_animation/core/src/app_colors.dart';
import 'package:flutter_animation/core/utils/constants.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
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
  final String id;

  const AddTravelRouteScreen({Key? key, this.id = ''}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddTravelRouteScreen();
}

class _AddTravelRouteScreen extends State<AddTravelRouteScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _departureController;
  late final TextEditingController _destinationController;
  late final TextEditingController _licensePlatesController;
  late final TextEditingController _distanceController;
  late final TextEditingController _priceController;

  late final TravelRouteBloc travelRouteBloc;

  final String title = 'Add Route';
  final String title2 = 'Update Route';
  final String nameHint = 'Name';
  final String departureHint = 'Departure';
  final String destinationHint = 'Destination';
  final String licenseHint = 'License Plates';
  final String timeMovingHint = 'Time Moving';
  final String departureTimeHint = 'Departure Time';
  final String destinationTimeHint = 'Destination Time';
  final String distanceHint = 'Distance (km)';
  final String priceHint = 'Price (${Constants.PRICE_TYPE})';
  final String addLabel = 'Add';
  final String updateLabel = 'Update';

  @override
  void initState() {
    intiData();

    super.initState();
  }


  void intiData() async {

    travelRouteBloc = TravelRouteBloc();

    _nameController = TextEditingController();
    _departureController = TextEditingController();
    _destinationController = TextEditingController();
    _licensePlatesController = TextEditingController();
    _distanceController = TextEditingController();
    _priceController = TextEditingController();

    if(widget.id.isNotEmpty){
      travelRouteBloc.add(OnInitRoute(id: widget.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final paddingSize = DeviceDimension.screenWidth * 0.05;
    final ThemeData theme = Theme.of(context);

    return BlocProvider(
      create: (_) => travelRouteBloc,
      child: OriginScreen(
        appbar: const PrimaryAppBar(),
        child: BlocBuilder<TravelRouteBloc, TravelRouteState>(
          buildWhen: (previous, current) => previous.route.id != current.route.id,
          builder: (context, state) {
            if(state.isInitData){
              return const Center(child: CircularProgressIndicator());
            }

            _nameController.text = state.route.name ?? '';
            _departureController.text = state.route.departureName?? '';
            _destinationController.text = state.route.destinationName ?? '';
            _licensePlatesController.text = state.route.licensePlate ?? '';
            _distanceController.text = state.route.distance ?? '';
            _priceController.text = (state.route.price ?? '').toString();

            return BounceScroll(
              child: Container(
                height: DeviceDimension.screenHeight - (50 + paddingSize*2),
                padding: EdgeInsets.all(paddingSize),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(),
                    Text(widget.id.isEmpty ? title : title2, style: theme.textTheme.headlineLarge),
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
                        TextInput(controller: _distanceController, hint: distanceHint, borderWidth: 0.5),
                        const SpaceVertical(height: 10),
                        TextInput(controller: _priceController, hint: priceHint, borderWidth: 0.5, keyboardType: TextInputType.number),
                        const SpaceVertical(height: 10),
                        BlocBuilder<TravelRouteBloc, TravelRouteState>(
                          buildWhen: (previous, current) => previous.route.departureTime != current.route.departureTime,
                          builder: (context, state) {
                            final text = (state.route.departureTime ?? '').isNotEmpty ? state.route.departureTime : departureTimeHint;
                            final color = (state.route.departureTime ?? '').isNotEmpty ? AppColors.textLabel : AppColors.greyMedium;
                            return PrimaryButton(
                              borderWidth: 0.5,
                              color: AppColors.white,
                              borderColor: AppColors.primary,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  text!,
                                  style: theme.textTheme.bodyMedium?.copyWith(color: color),
                                ),
                              ),
                              onPress: openSelectDepartureTime,
                            );
                          },
                        ),
                        const SpaceVertical(height: 10),
                        BlocBuilder<TravelRouteBloc, TravelRouteState>(
                          buildWhen: (previous, current) => previous.route.destinationTime != current.route.destinationTime,
                          builder: (context, state) {
                            final text = (state.route.destinationTime ?? '').isNotEmpty ? state.route.destinationTime : destinationTimeHint;
                            final color = (state.route.destinationTime ?? '').isNotEmpty ? AppColors.textLabel : AppColors.greyMedium;

                            return PrimaryButton(
                              borderWidth: 0.5,
                              color: AppColors.white,
                              borderColor: AppColors.primary,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  text!,
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
                          label: widget.id.isEmpty ? addLabel : updateLabel,
                          onPress: onMainPress,
                          isLoading: state.isLoading,
                        ),
                      ),
                    ),
                    const SpaceVertical(height: 10),
                    const SpaceVertical(height: 10),
                  ],
                ),
              ),
            );
          },
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

  onMainPress(){
    if(widget.id.isEmpty){
      createRoute();
    }else{
      updateRoute();
    }
  }

  createRoute() {
    travelRouteBloc.add(
      OnAddNewRoute(
        route: TravelRoute(
          id: UniqueIdGenerator.uniqueId,
          name: _nameController.text,
          departureName: _departureController.text,
          destinationName: _destinationController.text,
          distance: _distanceController.text,
          licensePlate: _licensePlatesController.text,
          price: double.tryParse(_priceController.text),
        ),
      ),
    );
  }

  updateRoute() {
    travelRouteBloc.add(
      OnUpdateRoute(
        id: widget.id,
        route: TravelRoute(
          id: widget.id,
          name: _nameController.text,
          departureName: _departureController.text,
          destinationName: _destinationController.text,
          distance: _distanceController.text,
          licensePlate: _licensePlatesController.text,
          price: double.tryParse(_priceController.text),
        ),
      ),
    );
  }
}

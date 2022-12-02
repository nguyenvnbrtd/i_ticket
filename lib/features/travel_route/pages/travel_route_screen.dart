import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/assets.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/features/travel_route/event/travel_route_event.dart';
import 'package:flutter_animation/features/travel_route/models/travle_route.dart';
import 'package:flutter_animation/widgets/base_screen/origin_screen.dart';
import 'package:flutter_animation/widgets/staless/spacer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/utils/unique_id_generator.dart';
import '../../../widgets/staless/main_label.dart';
import '../blocs/travel_route_bloc.dart';
import 'components/travel_route_item.dart';

class TravelRouteScreen extends StatefulWidget {
  const TravelRouteScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TravelRouteScreen();
}

class _TravelRouteScreen extends State<TravelRouteScreen> {
  final routeManagement = 'Route Management';
  late final TravelRouteBloc travelRouteBloc;

  @override
  void initState() {
    travelRouteBloc = TravelRouteBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paddingSize = DeviceDimension.screenWidth * 0.05;

    return BlocProvider(
      create: (context) => travelRouteBloc,
      child: OriginScreen(
        child: Column(
          children: [
            SpaceVertical(height: paddingSize,),
            Padding(
              padding: EdgeInsets.all(paddingSize),
              child: MainLabel(
                label: routeManagement,
                alignment: MainAxisAlignment.spaceBetween,
                rightIcon: Assets.plusCircleIcon,
                rightAction: onAddRoute,
              ),
            ),
            Expanded(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(),
                padding: EdgeInsets.all(paddingSize),
                child: StreamBuilder<List<TravelRoute>>(
                  stream: travelRouteBloc.routes,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? [];

                    return ListView.separated(
                      clipBehavior: Clip.none,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return SpaceVertical(height: paddingSize);
                      },
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return TravelRouteItem(item: data[index],);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onAddRoute() {
    travelRouteBloc.add(OnAddNewRoute(route: TravelRoute(id: UniqueIdGenerator.uniqueId)));
    Fluttertoast.showToast(msg: 'Add success');
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/assets.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/features/travel_route/models/travle_route.dart';
import 'package:flutter_animation/route/page_routes.dart';
import 'package:flutter_animation/widgets/base_screen/origin_screen.dart';
import 'package:flutter_animation/widgets/staless/spacer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/dialog_utils.dart';
import '../../../widgets/staless/empty_widget.dart';
import '../../../widgets/staless/main_label.dart';
import '../blocs/travel_route_bloc.dart';
import 'components/travel_route_item.dart';
import 'widgets/seats_status.dart';

class TravelRouteScreen extends StatefulWidget {
  const TravelRouteScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TravelRouteScreenState();
}

class TravelRouteScreenState extends State<TravelRouteScreen> {
  late final TravelRouteBloc travelRouteBloc;

  String get title => 'Route Management';

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
            SpaceVertical(
              height: paddingSize,
            ),
            Padding(
              padding: EdgeInsets.all(paddingSize),
              child: buildHeader(),
            ),
            Expanded(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(),
                padding: EdgeInsets.all(paddingSize).copyWith(top: 0),
                child: StreamBuilder<List<TravelRoute>>(
                  stream: travelRouteBloc.routes,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? [];

                    if(data.isEmpty){
                      return const EmptyWidget();
                    }

                    return ListView.separated(
                      clipBehavior: Clip.none,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return SpaceVertical(height: paddingSize);
                      },
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return buildItem(data[index]);
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
    UtilsHelper.pushNamed(Routes.addTravelRoute);
  }

  Widget buildHeader() {
    return MainLabel(
      label: title,
      alignment: MainAxisAlignment.spaceBetween,
      rightIcon: Assets.plusCircleIcon,
      rightAction: onAddRoute,
    );
  }

  Widget buildItem(TravelRoute item) {
    return TravelRouteItem(
      item: item,
      onTab: (value) {
        DialogUtils.showBottomSheetDialog(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(DeviceDimension.padding),
                child: SeatsStatus(travelRoute: item, onItemTab: (value) {},),
              ),
            ],
          ),
        );
      },
    );
  }
}

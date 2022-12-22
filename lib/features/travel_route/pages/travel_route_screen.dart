import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/assets.dart';
import 'package:flutter_animation/core/utils/debounce.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/core/utils/utils_helper.dart';
import 'package:flutter_animation/features/travel_route/event/travel_route_event.dart';
import 'package:flutter_animation/features/travel_route/models/travle_route.dart';
import 'package:flutter_animation/features/travel_route/states/travel_route_state.dart';
import 'package:flutter_animation/route/page_routes.dart';
import 'package:flutter_animation/widgets/base_screen/origin_screen.dart';
import 'package:flutter_animation/widgets/staless/spacer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/dialog_utils.dart';
import '../../../widgets/staless/empty_widget.dart';
import '../../../widgets/staless/main_label.dart';
import '../../../widgets/staless/search_bar.dart';
import '../../../widgets/staless/search_empty_widget.dart';
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
            SpaceVertical(height: paddingSize),
            Padding(padding: EdgeInsets.all(paddingSize), child: buildHeader()),
            SearchBar(onChange: onSearching),
            SpaceVertical(height: paddingSize / 2),
            Expanded(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(),
                padding: EdgeInsets.all(paddingSize).copyWith(top: 0),
                child: StreamBuilder<List<TravelRoute>>(
                  stream: travelRouteBloc.routes,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? [];

                    if (data.isEmpty) {
                      return const EmptyWidget();
                    }

                    return BlocBuilder<TravelRouteBloc, TravelRouteState>(
                      buildWhen: (previous, current) => previous.searchKeyword != current.searchKeyword,
                      builder: (context, state) {
                        final newData = data
                            .where((e) => (UtilsHelper.contain(e.departureName!, state.searchKeyword) ||
                                UtilsHelper.contain(e.destinationName!, state.searchKeyword) ||
                                UtilsHelper.contain(e.name!, state.searchKeyword)))
                            .toList();

                        if (newData.isEmpty) return const SearchEmptyWidget();

                        return ListView.separated(
                          padding: const EdgeInsets.only(top: 5),
                          clipBehavior: Clip.none,
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return SpaceVertical(height: paddingSize);
                          },
                          itemCount: newData.length,
                          itemBuilder: (context, index) {
                            return buildItem(newData[index]);
                          },
                        );
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
                child: SeatsStatus(
                  travelRoute: item,
                  onItemTab: (value) {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void onSearching(String value) {
    Debounce.instance.runAfter(
      action: () {
        travelRouteBloc.add(OnSearchRoute(keyword: value));
      },
      rate: 500,
    );
  }
}

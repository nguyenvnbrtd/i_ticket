import 'package:flutter/material.dart';
import 'package:flutter_animation/core/utils/dimension.dart';
import 'package:flutter_animation/widgets/base_screen/origin_screen.dart';
import 'package:flutter_animation/widgets/staless/main_label.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/staless/empty_widget.dart';
import '../../../widgets/staless/spacer.dart';
import '../../booking/blocs/booking_cubit.dart';
import '../../booking/models/booking_detail.dart';
import '../../travel_route/models/travle_route.dart';
import '../blocs/history_cubit.dart';
import 'components/history_item.dart';

class HistoryScreen extends StatefulWidget{
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final HistoryCubit historyCubit;

  final title = 'History';

  @override
  void initState() {
    historyCubit = HistoryCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => historyCubit,
      child: OriginScreen(
        child: Padding(
          padding: EdgeInsets.all(DeviceDimension.padding),
          child: Column(
            children: [
              MainLabel(
                label: title,
                widgetSize: 30,
                alignment: MainAxisAlignment.start,
              ),
              SpaceVertical(height: DeviceDimension.padding),
              Expanded(
                child: StreamBuilder<List<BookingDetail>>(
                  stream: historyCubit.routes(),
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? [];

                    if(data.isEmpty){
                      return const EmptyWidget();
                    }

                    return ListView.separated(
                      clipBehavior: Clip.none,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return SpaceVertical(height: DeviceDimension.padding);
                      },
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return buildItem(data[index]);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(BookingDetail item) {
    return HistoryItem(item: item);
  }
}
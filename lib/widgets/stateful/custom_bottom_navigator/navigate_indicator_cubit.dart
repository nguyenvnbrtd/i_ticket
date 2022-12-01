import '../../../base/cubits/base_cubit.dart';

class NavigateIndicatorCubit extends BaseCubit<int>{
  NavigateIndicatorCubit({int initValue = 0}) : super(initValue);

  void changeToIndex ({required int index}) => emit(index);
}
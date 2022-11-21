import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<E> extends Cubit<E>{
  BaseCubit(E initialState) : super(initialState);
}

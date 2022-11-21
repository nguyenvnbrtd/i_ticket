

import 'package:flutter_bloc/flutter_bloc.dart';
import './base_state.dart';
import './base_event.dart';

/// Need 2 parameters
///
/// First: [BaseEvent]
///
/// Second: [BaseState]
abstract class BaseBloc<E extends BaseEvent, S extends BaseState> extends Bloc<E, S>{
  BaseBloc(S initialState) : super(initialState);

}

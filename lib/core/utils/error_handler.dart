import 'dart:async';

class ErrorHandler{
  StreamSubscription<Object>? _serviceSubscription;
  final StreamController<Object> _errorStreamController = StreamController();
  Stream<Object> get errorHandler => _errorStreamController.stream;

  void setOnCatchingError(OnCatchErrorListener listener) async {
    _serviceSubscription = errorHandler.listen((error){
      listener.onCatchingError(error);
    });
  }

  void pushError(Object errorOrCode) {
    _errorStreamController.sink.add(errorOrCode);
  }

  void cancelConnect() {
    if(_serviceSubscription != null) {
      _serviceSubscription!.cancel();
    }
  }
}

abstract class OnCatchErrorListener{
  void onCatchingError(Object error);
}
import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionInfo {
  late StreamSubscription<InternetConnectionStatus> _serviceSubscription;

  InternetConnectionStatus isConnected = InternetConnectionStatus.disconnected;
  late final InternetConnectionChecker _instance;

  void init() async {
    _instance = InternetConnectionChecker.createInstance();
    isConnected = await _instance.connectionStatus;
  }

  void setOnInternetStatusChangeListener(OnInternetStatusChangeListener listener) async {
    _serviceSubscription = _instance.onStatusChange.listen((status){
      if(isConnected != status){
        isConnected = status;
        listener.onInternetStatusChange(status);
      }
    });
  }

  void dispose() {
    _serviceSubscription.cancel();
  }
}

abstract class OnInternetStatusChangeListener {
  void onInternetStatusChange(InternetConnectionStatus status);
}

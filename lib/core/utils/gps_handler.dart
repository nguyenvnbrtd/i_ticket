import 'dart:async';

import 'package:geolocator/geolocator.dart';


class GPSInfo {
  late StreamSubscription<ServiceStatus> _serviceSubscription;

  ServiceStatus isGpsOn = ServiceStatus.enabled;

  void setOnGPSStatusChange(OnGPSStatusChangeListener listener) async{
    _serviceSubscription = Geolocator.getServiceStatusStream().listen((status){
      if(isGpsOn != status){
        isGpsOn = status;
        listener.onGPSStatusChange(status);
      }
    });
  }

  void dispose() {
    _serviceSubscription.cancel();
  }
}

abstract class OnGPSStatusChangeListener {
  void onGPSStatusChange(ServiceStatus status);
}
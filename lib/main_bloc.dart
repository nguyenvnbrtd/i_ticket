import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/utils/dialog_utils.dart';
import 'core/utils/error_handler.dart';
import 'core/utils/gps_handler.dart';
import 'core/utils/intenret_handler.dart';

class MainBloc implements OnInternetStatusChangeListener, OnGPSStatusChangeListener, OnCatchErrorListener{
  final ConnectionInfo _connectionInfo = ConnectionInfo();
  final GPSInfo _gpsInfo = GPSInfo();
  late final ErrorHandler _error;

  void init(ErrorHandler errorHandler, dynamic instance){
    _connectionInfo.init();
    _connectionInfo.setOnInternetStatusChangeListener(instance);
    _gpsInfo.setOnGPSStatusChange(instance);
    _error = errorHandler;
    _error.setOnCatchingError(instance);
  }

  @override
  void onInternetStatusChange(InternetConnectionStatus result) {
    if (result == InternetConnectionStatus.disconnected) {
      ///do ever you want here, use _internetStreamController.sink.add('something');

      print('don\'t have any connection');
    } else {
      print('have a connection');
    }
  }

  @override
  void onGPSStatusChange(ServiceStatus status) {
    if (status == ServiceStatus.disabled) {
      print('don\'t have GPS');
    } else {
      print('have GPS');
    }
  }

  @override
  void onCatchingError(Object error) {
    DialogUtils.showToast(error.toString());
  }


  void dispose(){
    _gpsInfo.dispose();
    _connectionInfo.dispose();
  }
}
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

enum PermissionHandler {
  ALL,
  LOCATION,
  STORAGE,
  EXTERNAL_STORAGE
}

extension PermissionCodeExtention on PermissionHandler{
  void request({
    ValueChanged<PermissionStatus>? onSuccess,
    ValueChanged<PermissionStatus>? onFailed
  }) async {
    try{
      switch (this) {
        case PermissionHandler.ALL:
          _requestAllPermission(onSuccess, onFailed);
          break;
        case PermissionHandler.LOCATION:
          _requestPermission(Permission.location.request, onSuccess, onFailed);
          break;
        case PermissionHandler.STORAGE:
          _requestPermission(Permission.storage.request, onSuccess, onFailed);
          break;
        case PermissionHandler.EXTERNAL_STORAGE:
          _requestPermission(Permission.manageExternalStorage.request, onSuccess, onFailed);
          break;
        default:
          break;
      }
    }catch(e){
      print(e);
    }
  }

  void _requestAllPermission(ValueChanged<PermissionStatus>? onSuccess, ValueChanged<PermissionStatus>? onFailed) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      //add more permission to request here.
    ].request();

    statuses.forEach((key, value) {
      if(value.isGranted){
        onSuccess != null ? onSuccess(value) : (){};
      }else{
        onFailed != null ? onFailed(value) : (){};
      }
    });

  }

  void _requestPermission (Future<PermissionStatus> Function() request, ValueChanged<PermissionStatus>? onSuccess, ValueChanged<PermissionStatus>? onFailed) async {
    PermissionStatus status = await request();
    if(status.isGranted){
      onSuccess != null ? onSuccess(status) : (){};
    }else{
      onFailed != null ? onFailed(status) : (){};
    }
  }

}


import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  final PermissionHandler _permissionHandler = PermissionHandler();

  Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> hasPermission(PermissionGroup permission) async {
    var permissionStatus = await _permissionHandler.checkPermissionStatus(permission);
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(PermissionGroup.location);
    if (!granted) {
      if (onPermissionDenied != null) {
        await onPermissionDenied();
      }
    }
    return granted;
  }

  Future<bool> hasLocationPermission({Function onPermissionNotAllowed}) async {
    var granted = await hasPermission(PermissionGroup.location);
    if (!granted) {
      if (onPermissionNotAllowed != null) {
        await onPermissionNotAllowed();
      }
    }
    return granted;
  }

  Future<bool> requestNotificationPermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(PermissionGroup.notification);
    if (!granted) {
      if (onPermissionDenied != null) {
        await onPermissionDenied();
      }
    }
    return granted;
  }

  Future<bool> hasNotificationPermission({Function onPermissionNotAllowed}) async {
    var granted = await hasPermission(PermissionGroup.notification);
    if (!granted) {
      if (onPermissionNotAllowed != null) {
        await onPermissionNotAllowed();
      }
    }
    return granted;
  }
}

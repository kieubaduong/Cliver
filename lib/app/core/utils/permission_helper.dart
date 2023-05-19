import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  void requestPermissions() async {
    try {
      await [
        Permission.camera,
        Permission.microphone,
        Permission.storage,
        Permission.notification,
        Permission.photos,
        Permission.photosAddOnly,
        Permission.location,
      ].request();
    } on Exception catch (e) {
      print('PermissionHelper:::requestPermissions:::Exception:::$e');
    }
  }

  Future<bool> checkPermission(Permission permission) async {
    final isPermanentlyDenied = await permission.isPermanentlyDenied;
    if (isPermanentlyDenied) {
      await openAppSettings();
    }
    final isDenied = await permission.isDenied;
    if (isDenied) {
      await permission.request();
    }
    return await permission.isGranted;
  }

  static PermissionHelper? _instance;

  factory PermissionHelper() {
    _instance ??= PermissionHelper._internal();
    return _instance!;
  }

  PermissionHelper._internal();
}
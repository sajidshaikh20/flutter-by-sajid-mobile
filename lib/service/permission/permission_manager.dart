import '../../utils/exports.dart';

/// Utility class for Permission asking and granting.
///
/// Customized [PermissionManager] as per this app's
/// requirement.
class PermissionManager {
  /// A singleton factory for the PermissionManager class to ensure only one
  /// instance is created. This provides global access to the instance.
  factory PermissionManager() => _singletonApiProvider;

  PermissionManager._internal();

  static final PermissionManager _singletonApiProvider =
      PermissionManager._internal();


  /// Request Multiple permission
  FutureOr<bool> requestPermissions(List<Permission> permissions) async {
    Map<Permission, PermissionStatus> status = await permissions.request();

    bool granted = true;
    status.forEach((Permission permission, PermissionStatus permissionStatus) {
      if (!permissionStatus.isGranted) {
        granted = false;
      }
    });

    return granted;
  }

  /// Check all permission given or not
  FutureOr<bool> isAllPermissionsGranted(List<Permission> permissions) async {
    Map<Permission, PermissionStatus> permissionStatuses =
        await permissions.request();

    for (final Permission permission in permissionStatuses.keys) {
      if (permissionStatuses[permission] != PermissionStatus.granted) {
        return false; // Permission not granted
      }
    }

    return true; // All permissions granted
  }

  //----------------------------------------------------------------
  /// Check OS version of Android is 33 or Greater
  FutureOr<bool> isAndroidOSVersionIS13() async {
    if(Platform.isAndroid.isFalse ?? false) return false;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt > 32) {
      return true;
    } else {
      return false;
    }
  }





  /// Check Location permission (legacy method for backward compatibility)
  FutureOr<bool> checkLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    if (status.isGranted) {
      return true;
    } else {
      if (status.isDenied) {
        // We didn't ask for permission yet or
        //the permission has been denied before but not permanently.
        return false;
      } else {
        return false;
      }
    }
  }

  /// Enhanced Request Location permission with smart handling
  // FutureOr<bool> requestLocationPermissionEnhanced() async {
  //   // First check if permission is already granted to avoid unnecessary request
  //   PermissionStatus currentStatus = await Permission.location.status;
  //   if (currentStatus == PermissionStatus.granted) {
  //     DebugLog.instance.d('Location permission already granted, no need to request');
  //     return true;
  //   }
  //
  //   PermissionStatus status = await Permission.location.request();
  //   bool hasPermission = false;
  //
  //   if (status == PermissionStatus.granted) {
  //     DebugLog.instance.d('Location permission granted');
  //     hasPermission = true;
  //   } else if (status == PermissionStatus.denied) {
  //     DebugLog.instance.d('Location permission denied');
  //     hasPermission = false;
  //   } else if (status == PermissionStatus.permanentlyDenied) {
  //     DebugLog.instance.d('Location permission permanently denied - showing settings dialog');
  //     // Use the existing showPermissionSettingsDialog method
  //     showPermissionSettingsDialog("Location permission is required to show nearby stores");
  //     hasPermission = false;
  //   }
  //
  //   return hasPermission;
  // }

  /// Request Location permission (legacy method for backward compatibility)
  FutureOr<bool> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    bool st = false;
    if (status == PermissionStatus.granted) {

      st = true;
    } else if (status == PermissionStatus.denied) {
      //await openAppSettings();
      st = false;
    } else if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }
    return st;
  }

  /// Check with Storage permission given or not
  FutureOr<bool> checkStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (status.isGranted) {
      return true;
    } else {
      if (status.isDenied) {
        // We didn't ask for permission yet or
        //the permission has been denied before but not permanently.
        return true;
      } else {
        return false;
      }
    }
  }

  /// Request Storage permission
  FutureOr<bool> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    bool st = false;
    if (status == PermissionStatus.granted) {

      st = true;
    } else if (status == PermissionStatus.denied) {
      //await openAppSettings();
      st = false;

    } else if (status == PermissionStatus.permanentlyDenied) {

      await openAppSettings();
    }
    return st;
  }

  /// Request photo permission
  FutureOr<bool> requestPhotosPermission() async {
    bool isAndroid13OrGreater = await isAndroidOSVersionIS13();
    if (!isAndroid13OrGreater) return requestStoragePermission();

    final PermissionStatus status = await Permission.photos.request();
    bool st = false;
    if (status == PermissionStatus.granted) {

      st = true;
    } else if (status == PermissionStatus.denied) {
      //await openAppSettings();
      st = false;
    } else if (status == PermissionStatus.permanentlyDenied) {
      // For permanently denied, just open app settings directly
      await openAppSettings();
    }
    return st;
  }

  /// Check with SMS permission given or not
  FutureOr<bool> checkSMSPermission() async {
    PermissionStatus status = await Permission.sms.status;
    if (status.isGranted) {
      return true;
    } else {
      if (status.isDenied) {
        // We didn't ask for permission yet or
        //the permission has been denied before but not permanently.
        return true;
      } else {
        return false;
      }
    }
  }

  /// Request SMS permission
  FutureOr<bool> requestSMSPermission() async {
    PermissionStatus status = await Permission.sms.request();
    bool st = false;
    if (status == PermissionStatus.granted) {

      st = true;
    } else if (status == PermissionStatus.denied) {
      //await openAppSettings();
      st = false;
    } else if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }
    return st;
  }

  /// Check with Contacts permission given or not
  FutureOr<bool> checkContactsPermission() async {
    PermissionStatus status = await Permission.contacts.status;
    if (status.isGranted) {
      return true;
    } else {
      if (status.isDenied) {
        // We didn't ask for permission yet or
        //the permission has been denied before but not permanently.
        return true;
      } else {
        return false;
      }
    }
  }

  /// Requests the contact permission from the user.
  /// Returns true if permission is granted, false if denied or if the user is
  /// taken to the settings page for permanent denial.
  FutureOr<bool> requestContactPermission() async {
    PermissionStatus status = await Permission.contacts.request();
    bool st = false;
    if (status == PermissionStatus.granted) {
      st = true;
    } else if (status == PermissionStatus.denied) {
      // Await openAppSettings() if you want to guide the user to settings.
      st = false;
    } else if (status == PermissionStatus.permanentlyDenied) {

      await openAppSettings();
    }
    return st;
  }

  /// Check with Phone permission given or not
  FutureOr<bool> checkPhonePermission() async {
    PermissionStatus status = await Permission.phone.status;
    if (status.isGranted) {
      return true;
    } else {
      if (status.isDenied) {
        // We didn't ask for permission yet or
        //the permission has been denied before but not permanently.
        return true;
      } else {
        return false;
      }
    }
  }

  /// Requests the phone permission from the user.
  /// Returns true if permission is granted, false if denied or if the user is
  /// taken to the settings page for permanent denial.
  FutureOr<bool> requestPhonePermission() async {
    PermissionStatus status = await Permission.phone.request();
    bool st = false;
    if (status == PermissionStatus.granted) {

      st = true;
    } else if (status == PermissionStatus.denied) {
      // Await openAppSettings() if you want to guide the user to settings.
      st = false;
    } else if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }
    return st;
  }

  /// Check with Camera permission given or not
  FutureOr<bool> checkCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    if (status.isGranted) {
      return true;
    } else {
      if (status.isDenied) {
        return false;
      } else {
        return false;
      }
    }
  }

  /// Request Camera permission
  FutureOr<bool> requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();
    bool st = false;
    if (status == PermissionStatus.granted) {
      st = true;
    } else if (status == PermissionStatus.denied) {
      //await openAppSettings();
      st = false;
    } else if (status == PermissionStatus.permanentlyDenied) {

      await openAppSettings();
    }
    return st;
  }

  /// Check microphone permission
  FutureOr<bool> checkMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.status;
    if (status.isGranted) {
      return true;
    } else if (status.isDenied || status.isRestricted) {
      return false;
    } else if (status.isPermanentlyDenied) {
      return false;
    }
    return false;
  }

  /// Request microphone permission
  FutureOr<bool> requestMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else if (status == PermissionStatus.permanentlyDenied) {
      // For permanently denied, just open app settings directly
      await openAppSettings();
    }
    return false;
  }

  /// Check speech recognition permission
  FutureOr<bool> checkSpeechPermission() async {
    if (Platform.isIOS) {
      PermissionStatus status = await Permission.speech.status;
      if (status.isGranted) {
        return true;
      } else if (status.isDenied || status.isRestricted) {
        return false;
      } else if (status.isPermanentlyDenied) {
        return false;
      }
    }
    return true; // Speech permission is not required on Android.
  }

  /// Request speech recognition permission
  FutureOr<bool> requestSpeechPermission() async {
    if (Platform.isIOS) {
      PermissionStatus status = await Permission.speech.request();
      if (status == PermissionStatus.granted) {

        return true;
      }
      return false;
    }
    return true; // Speech permission is not required on Android.
  }

  /// Request Notifications permission
  /// Returns true if granted, false if denied (app can still function)
  FutureOr<bool> requestNotificationsPermission() async {
    try {
      PermissionStatus status = await Permission.notification.request();
      bool st = false;
      if (status == PermissionStatus.granted) {
        st = true;
        DebugLog.instance.i('Notification permission granted');
      } else if (status == PermissionStatus.denied) {
        DebugLog.instance.i('Notification permission denied - app can still function');
        st = false;
      } else if (status == PermissionStatus.permanentlyDenied) {
        DebugLog.instance.i('Notification permission permanently denied - app continues without notifications');
        // Don't redirect to settings - let app continue normally
        st = false;
      }
      return st;
    } on Exception catch (e) {
      DebugLog.instance.e('Error requesting notification permission: $e');
      return false; // Return false but don't crash the app
    }
  }

  /// Check if notification permission is granted (non-blocking)
  FutureOr<bool> isNotificationPermissionGranted() async {
    try {
      PermissionStatus status = await Permission.notification.status;
      return status == PermissionStatus.granted;
    } on Exception catch (e) {
      DebugLog.instance.e('Error checking notification permission: $e');
      return false;
    }
  }

  /// Requests multiple permissions (location, contact, phone) sequentially.
  /// If each permission is granted, it proceeds to request the next one.
  Future<void> askPermission() async {
    bool value = await PermissionManager().requestLocationPermission();
    if (value) {
      bool contactPermission = await requestContactPermission();
      if (contactPermission) {
        bool storagePermission = await requestPhonePermission();
        if (storagePermission) {
          // var smsPermission = await requestSMSPermission();
        }
      }
    }
  }

  /// Opens the mobile app settings page to allow the user to manually adjust
  /// the app's permissions or other settings.
  Future<void> openMobileSetting() async {
    await openAppSettings();
  }
}

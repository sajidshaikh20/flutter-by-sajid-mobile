
import '../../utils/exports.dart';

/// Use this method to detect when a new notification or a schedule is created
@pragma('vm:entry-point')
Future<void> onNotificationCreatedMethod(
  ReceivedNotification receivedNotification,
) async {
  DebugLog.instance.d('on Create Method');
}

/// Use this method to detect if the user dismissed a notification
@pragma('vm:entry-point')
Future<void> onDismissActionReceivedMethod(
  ReceivedAction receivedAction,
) async {
  DebugLog.instance.i('on Dismiss Method');
}

/// Use this method to detect every time that a new notification is displayed
@pragma('vm:entry-point')
Future<void> onNotificationDisplayedMethod(
  ReceivedNotification receivedNotification,
) async {
  DebugLog.instance.d('on Display Method');
}

/// Use this method to detect when the user taps on
///  a notification or action button
@pragma('vm:entry-point')
Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
  // manage your redirection here

  // Type :-- 'Product' ---> Product Detail Screen
  // Type :-- 'Order' ---> Order Detail Screen
  // Type :-- 'Promotional' ---> Home Screen

  DebugLog.instance.t('on Action Received Method ');
  Map<String, String?> payload = receivedAction.payload ?? <String, String?>{};

  String type = payload['type']?.toString().toLowerCase() ?? '';


}

/// A singleton class to manage and initialize AwesomeNotifications
/// for creating and handling notifications within the app.
class AwesomeNotificationManager {
  // Private constructor to ensure the singleton pattern.
  AwesomeNotificationManager._internal();

  /// Singleton instance of AwesomeNotificationManager.
  static final AwesomeNotificationManager instance =
      AwesomeNotificationManager._internal();

  // Instance of AwesomeNotifications to handle notification creation.
  static final AwesomeNotifications _awesomeNotification =
      AwesomeNotifications();

  /// ReceivePort to listen for notification actions.
  static ReceivePort? receivePort;

  /// Initializes AwesomeNotification and sets up the necessary ports.
  Future<void> init() async {
    await _initializeAwesomeNotification();
    _initializeIsolatePort();
  }

  /// Initializes the AwesomeNotification with required settings.
  /// Sets up the notification channels, permissions, and listeners.
  Future<void> _initializeAwesomeNotification() async {
    await _awesomeNotification.initialize(
      null, // Set icon to null to use the default app icon.
      <NotificationChannel>[
        NotificationChannel(
          channelGroupKey: NotificationConst.channelGroupKey,
          channelKey: NotificationConst.channelKey,
          channelName: NotificationConst.channelName,
          channelDescription: NotificationConst.channelDescription,
          defaultColor: Colors.blue,
          ledColor: Colors.white,
        ),
      ],
      channelGroups: <NotificationChannelGroup>[
        NotificationChannelGroup(
          channelGroupKey: NotificationConst.channelGroupKey,
          channelGroupName: NotificationConst.channelGroupName,
        ),
      ],
      debug: true,
    );

    // Checks if notification permission is allowed.
    // Note: We don't automatically request permission here to allow app to run
    // even if user denies notifications. Permission can be requested later when needed.
    await _awesomeNotification.isNotificationAllowed().then((bool isAllowed) async {
      DebugLog.instance.i('Notification permission status: ${isAllowed ? "Granted" : "Not granted"}');
      // Don't automatically request permission - let user decide when to enable notifications
    });

    // Sets up listeners for notification events.
     unawaited(_awesomeNotification.setListeners(
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    ));
    _initializeIsolatePort();
  }

  /// Manually request notification permission when user wants to enable notifications
  /// Returns true if permission is granted, false otherwise
  Future<bool> requestNotificationPermission() async {
    try {
      final bool isAllowed = await _awesomeNotification.isNotificationAllowed();
      if (!isAllowed) {
        final bool granted = await _awesomeNotification.requestPermissionToSendNotifications();
        DebugLog.instance.i('Notification permission requested: ${granted ? "Granted" : "Denied"}');
        return granted;
      }
      return true; // Already granted
    } on Exception catch (e) {
      DebugLog.instance.e('Error requesting notification permission: $e');
      return false;
    }
  }

  /// Check if notification permission is currently granted
  Future<bool> isNotificationPermissionGranted() async {
    try {
      return await _awesomeNotification.isNotificationAllowed();
    } on Exception catch (e) {
      DebugLog.instance.e('Error checking notification permission: $e');
      return false;
    }
  }

  /// Initializes the isolate port for receiving notification actions.
  void _initializeIsolatePort() {
    receivePort = ReceivePort('Notification action port in main isolate')
      ..listen((dynamic silentData) async {
        await onActionReceivedImplementationMethod(
            silentData as ReceivedAction);
      });

    // Registers the port with the given name in the isolate.
    IsolateNameServer.registerPortWithName(
      receivePort!.sendPort,
      'notification_action_port',
    );
  }

  /// A method that handles the action received in the notification.
  static Future<void> onActionReceivedImplementationMethod(
    ReceivedAction receivedAction,
  ) async {
    DebugLog.instance.t('on Action Received Method');
  }

  /// Creates and shows a notification in the system tray.
  /// Takes a payload map containing notification data.
  Future<void> showNotification({Map<String, dynamic>? payload}) async {
    if (payload?.isNotEmpty ?? false) {
      await _awesomeNotification.createNotification(
        content: NotificationContent(
          id: Random().nextInt(1000),
          channelKey: NotificationConst.channelKey,
          title: payload!['title'] ?? '',
          backgroundColor: MainConfig.appColors.backgroundBlueColor,
          icon: 'resource://drawable/ic_notification_icon',
          body: payload['body'] ?? '',
          bigPicture: payload['image'] ?? '',
          payload: Map<String, String>.from(payload),
        ),
      );
    }
  }
}

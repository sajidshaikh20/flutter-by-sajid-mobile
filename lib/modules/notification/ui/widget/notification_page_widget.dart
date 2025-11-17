import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/exports.dart';
import '../../../../app/providers/providers.dart';
import 'notification_permission_view.dart';

/// A responsive widget that displays the notification page with permission handling
/// and notification list for different screen types.
class NotificationPageWidget extends StatefulWidget {
  /// The screen type (mobile, tablet, etc.) for responsive design.
  final ScreenType device;

  /// Creates a [NotificationPageWidget].
  ///
  /// [device] defaults to [ScreenType.mobile] if not specified.
  const NotificationPageWidget({super.key, this.device = ScreenType.mobile});

  @override
  State<NotificationPageWidget> createState() => _NotificationPageWidgetState();
}

class _NotificationPageWidgetState extends State<NotificationPageWidget> {
  bool _isNotificationPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    unawaited(_checkNotificationPermission());
  }

  Future<void> _checkNotificationPermission() async {
    final bool isGranted = await AwesomeNotificationManager.instance.isNotificationPermissionGranted();
    if (mounted) {
      setState(() {
        _isNotificationPermissionGranted = isGranted;
      });
    }
  }

  Future<void> _requestNotificationPermission() async {
    final bool granted = await AwesomeNotificationManager.instance.requestNotificationPermission();
    if (mounted) {
      setState(() {
        _isNotificationPermissionGranted = granted;
      });
      
      if (granted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notification permission granted!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Show info message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notification permission denied. You can enable it later in app settings.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return NoInternetWidget(
      childWidget: Scaffold(
        backgroundColor: MainConfig.appColors.backgroundWhiteColor,
        body: Column(
          children: <Widget>[
            HomeAppbar(
              isLastItemDisplay: false,
              isShadowDisplay: true,
              title: context.appString.navNotificationsKey,
            ),
            Expanded(
              child: _isNotificationPermissionGranted
                  ? RefreshIndicator(
                onRefresh: () async {
                  final ProviderContainer container = ProviderScope.containerOf(context);
                  await container.read(notificationNotifierProvider.notifier).getNotifications();
                },
                child: _buildNotificationList(context, widget.device),
              )
                  : NotificationPermissionView(
                onEnableNotificationPressed: _requestNotificationPermission,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationList(BuildContext ctx, ScreenType device) {
    // This widget needs to be converted to ConsumerWidget, but since it's called from StatefulWidget,
    // we'll use ProviderScope.containerOf to access the provider
    final ProviderContainer container = ProviderScope.containerOf(ctx);
    final NotificationState state = container.read(notificationNotifierProvider);
    final List<ListOfNotificationResponse>? notificationResponseModels =
        _getListOfNotificationResponse(state);

    if (state.status == BaseStateStatus.success) {
          // ✅ Show No Data Widget if list is empty or null
          if (notificationResponseModels == null ||
              notificationResponseModels.isEmpty) {
            return ColoredBox(
              color: MainConfig.appColors.backgroundLightPinkColor,
              child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Center(
                      child: CustomNoDataWidget(
                        key: ValueKey<String>('empty_wishlist_${state.hashCode}'),
                        message: context.appString.emptyNotificationListKey,
                        description: context.appString.emptyNotificationListDescKey,
                        buttonText: context.appString.tryAgainKey,
                        onButtonPressed: () async {
                          final ProviderContainer container = ProviderScope.containerOf(context);
                          await container.read(notificationNotifierProvider.notifier).getNotifications();
                        },
                      ),
                    ),
                  ),
                );
              },
            ));
          }

          // ✅ Show ListView WITH padding when data exists
          return Padding(
            padding: const EdgeInsets.only(
              left: Dimens.space16,
              right: Dimens.space17,
              top: Dimens.space17,
            ),
            child: CustomListView(
              isPadding: true,
              itemCount: notificationResponseModels.length,
              scrollPhysics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final ListOfNotificationResponse notificationListItem =
                notificationResponseModels[index];
                final String? description = isLanguageAlignmentLTR
                    ? notificationListItem.notificationDescription
                    : (notificationListItem.notificationDescriptionArabic ?? notificationListItem.notificationDescription);
                return Column(
                  children: <Widget>[
                    NotificationListItemWidget(
                      imagePath: NotificationType.fromValue(
                          notificationListItem.notificationType)
                          .iconPath,
                      notificationTitle: notificationListItem.notificationTitle,
                      notificationTime: notificationListItem.dateTime,
                      notificationSubTitle: notificationListItem.notificationSubTitle,
                      notificationDetails: description,
                      isRead: notificationListItem.isRead,
                      onTap: () async {
                        final List<int>? notificationIds =
                        notificationListItem.notificationId != null ? <int>[notificationListItem.notificationId!] : null;
                        final String? notificationType = notificationListItem.notificationType;
                        final int? orderId = notificationListItem.orderId;
                        final String? entityId = notificationListItem.entityId;
                        final StackRouter router = context.router; // capture router reference
                        final ProviderContainer container = ProviderScope.containerOf(context);
                        final NotificationNotifier notifier = container.read(notificationNotifierProvider.notifier);

                    //    await notifier.callNotificationReadAPI(notificationIds);

                        final NotificationType type = NotificationType.fromValue(notificationType);

                        if ((type == NotificationType.deliverd || type == NotificationType.pickup) &&
                            orderId != null) {
                         // await router.push(MyOrderDetailRoute(orderId: orderId));
                        } else {
                          final String cleaned = entityId?.replaceAll(RegExp(r'[\[\]\s]'), '') ?? '';
                          if (cleaned.isNotEmpty) {
                            final int productId = int.parse(cleaned.split(',').first);
                           // await router.push(ProductDetailsRoute(entityId: productId));
                          }
                        }

                      },
                    ),
                  ],
                );
              },
            ),
          );
    }

    // ✅ Show shimmer when loading
    return const ShimmerNotificationView();
  }

  List<ListOfNotificationResponse>? _getListOfNotificationResponse(
      NotificationState state) {
    if (state.status == BaseStateStatus.success &&
        state.listOfNotificationResponse != null &&
        state.listOfNotificationResponse!.isNotEmpty) {
      return state.listOfNotificationResponse;
    }
    return <ListOfNotificationResponse>[];
  }
}

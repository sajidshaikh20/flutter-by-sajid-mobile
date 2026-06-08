import '../../../utils/exports.dart';

class AppNotificationItem {
  final String id;
  final String title;
  final String message;
  final String time;
  final bool isRead;
  final AppNotificationCategory category;

  const AppNotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
    required this.category,
  });

  AppNotificationItem copyWith({bool? isRead}) {
    return AppNotificationItem(
      id: id,
      title: title,
      message: message,
      time: time,
      isRead: isRead ?? this.isRead,
      category: category,
    );
  }
}

enum AppNotificationCategory { tradeAlert, accountUpdate, promotion, general }

@RoutePage()
/// Notifications Page displaying alerts, updates, and messages.
class NotificationPage extends BaseResponsiveView {
  const NotificationPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return const NotificationView();
  }
}

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final List<AppNotificationItem> _notifications = <AppNotificationItem>[
    const AppNotificationItem(
      id: '1',
      title: 'New Crypto Signal Alert 🚀',
      message: 'BTCUSD Buy Signal has been triggered. Entry: 64,191.39, Take Profit: 64,300. Explore the Trade tab to view full details.',
      time: 'Just now',
      isRead: false,
      category: AppNotificationCategory.tradeAlert,
    ),
    const AppNotificationItem(
      id: '2',
      title: 'Take Profit Reached! 🎯',
      message: 'Your EURUSD Trade has hit Take Profit target of 1.18000. Net Profit: +91.7 PIPS.',
      time: '2 hours ago',
      isRead: false,
      category: AppNotificationCategory.tradeAlert,
    ),
    const AppNotificationItem(
      id: '3',
      title: 'Security Notice',
      message: "Your account was successfully accessed from a new device (Pixel 7 Pro). If this wasn't you, please change your password immediately.",
      time: 'Yesterday',
      isRead: true,
      category: AppNotificationCategory.accountUpdate,
    ),
    const AppNotificationItem(
      id: '4',
      title: 'Weekend Bonus Campaign 🎁',
      message: 'Claim 15% deposit bonus on any deposits made using USDT this weekend. Offer valid till Sunday night.',
      time: '2 days ago',
      isRead: true,
      category: AppNotificationCategory.promotion,
    ),
  ];

  void _markAllAsRead() {
    setState(() {
      for (int i = 0; i < _notifications.length; i++) {
        _notifications[i] = _notifications[i].copyWith(isRead: true);
      }
    });
    context.scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _markAsRead(int index) {
    setState(() {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    });
  }

  void _removeNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
    context.scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text('Notification removed'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color pageBg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color cardBg = isDark ? AppColors.cardDark : AppColors.cardLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5);

    return Scaffold(
      backgroundColor: pageBg,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Premium App Bar with back button and mark all read option
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.space12,
                vertical: Dimens.space12,
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: textColor,
                      size: Dimens.size20,
                    ),
                    onPressed: () {
                      context.router.back();
                    },
                  ),
                  const SizedBox(width: Dimens.space4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomTextLabelWidget(
                          label: 'Notifications',
                          style: TextStyle(
                            color: textColor,
                            fontSize: Dimens.fontSize20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (_notifications.isNotEmpty) ...<Widget>[
                          const SizedBox(height: 2),
                          CustomTextLabelWidget(
                            label: '${_notifications.where((AppNotificationItem n) => !n.isRead).length} unread alerts',
                            style: TextStyle(
                              color: subtextColor,
                              fontSize: Dimens.fontSize11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (_notifications.isNotEmpty)
                    TextButton(
                      onPressed: _markAllAsRead,
                      child: const CustomTextLabelWidget(
                        label: 'Mark all read',
                        style: TextStyle(
                          color: AppColors.primaryPurple,
                          fontSize: Dimens.fontSize12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Divider(
              height: 1,
              thickness: 1,
              color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
            ),

            // Notification List
            Expanded(
              child: _notifications.isEmpty
                  ? _buildEmptyState(subtextColor)
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.space16,
                        vertical: Dimens.space16,
                      ),
                      itemCount: _notifications.length,
                      itemBuilder: (BuildContext context, int index) {
                        final AppNotificationItem notification = _notifications[index];
                        return _buildNotificationCard(
                          context: context,
                          notification: notification,
                          index: index,
                          cardBg: cardBg,
                          textColor: textColor,
                          subtextColor: subtextColor,
                          borderColor: borderColor,
                          isDark: isDark,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required BuildContext context,
    required AppNotificationItem notification,
    required int index,
    required Color cardBg,
    required Color textColor,
    required Color subtextColor,
    required Color borderColor,
    required bool isDark,
  }) {
    IconData iconData;
    Color iconColor;

    switch (notification.category) {
      case AppNotificationCategory.tradeAlert:
        iconData = Icons.show_chart_rounded;
        iconColor = AppColors.primaryPurple;
      case AppNotificationCategory.accountUpdate:
        iconData = Icons.security_rounded;
        iconColor = AppColors.warningColor;
      case AppNotificationCategory.promotion:
        iconData = Icons.local_offer_rounded;
        iconColor = isDark ? AppColors.successColor : AppColors.greenTextColor;
      case AppNotificationCategory.general:
        iconData = Icons.notifications_rounded;
        iconColor = AppColors.infoColor;
    }

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) {
        _removeNotification(index);
      },
      background: Container(
        margin: const EdgeInsets.only(bottom: Dimens.space12),
        decoration: BoxDecoration(
          color: AppColors.errorColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(Dimens.radius12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: Dimens.space20),
        child: const Icon(
          Icons.delete_sweep_rounded,
          color: AppColors.errorColor,
          size: Dimens.size24,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: Dimens.space12),
        decoration: BoxDecoration(
          color: notification.isRead
              ? cardBg.withValues(alpha: 0.7)
              : cardBg,
          borderRadius: BorderRadius.circular(Dimens.radius12),
          border: Border.all(
            color: !notification.isRead
                ? AppColors.primaryPurple.withValues(alpha: 0.4)
                : borderColor,
            width: !notification.isRead ? 1.2 : 1.0,
          ),
          boxShadow: !notification.isRead
              ? <BoxShadow>[
                  BoxShadow(
                    color: AppColors.primaryPurple.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (!notification.isRead) {
                _markAsRead(index);
              }
            },
            borderRadius: BorderRadius.circular(Dimens.radius12),
            child: Padding(
              padding: const EdgeInsets.all(Dimens.space12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Icon indicator
                  Container(
                    width: Dimens.size36,
                    height: Dimens.size36,
                    decoration: BoxDecoration(
                      color: iconColor.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      iconData,
                      color: iconColor,
                      size: Dimens.size18,
                    ),
                  ),
                  const SizedBox(width: Dimens.space12),

                  // Notification Message Contents
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: CustomTextLabelWidget(

                                label: notification.title,
                                textAlign: TextAlign.start,
                                style: TextStyle(

                                  color: textColor,
                                  fontSize: Dimens.fontSize13,
                                  fontWeight: notification.isRead ? FontWeight.w600 : FontWeight.w800,
                                ),
                              ),
                            ),
                            if (!notification.isRead)
                              Container(
                                width: Dimens.size6,
                                height: Dimens.size6,
                                margin: const EdgeInsets.only(left: Dimens.space6),
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryPurple,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: Dimens.space4),
                        CustomTextLabelWidget(
                          label: notification.message,
                          style: TextStyle(
                            color: subtextColor,
                            fontSize: Dimens.fontSize11,
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: Dimens.space8),
                        CustomTextLabelWidget(
                          label: notification.time,
                          style: TextStyle(
                            color: subtextColor.withValues(alpha: 0.7),
                            fontSize: Dimens.fontSize9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(Color subtextColor) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(Dimens.space24),
              decoration: BoxDecoration(
                color: AppColors.primaryPurple.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_off_rounded,
                color: AppColors.primaryPurple,
                size: Dimens.size48,
              ),
            ),
            const SizedBox(height: Dimens.space20),
            const CustomTextLabelWidget(
              label: 'Clean Slate!',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: Dimens.fontSize16,
              ),
            ),
            const SizedBox(height: Dimens.space6),
            CustomTextLabelWidget(
              label: "You don't have any notifications right now. Alerts regarding trade signals or accounts will show up here.",
              style: TextStyle(
                color: subtextColor,
                fontSize: Dimens.fontSize12,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

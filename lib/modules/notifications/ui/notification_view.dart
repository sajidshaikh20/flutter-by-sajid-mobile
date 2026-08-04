import '../../../service/navigation/deep_link_manager.dart';
import '../../../utils/exports.dart';



/// The main view container displaying a list of push notifications.
class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final NotificationRepositoryImpl _repository = NotificationRepositoryImpl();
  final List<AppNotificationModel> _notifications = <AppNotificationModel>[];
  final ScrollController _scrollController = ScrollController();

  int _currentPage = 0;
  bool _isLoading = false;
  bool _hasMore = true;
  bool _isInitialLoad = true;

  @override
  void initState() {
    super.initState();
    unawaited(_loadNotifications());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  Future<void> _onScroll() async {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoading && _hasMore) {
        await _loadNotifications();
      }
    }
  }

  Future<void> _loadNotifications({bool isRefresh = false}) async {
    if (isRefresh) {
      setState(() {
        _currentPage = 0;
        _hasMore = true;
        _isInitialLoad = true;
        _notifications.clear();
      });
    }

    if (!_hasMore) return;
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final ResponseHandler<BaseResponse<PaginatedNotifications>> response =
          await _repository.getNotifications(page: _currentPage, size: 20);
      if (response.isSuccess()) {
        final PaginatedNotifications? paginated = response.getSuccessInstance()?.response.data;
        if (paginated != null) {
          setState(() {
            _notifications.addAll(paginated.content);
            _currentPage++;
            _hasMore = !paginated.last;
            _isInitialLoad = false;
          });
        }
      } else {
        DebugLog.instance.e(
            'Error loading notifications: ${response.getFailureInstance()?.error?.errorMessage}');
        setState(() {
          _isInitialLoad = false;
        });
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Exception loading notifications: $e');
      setState(() {
        _isInitialLoad = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _markAsRead(int index) async {
    final AppNotificationModel notification = _notifications[index];
    if (notification.read) return;

    // Optimistically mark read in UI
    setState(() {
      _notifications[index] = AppNotificationModel(
        id: notification.id,
        title: notification.title,
        message: notification.message,
        type: notification.type,
        entityId: notification.entityId,
        read: true,
        createdAt: notification.createdAt,
      );
    });

    try {
      await _repository.markRead(notification.id);
    } on Exception catch (e) {
      DebugLog.instance.e('Error marking notification read: $e');
    }
  }

  Future<void> _markAllAsRead() async {
    final List<dynamic> unreadIds = _notifications
        .where((AppNotificationModel n) => !n.read)
        .map((AppNotificationModel n) => n.id)
        .toList();

    if (unreadIds.isEmpty) return;

    // Optimistically mark all read in UI
    setState(() {
      for (int i = 0; i < _notifications.length; i++) {
        if (!_notifications[i].read) {
          _notifications[i] = AppNotificationModel(
            id: _notifications[i].id,
            title: _notifications[i].title,
            message: _notifications[i].message,
            type: _notifications[i].type,
            entityId: _notifications[i].entityId,
            read: true,
            createdAt: _notifications[i].createdAt,
          );
        }
      }
    });

    try {
      for (int i = 0; i < unreadIds.length; i++) {
        final dynamic id = unreadIds[i];
        await _repository.markRead(id);
      }
      if (mounted) {
        context.scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text('All notifications marked as read'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error marking all notifications read: $e');
    }
  }

  void _removeNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
    context.scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text('Notification dismissed'),
        duration: Duration(seconds: 1),
      ),
    );
  }



  String _formatNotificationTime(String dateStr) {
    if (dateStr.isEmpty) return '';
    try {
      final DateTime parsed = DateTime.parse(dateStr).toLocal();
      final Duration diff = DateTime.now().difference(parsed);
      if (diff.inSeconds < 60) {
        return 'Just now';
      } else if (diff.inMinutes < 60) {
        return '${diff.inMinutes}m ago';
      } else if (diff.inHours < 24) {
        return '${diff.inHours}h ago';
      } else if (diff.inDays < 7) {
        return '${diff.inDays}d ago';
      } else {
        return DateFormat('dd MMM, yyyy').format(parsed);
      }
    } on Exception catch (_) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color pageBg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color cardBg = isDark ? AppColors.cardDark : AppColors.cardLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5);

    final int unreadCount = _notifications.where((AppNotificationModel n) => !n.read).length;

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
                            label: '$unreadCount unread alerts',
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
                  if (_notifications.isNotEmpty && unreadCount > 0)
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
              child: _isInitialLoad
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryPurple,
                      ),
                    )
                  : RefreshIndicator(
                      color: AppColors.primaryPurple,
                      onRefresh: () => _loadNotifications(isRefresh: true),
                      child: _notifications.isEmpty
                          ? ListView(
                              children: <Widget>[
                                SizedBox(
                                  height: context.height * 0.7,
                                  child: _buildEmptyState(subtextColor),
                                ),
                              ],
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics(),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.space16,
                                vertical: Dimens.space16,
                              ),
                              itemCount: _notifications.length + (_isLoading ? 1 : 0),
                              itemBuilder: (BuildContext context, int index) {
                                if (index == _notifications.length) {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16.0),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primaryPurple,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  );
                                }

                                final AppNotificationModel notification = _notifications[index];
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required BuildContext context,
    required AppNotificationModel notification,
    required int index,
    required Color cardBg,
    required Color textColor,
    required Color subtextColor,
    required Color borderColor,
    required bool isDark,
  }) {
    final NotificationType notifType = NotificationType.fromValue(notification.type);
    final IconData iconData = notifType.icon;
    final Color iconColor = notifType.color;

    return Dismissible(
      key: Key(notification.id.toString()),
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
          color: notification.read ? cardBg.withValues(alpha: 0.7) : cardBg,
          borderRadius: BorderRadius.circular(Dimens.radius12),
          border: Border.all(
            color: !notification.read
                ? AppColors.primaryPurple.withValues(alpha: 0.4)
                : borderColor,
            width: !notification.read ? 1.2 : 1.0,
          ),
          boxShadow: !notification.read
              ? <BoxShadow>[
                  BoxShadow(
                    color: AppColors.primaryPurple.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.radius12),
          child: Stack(
            children: <Widget>[
              // Visual premium indicator stripe on the left edge
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 4,
                  color: iconColor,
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    if (!notification.read) {
                      await _markAsRead(index);
                    }
                    final Map<String, dynamic> deepLinkPayload = <String, dynamic>{
                      'type': notification.type,
                      'entity': notification.entityId,
                    };
                    await DeepLinkManager.instance.handleDeepLink(deepLinkPayload);
                  },
                  borderRadius: BorderRadius.circular(Dimens.radius12),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      Dimens.space16,
                      Dimens.space12,
                      Dimens.space12,
                      Dimens.space12,
                    ),
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
                                  // Notification Type Badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Dimens.space8,
                                      vertical: Dimens.space2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: iconColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(Dimens.radius8),
                                      border: Border.all(
                                        color: iconColor.withValues(alpha: 0.25),
                                        width: 0.8,
                                      ),
                                    ),
                                    child: Text(
                                      notifType.displayName.toUpperCase(),
                                      style: TextStyle(
                                        color: iconColor,
                                        fontSize: Dimens.fontSize8,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  if (!notification.read)
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
                              const SizedBox(height: Dimens.space6),
                              CustomTextLabelWidget(
                                label: notification.title,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: Dimens.fontSize13,
                                  fontWeight: notification.read ? FontWeight.w600 : FontWeight.w800,
                                ),
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
                                label: _formatNotificationTime(notification.createdAt),
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
            ],
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
              label:
                  "You don't have any notifications right now. Alerts regarding trade signals or accounts will show up here.",
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

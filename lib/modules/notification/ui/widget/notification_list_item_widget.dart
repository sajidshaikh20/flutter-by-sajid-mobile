
import '../../../../utils/exports.dart';

/// Widget that displays a single notification item with title, subtitle, and read status.
class NotificationListItemWidget extends StatelessWidget {
  /// The title of the notification.
  final String? notificationTitle;

  /// The subtitle of the notification.
  final String? notificationSubTitle;

  /// The time when the notification was received.
  final String? notificationTime;

  /// The detailed content of the notification.
  final String? notificationDetails;

  /// The path to the notification icon image.
  final String imagePath;

  /// Whether the notification has been read.
  final bool? isRead;

  /// Callback function called when the notification is tapped.
  final VoidCallback? onTap;

  /// Creates a notification list item widget.
  const NotificationListItemWidget({
    super.key,
    required this.notificationTitle,
    required this.notificationSubTitle,
    required this.notificationDetails,
    required this.notificationTime,
    required this.imagePath,
    required this.isRead,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:
      Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.size16,
              vertical: Dimens.size12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Icon
                    OrderStatusIcon(
                      containerSize: Dimens.size40,
                      containerBg: MainConfig.appColors.backgroundWhite,

                      imageSize: Dimens.size40, svgPath: imagePath,
                    ),
                    const SizedBox(width: Dimens.size16),

                    // Title, Time, and Notification Type
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Title and Time Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Notification Title
                              CustomTextLabelWidget(
                                textAlign: TextAlign.start,
                                maxLines: Dimens.maxLines01,
                                overflow: TextOverflow.ellipsis,
                                label: notificationTitle.toString(),
                                style: context.textTheme.titleLarge?.copyWith(
                                  height: Dimens.lineHeight16
                                      .toLineHeight(Dimens.fontSize14),
                                  fontWeight: FontWeight.w700,
                                  color: MainConfig.appColors.textBlackColor,
                                  fontSize: Dimens.fontSize14,
                                ),
                              ),
                              // Notification Time
                              CustomTextLabelWidget(
                                textAlign: TextAlign.end,
                                label: utcToDateFormate(notificationTime ?? '', DateConstants.dateTimeWithAmPmFormat),
                                style: context.textTheme.titleLarge?.copyWith(
                                  height: Dimens.lineHeight16
                                      .toLineHeight(Dimens.fontSize12),
                                  fontWeight: FontWeight.w400,
                                  color: MainConfig.appColors.creyColor,
                                  fontSize: Dimens.fontSize12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimens.size4),
                          // Notification Type
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CustomTextLabelWidget(
                                textAlign: TextAlign.start,
                                label: notificationSubTitle.toString(),
                                style: context.textTheme.titleLarge?.copyWith(
                                  height: Dimens.lineHeight20
                                      .toLineHeight(Dimens.fontSize14),
                                  fontWeight: FontWeight.w600,
                                  color: MainConfig.appColors.mainColor,
                                  fontSize: Dimens.fontSize14,
                                ),
                              ),

                              // Pink Dot — visible only if isRead == false
                              if (isRead == false)
                                Assets.svgs.icPinkDot.svg(
                                  width: Dimens.size8,
                                  height: Dimens.size8,
                                ),
                            ],
                          ),
                          const SizedBox(height: Dimens.size4),
                          // Notification Details
                          createSpannableTextWithParentheses(
                          context: context,
                            content: notificationDetails.toString(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Divider
          CustomDivider(
            color: MainConfig.appColors.dividerColor,
            height: 1,
          ),
        ],
      ),
    );
  }
}

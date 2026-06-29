import '../../../../utils/exports.dart';

class HomeHeaderAppBar extends StatelessWidget {
  const HomeHeaderAppBar({
    super.key,
    this.showNotification = true,
    this.showProfileImage = true,
    this.title,
    this.subtitle,
  });

  final bool showNotification;
  final bool showProfileImage;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;

    return ListenableBuilder(
      listenable: UserProfileService.instance(),
      builder: (BuildContext context, Widget? child) {
        final UserProfileService profile = UserProfileService.instance();
        final String imageUrl = profile.profilePictureUrl;
        final bool hasImageUrl = imageUrl.isNotEmpty;

        final String name = profile.customerName.isNotEmpty
            ? profile.customerName
            : (profile.username.isNotEmpty ? profile.username : 'Sajid');

        final String initial =
        name.isNotEmpty ? name[0].toUpperCase() : 'S';

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.space16,
            vertical: Dimens.space12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    if (showProfileImage) ...<Widget>[
                      GestureDetector(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: Container(
                          width: Dimens.size40,
                          height: Dimens.size40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: AppColors.primaryGradient,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          padding: const EdgeInsets.all(1.5),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
                            ),
                            padding: const EdgeInsets.all(1.5),
                            child: ClipOval(
                              child: hasImageUrl
                                  ? FastCachedImage(
                                      key: ValueKey<String>(imageUrl),
                                      url: imageUrl,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context, FastCachedProgressData progress) => const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1,
                                          color: AppColors.primaryPurple,
                                        ),
                                      ),
                                      errorBuilder: (BuildContext context, Object exception, StackTrace? stacktrace) => Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: AppColors.primaryButtonGradient,
                                        ),
                                        alignment: Alignment.center,
                                        child: CustomTextLabelWidget(
                                          label: initial,
                                          style: const TextStyle(
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: Dimens.fontSize16,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: AppColors.primaryButtonGradient,
                                      ),
                                      alignment: Alignment.center,
                                      child: CustomTextLabelWidget(
                                        label: initial,
                                        style: const TextStyle(
                                          color: AppColors.whiteColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: Dimens.fontSize16,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: Dimens.space12),
                    ],

                    Expanded(
                      child: title != null
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CustomTextLabelWidget(
                            label: title!,
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimens.fontSize16,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          if (subtitle != null) ...<Widget>[
                            const SizedBox(height: Dimens.space2),
                            CustomTextLabelWidget(
                              label: subtitle!,
                              style: TextStyle(
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                                fontSize: Dimens.fontSize10,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      )
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CustomTextLabelWidget(
                            label: 'Welcome Back,',
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                              fontSize: Dimens.fontSize12,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Flexible(
                                child: CustomTextLabelWidget(
                                  label: name,
                                  style: TextStyle(
                                    color: isDark
                                        ? AppColors.textPrimaryDark
                                        : AppColors.textPrimaryLight,
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimens.fontSize18,
                                  ),
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: Dimens.space4),
                              const CustomTextLabelWidget(
                                label: '👋',
                                style: TextStyle(
                                  fontSize: Dimens.fontSize16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                icon: Icon(
                  Icons.emoji_events_outlined,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                  size: Dimens.size28,
                ),
                onPressed: () async {
                  await context.router.push(const LeaderboardRoute());
                },
              ),
              if (showNotification)
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.notifications_none_rounded,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                        size: Dimens.size28,
                      ),
                      onPressed: () async {
                       // await context.router.push(const NotificationRoute());
                      },
                    ),
                    Positioned(
                      right: Dimens.space10,
                      top: Dimens.space10,
                      child: Container(
                        width: Dimens.size8,
                        height: Dimens.size8,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryPurple,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
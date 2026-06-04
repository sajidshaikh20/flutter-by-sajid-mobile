import '../../../../utils/exports.dart';

class HomeHeaderAppBar extends StatelessWidget {
  const HomeHeaderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    
    return ListenableBuilder(
      listenable: UserProfileService.instance(),
      builder: (BuildContext context, Widget? child) {
        final UserProfileService profile = UserProfileService.instance();
        final String name = profile.customerName.isNotEmpty
            ? profile.customerName
            : (profile.username.isNotEmpty ? profile.username : 'sajid');
        final String initial = name.isNotEmpty ? name[0].toUpperCase() : 'S';

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.space16,
            vertical: Dimens.space12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Left profile avatar + welcome greeting
              Row(
                children: <Widget>[
                  Container(
                    width: Dimens.size40,
                    height: Dimens.size40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryButtonGradient,
                    ),
                    alignment: Alignment.center,
                    child: CustomTextLabelWidget(
                      label: initial,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w800,
                        fontSize: Dimens.fontSize16,
                      ),
                    ),
                  ),
                  const SizedBox(width: Dimens.space12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CustomTextLabelWidget(
                        label: 'Welcome Back,',
                        style: TextStyle(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          fontSize: Dimens.fontSize12,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CustomTextLabelWidget(
                            label: name,
                            style: TextStyle(
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              fontWeight: FontWeight.w800,
                              fontSize: Dimens.fontSize18,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(width: Dimens.space4),
                          const CustomTextLabelWidget(
                            label: '👋',
                            style: TextStyle(fontSize: Dimens.fontSize16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Right notification bell
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.notifications_none_rounded,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      size: Dimens.size28,
                    ),
                    onPressed: () {
                      // Notification tap placeholder
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

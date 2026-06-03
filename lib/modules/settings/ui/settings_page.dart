import '../../../utils/exports.dart';

@RoutePage()
/// Settings page displaying account preferences, support info, and logout.
class SettingsPage extends BaseResponsiveView {
  const SettingsPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _buildView(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _buildView(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _buildView(context);

  Widget _buildView(BuildContext context) {
    return const SettingsView();
  }
}

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  void _showComingSoon(String featureName) {
    context.scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text('$featureName section is coming soon!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showLogoutConfirmation() {
    showCustomDialog(
      'Are you sure you want to log out of your account?',
      title: 'Log Out',
      okBtnTitle: 'Log Out',
      cancelBtnTitle: 'Cancel',
      isDialogHideOnClick: true,
      okBtnTitleStyle: context.textTheme.titleLarge?.copyWith(
        height: Dimens.lineHeight30.toLineHeight(Dimens.fontSize16),
        color: AppColors.errorColor,
        fontWeight: FontWeight.w600,
        fontSize: Dimens.fontSize16,
      ),
      onOkClicked: () async {
        final StackRouter router = context.router;
        // Clear session
        await SharedPref.instance.clearUserDataOnly();
        await UserProfileService.instance().loadUserData();
        unawaited(router.replaceAll(<PageRouteInfo>[const SocialLoginRoute()]));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtitleColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color cardBackground = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color cardBorderColor = isDark ? AppColors.borderDark : AppColors.borderLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Title Header
            Padding(
              padding: const EdgeInsets.only(
                left: Dimens.space20,
                right: Dimens.space20,
                top: Dimens.space16,
                bottom: Dimens.space8,
              ),
              child: CustomTextLabelWidget(
                label: context.appString.navSettingsKey,
                style: TextStyle(
                  color: textColor,
                  fontSize: Dimens.fontSize28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ListenableBuilder(
                  listenable: UserProfileService.instance(),
                  builder: (BuildContext context, Widget? child) {
                    final UserProfileService profile = UserProfileService.instance();


                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Profile Card
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: Dimens.space16,
                            vertical: Dimens.space8,
                          ),
                          decoration: BoxDecoration(
                            color: cardBackground,
                            borderRadius: BorderRadius.circular(Dimens.radius16),
                            border: Border.all(
                              color: cardBorderColor,
                            ),
                          ),
                          child: InkWell(
                            onTap: () => context.router.push(const EditProfileRoute()),
                            borderRadius: BorderRadius.circular(Dimens.radius16),
                            child: Padding(
                              padding: const EdgeInsets.all(Dimens.space16),
                              child: Row(
                                children: <Widget>[
                                  // Avatar
                                  Container(
                                    width: Dimens.size64,
                                    height: Dimens.size64,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: AppColors.primaryGradient,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(2),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: backgroundColor,
                                      ),
                                      padding: const EdgeInsets.all(2),
                                      child: ClipOval(
                                        child: Image.asset(
                                          Assets.png.icUserImage.path,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: Dimens.space16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CustomTextLabelWidget(
                                          label: profile.customerName.isNotEmpty
                                              ? profile.customerName
                                              : 'Guest User',
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: Dimens.fontSize16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        const SizedBox(height: Dimens.space4),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: Dimens.space8,
                                            vertical: Dimens.space2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryPurple.withValues(alpha: 0.12),
                                            borderRadius: BorderRadius.circular(Dimens.radius6),
                                            border: Border.all(
                                              color: AppColors.primaryPurple.withValues(alpha: 0.3),
                                              width: 0.5,
                                            ),
                                          ),
                                          child: const CustomTextLabelWidget(
                                            label: 'CLIENT',
                                            style: TextStyle(
                                              color: AppColors.primaryPurple,
                                              fontSize: Dimens.fontSize10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: Dimens.space4),
                                        CustomTextLabelWidget(
                                          label: profile.customerEmail.isNotEmpty
                                              ? profile.customerEmail
                                              : 'guest@example.com',
                                          style: TextStyle(
                                            color: subtitleColor,
                                            fontSize: Dimens.fontSize12,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                    size: Dimens.size24,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: Dimens.space16),

                        // ACCOUNT SECTION
                        Padding(
                          padding: const EdgeInsets.only(left: Dimens.space20, bottom: Dimens.space10),
                          child: CustomTextLabelWidget(
                            label: context.appString.settingsAccountHeaderKey,
                            style: TextStyle(
                              color: subtitleColor,
                              fontSize: Dimens.fontSize12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: cardBackground,
                              borderRadius: BorderRadius.circular(Dimens.radius16),
                              border: Border.all(color: cardBorderColor, width: 0.5),
                            ),
                            child: Column(
                              children: <Widget>[


                                SettingsListTileWidget(
                                  icon: Icons.lock_outline_rounded,
                                  title: context.appString.settingsSecurityTitleKey,
                                  subtitle: context.appString.settingsSecuritySubtitleKey,
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: subtitleColor,
                                    size: Dimens.size18,
                                  ),
                                  onTap: () => _showComingSoon('Security'),
                                ),
                                _Divider(isDark: isDark),
                                SettingsListTileWidget(
                                  icon: Icons.notifications_none_rounded,
                                  title: context.appString.settingsNotificationsTitleKey,
                                  subtitle: context.appString.settingsNotificationsSubtitleKey,
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: subtitleColor,
                                    size: Dimens.size18,
                                  ),
                                  onTap: () => _showComingSoon('Notifications'),
                                ),
                                _Divider(isDark: isDark),
                                // Appearance (App Theme settings tile)
                                const AppThemeSettingsTile(),
                                _Divider(isDark: isDark),
                                // Language selection
                                SettingsListTileWidget(
                                  icon: Icons.language_rounded,
                                  title: context.appString.settingsLanguageTitleKey,
                                  subtitle: context.isEnglishLanguage ? 'English' : 'العربية',
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: subtitleColor,
                                    size: Dimens.size18,
                                  ),
                                  onTap: () {
                                    if (context.isEnglishLanguage) {
                                      unawaited(LocaleCubit.instance.changeLanguage(AppConstant.ar, AppConstant.rtlLanguageAlignment));
                                    } else {
                                      unawaited(LocaleCubit.instance.changeLanguage(AppConstant.en, AppConstant.defaultLanguageAlignment));
                                    }
                                  },
                                ),
                                _Divider(isDark: isDark),
                                SettingsListTileWidget(
                                  icon: Icons.verified_user_outlined,
                                  title: context.appString.settingsVerificationTitleKey,
                                  subtitle: context.appString.settingsVerificationSubtitleVerifiedKey,
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(right: Dimens.space4),
                                    child: CustomTextLabelWidget(
                                      label: context.appString.settingsVerificationSubtitleVerifiedKey,
                                      style: const TextStyle(
                                        color: AppColors.successColor,
                                        fontSize: Dimens.fontSize13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                                _Divider(isDark: isDark),
                                SettingsListTileWidget(
                                  icon: Icons.card_membership_outlined,
                                  title: context.appString.settingsSubscriptionTitleKey,
                                  subtitle: context.appString.settingsSubscriptionSubtitleKey,
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: subtitleColor,
                                    size: Dimens.size18,
                                  ),
                                  onTap: () => _showComingSoon('Subscription'),
                                ),
                                _Divider(isDark: isDark),
                                SettingsListTileWidget(
                                  icon: Icons.tune_outlined,
                                  title: context.appString.settingsTradingTitleKey,
                                  subtitle: context.appString.settingsTradingSubtitleKey,
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: subtitleColor,
                                    size: Dimens.size18,
                                  ),
                                  onTap: () => _showComingSoon('Trading Preferences'),
                                ),
                                _Divider(isDark: isDark),
                                SettingsListTileWidget(
                                  icon: Icons.analytics_outlined,
                                  title: context.appString.settingsRiskTitleKey,
                                  subtitle: context.appString.settingsRiskSubtitleKey,
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: subtitleColor,
                                    size: Dimens.size18,
                                  ),
                                  onTap: () => _showComingSoon('Risk Settings'),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: Dimens.space24),

                        // SUPPORT SECTION
                        Padding(
                          padding: const EdgeInsets.only(left: Dimens.space20, bottom: Dimens.space10),
                          child: CustomTextLabelWidget(
                            label: context.appString.settingsSupportHeaderKey,
                            style: TextStyle(
                              color: subtitleColor,
                              fontSize: Dimens.fontSize12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: cardBackground,
                              borderRadius: BorderRadius.circular(Dimens.radius16),
                              border: Border.all(color: cardBorderColor, width: 0.5),
                            ),
                            child: Column(
                              children: <Widget>[
                                SettingsListTileWidget(
                                  icon: Icons.help_outline_rounded,
                                  title: context.appString.settingsHelpTitleKey,
                                  subtitle: context.appString.settingsHelpSubtitleKey,
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: subtitleColor,
                                    size: Dimens.size18,
                                  ),
                                  onTap: () => _showComingSoon('Help & Support'),
                                ),
                                _Divider(isDark: isDark),
                                SettingsListTileWidget(
                                  icon: Icons.privacy_tip_outlined,
                                  title: context.appString.settingsPrivacyTitleKey,
                                  subtitle: context.appString.settingsPrivacySubtitleKey,
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: subtitleColor,
                                    size: Dimens.size18,
                                  ),
                                  onTap: () => _showComingSoon('Privacy Policy'),
                                ),
                                _Divider(isDark: isDark),
                                SettingsListTileWidget(
                                  icon: Icons.description_outlined,
                                  title: context.appString.settingsTermsTitleKey,
                                  subtitle: context.appString.settingsTermsSubtitleKey,
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: subtitleColor,
                                    size: Dimens.size18,
                                  ),
                                  onTap: () => _showComingSoon('Terms & Conditions'),
                                ),
                                _Divider(isDark: isDark),
                                SettingsListTileWidget(
                                  icon: Icons.info_outline_rounded,
                                  title: context.appString.settingsAboutTitleKey,
                                  subtitle: context.appString.settingsAboutSubtitleKey,
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: subtitleColor,
                                    size: Dimens.size18,
                                  ),
                                  onTap: () => _showComingSoon('About WEKO'),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Log Out Button
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: Dimens.space16,
                            vertical: Dimens.space28,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.errorColor.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(Dimens.radius12),
                            border: Border.all(
                              color: AppColors.errorColor.withValues(alpha: 0.3),
                            ),
                          ),
                          child: InkWell(
                            onTap: _showLogoutConfirmation,
                            borderRadius: BorderRadius.circular(Dimens.radius12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: Dimens.space16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Icon(
                                    Icons.logout_rounded,
                                    color: AppColors.errorColor,
                                    size: Dimens.size20,
                                  ),
                                  const SizedBox(width: Dimens.space10),
                                  CustomTextLabelWidget(
                                    label: context.appString.settingsLogOutKey,
                                    style: const TextStyle(
                                      color: AppColors.errorColor,
                                      fontSize: Dimens.fontSize14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
}

class _Divider extends StatelessWidget {
  const _Divider({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0.5,
      thickness: 0.5,
      indent: Dimens.space16,
      endIndent: Dimens.space16,
      color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
    );
  }
}

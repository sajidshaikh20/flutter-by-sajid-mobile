import '../../../../utils/exports.dart';
import 'widget/first_login_dialog.dart';

@RoutePage()
class HomePage extends BaseResponsiveView {
  const HomePage({super.key, this.isFromNotification = false});

  final bool? isFromNotification;

  Widget buildview(BuildContext context) {
    final bool isDark = context.isDark;

    return BlocProvider<HomeCubit>(
      create: (BuildContext c) => HomeCubit(
        repository: HomeRepositoryImpl(),
        tradesRepository: TradesRepositoryImpl(),
      )..initData(),
      child: BlocListener<HomeCubit, HomeState>(
        listenWhen: (HomeState previous, HomeState current) =>
            current.firstTimeLogin ?? false,
        listener: (BuildContext context, HomeState state) {
          if (state.firstTimeLogin ?? false) {
            final String role = UserProfileService.instance().roleName
                .toUpperCase();
            if (role == 'CLIENT') {
              context.read<HomeCubit>().dismissFirstTimeLoginPrompt();
              unawaited(
                showDialog<bool>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => const FirstLoginDialog(),
                ),
              );
            } else {
              context.read<HomeCubit>().dismissFirstTimeLoginPrompt();
            }
          }
        },
        child: Scaffold(
          backgroundColor: isDark
              ? AppColors.backgroundDark
              : AppColors.backgroundLight,
          drawer: const HomeNavigationDrawer(),
          body: const SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                HomeHeaderAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        HomePromoBanner(),
                        SizedBox(height: Dimens.space20),
                        HomeOverviewGrid(),
                        SizedBox(height: Dimens.space20),
                        HomeRecentTradesTable(),
                        SizedBox(height: Dimens.space20),
                        // HomeLiveTradesCard(),
                        // const SizedBox(height: Dimens.space20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return buildview(context);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return buildview(context);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return buildview(context);
  }
}

class HomeNavigationDrawer extends StatelessWidget {
  const HomeNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color drawerBg = isDark
        ? AppColors.surfaceDark
        : AppColors.surfaceLight;
    final Color textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final Color subtitleColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    final Color dividerColor = isDark
        ? AppColors.dividerDark
        : AppColors.dividerLight;

    return Drawer(
      backgroundColor: drawerBg,
      child: Column(
        children: <Widget>[
          // Header Profile Details
          ListenableBuilder(
            listenable: UserProfileService.instance(),
            builder: (BuildContext context, Widget? child) {
              final UserProfileService profile = UserProfileService.instance();
              final String name = profile.customerName.isNotEmpty
                  ? profile.customerName
                  : (profile.username.isNotEmpty
                        ? profile.username
                        : 'Guest User');
              final String email = profile.customerEmail.isNotEmpty
                  ? profile.customerEmail
                  : 'guest@example.com';
              final String initial = name.isNotEmpty
                  ? name[0].toUpperCase()
                  : 'G';
              final String imageUrl = profile.profilePictureUrl;
              final bool hasImageUrl = imageUrl.isNotEmpty;

              return Container(
                padding: const EdgeInsets.only(
                  top: 64.0,
                  bottom: 24.0,
                  left: 24.0,
                  right: 24.0,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: dividerColor, width: 0.5),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: Dimens.size50,
                      height: Dimens.size50,
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
                          color: isDark
                              ? AppColors.surfaceDark
                              : AppColors.surfaceLight,
                        ),
                        padding: const EdgeInsets.all(1.5),
                        child: ClipOval(
                          child: hasImageUrl
                              ? FastCachedImage(
                                  key: ValueKey<String>(imageUrl),
                                  url: imageUrl,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (
                                        BuildContext context,
                                        FastCachedProgressData progress,
                                      ) => const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                          color: AppColors.primaryPurple,
                                        ),
                                      ),
                                  errorBuilder:
                                      (
                                        BuildContext context,
                                        Object exception,
                                        StackTrace? stacktrace,
                                      ) => Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient:
                                              AppColors.primaryButtonGradient,
                                        ),
                                        alignment: Alignment.center,
                                        child: CustomTextLabelWidget(
                                          label: initial,
                                          style: const TextStyle(
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: Dimens.fontSize18,
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
                                      fontWeight: FontWeight.w700,
                                      fontSize: Dimens.fontSize18,
                                    ),
                                  ),
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
                            label: name,
                            style: TextStyle(
                              color: textColor,
                              fontSize: Dimens.fontSize15,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: Dimens.space4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.space8,
                              vertical: Dimens.space2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryPurple.withValues(
                                alpha: 0.12,
                              ),
                              borderRadius: BorderRadius.circular(
                                Dimens.radius6,
                              ),
                              border: Border.all(
                                color: AppColors.primaryPurple.withValues(
                                  alpha: 0.3,
                                ),
                                width: 0.5,
                              ),
                            ),
                            child: CustomTextLabelWidget(
                              label: profile.roleName.isNotEmpty
                                  ? profile.roleName
                                  : 'CLIENT',
                              style: const TextStyle(
                                color: AppColors.primaryPurple,
                                fontSize: Dimens.fontSize10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimens.space4),
                          CustomTextLabelWidget(
                            label: email,
                            style: TextStyle(
                              color: subtitleColor,
                              fontSize: Dimens.fontSize11,
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Menu List Options
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                vertical: Dimens.space12,
                horizontal: Dimens.space8,
              ),
              children: <Widget>[
                // Leaderboard Menu
                _buildDrawerItem(
                  context: context,
                  icon: Icons.emoji_events_outlined,
                  title: 'Leaderboard',
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                  onTap: () async {
                    Navigator.pop(context); // Close Drawer
                    await context.router.push(const LeaderboardRoute());
                  },
                ),

                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: dividerColor,
                  indent: Dimens.space16,
                  endIndent: Dimens.space16,
                ),

                // Training Menu
                _buildDrawerItem(
                  context: context,
                  icon: Icons.school_outlined,
                  title: 'Training',
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                  onTap: () async {
                    Navigator.pop(context); // Close Drawer
                    await context.router.push(const TrainingRoute());
                  },
                ),

                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: dividerColor,
                  indent: Dimens.space16,
                  endIndent: Dimens.space16,
                ),

                // Broker Menu
                _buildDrawerItem(
                  context: context,
                  icon: Icons.business_center_outlined,
                  title: 'Broker',
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                  onTap: () async {
                    Navigator.pop(context); // Close Drawer
                    await context.router.push(const BrokerRoute());
                  },
                ),

                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: dividerColor,
                  indent: Dimens.space16,
                  endIndent: Dimens.space16,
                ),

                // Result Menu
                _buildDrawerItem(
                  context: context,
                  icon: Icons.analytics_outlined,
                  title: 'Result',
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                  onTap: () async {
                    Navigator.pop(context); // Close Drawer
                    await context.router.push(const ResultRoute());
                  },
                ),

                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: dividerColor,
                  indent: Dimens.space16,
                  endIndent: Dimens.space16,
                ),

                if (UserProfileService.instance().isTrader) ...<Widget>[
                  // My Clients Menu
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.people_outline_rounded,
                    title: 'My Clients',
                    textColor: textColor,
                    subtitleColor: subtitleColor,
                    onTap: () async {
                      Navigator.pop(context); // Close Drawer
                      await context.router.push(const MyClientsRoute());
                    },
                  ),
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    color: dividerColor,
                    indent: Dimens.space16,
                    endIndent: Dimens.space16,
                  ),
                ],

                // About Us
                _buildDrawerItem(
                  context: context,
                  icon: Icons.info_outline_rounded,
                  title: context.appString.settingsAboutTitleKey,
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                  onTap: () async {
                    Navigator.pop(context); // Close Drawer
                    await Navigator.push(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) =>
                            const InAppWebViewPage(
                              title: 'About WEKO',
                              url: AppConstant.aboutUsUrl,
                            ),
                      ),
                    );
                  },
                ),

                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: dividerColor,
                  indent: Dimens.space16,
                  endIndent: Dimens.space16,
                ),

                // Terms & Conditions
                _buildDrawerItem(
                  context: context,
                  icon: Icons.description_outlined,
                  title: context.appString.settingsTermsTitleKey,
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                  onTap: () async {
                    Navigator.pop(context); // Close Drawer
                    await Navigator.push(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) =>
                            const InAppWebViewPage(
                              title: 'Terms & Conditions',
                              url: AppConstant.termsAndConditionsUrl,
                            ),
                      ),
                    );
                  },
                ),

                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: dividerColor,
                  indent: Dimens.space16,
                  endIndent: Dimens.space16,
                ),

                // Privacy Policy
                _buildDrawerItem(
                  context: context,
                  icon: Icons.privacy_tip_outlined,
                  title: context.appString.settingsPrivacyTitleKey,
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                  onTap: () async {
                    Navigator.pop(context); // Close Drawer
                    await Navigator.push(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) =>
                            const InAppWebViewPage(
                              title: 'Privacy Policy',
                              url: AppConstant.privacyPolicyUrl,
                            ),
                      ),
                    );
                  },
                ),

                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: dividerColor,
                  indent: Dimens.space16,
                  endIndent: Dimens.space16,
                ),

                // Contact Us
                _buildDrawerItem(
                  context: context,
                  icon: Icons.contact_support_outlined,
                  title: context.appString.settingsContactUsTitleKey,
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                  onTap: () async {
                    Navigator.pop(context); // Close Drawer
                    await Navigator.push(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) =>
                            const InAppWebViewPage(
                              title: 'Contact Us',
                              url: AppConstant.contactUsUrl,
                            ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color textColor,
    required Color subtitleColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryPurple, size: Dimens.size22),
      title: CustomTextLabelWidget(
        label: title,
        style: TextStyle(
          color: textColor,
          fontSize: Dimens.fontSize14,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.start,
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right_rounded,
        color: subtitleColor,
        size: Dimens.size18,
      ),
      onTap: onTap,
    );
  }
}

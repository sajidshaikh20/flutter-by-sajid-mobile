import '../../../../utils/exports.dart';

/// Widget that displays the main account form with user options and settings.
class MyAccountForm extends StatelessWidget {
  /// Creates a my account form widget.
  const MyAccountForm({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    // Refresh login status when page is built to catch any changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        //unawaited(context.read<MyAccountCubit>().refreshLoginStatus());
      }
    });

    return BlocConsumer<MyAccountCubit, MyAccountState>(
      listenWhen: (MyAccountState prev, MyAccountState curr) =>
          prev.redirectRoute != curr.redirectRoute || prev.msg != curr.msg,
      listener: (BuildContext context, MyAccountState state) async {
        // Show the message if present
        if (state.msg?.isNotEmpty ?? false) {
          displaySnackBar(state.msg!, context);
        }

        // Handle redirection centrally for logout & delete account
        if (state.redirectRoute != null &&
            (state.status == BaseStateStatus.success &&
                state.logoutStatus == BaseStateStatus.success)) {
          final StackRouter router = context.router;

          // Reset Cubit status to prevent repeated triggers
       //   context.read<MyAccountCubit>().resetLogoutAndDeleteStatus();

          // Navigate first, then clear user data
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if (!context.mounted) return;

            // Navigate to the redirect route
            await router.replaceAll(<PageRouteInfo>[state.redirectRoute!]);

            // Clear user-specific data only (language, country, etc. remain intact)
            await SharedPref.instance.clearUserDataOnly();
          });
        }
      },
      builder: (BuildContext context, MyAccountState state) {
        return NoInternetWidget(
          childWidget: Scaffold(
            backgroundColor: state.isUserLogin
                ? MainConfig.appColors.backgroundLightPinkColor
                : null,
            body: Stack(
              children: <Widget>[
                !state.isUserLogin
                    ? Assets.svgs.bgFullscreenCommon.svg(
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : const SizedBox.shrink(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HomeAppbar(
                      isLastItemDisplay: false,
                      isShadowDisplay: true,
                      title: 'Settings',
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: Dimens.space16.padding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              !state.isUserLogin
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //  Logged-out view
                                        CustomTextLabelWidget(
                                          textAlign: TextAlign.start,
                                          label: context.appString.helloKey,
                                          style: context.textTheme.displayMedium
                                              ?.copyWith(
                                                  color: MainConfig
                                                      .appColors.mainColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: Dimens.fontSize16,
                                                  height: Dimens.lineHeight24
                                                      .toLineHeight(
                                                          Dimens.fontSize16)),
                                        ),
                                        //  Welcome text
                                        CustomTextLabelWidget(
                                          label: context
                                              .appString.welcomeToDukkanKey,
                                          style: context.textTheme.displayMedium
                                              ?.copyWith(
                                                  color: MainConfig
                                                      .appColors.textBlackColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: Dimens.fontSize14,
                                                  height: Dimens.lineHeight18
                                                      .toLineHeight(
                                                          Dimens.fontSize14)),
                                        ),
                                        const SizedBox(height: Dimens.size16),
          
                                        // ✅ Login prompt box
                                        Container(
                                          padding:
                                              const EdgeInsets.all(Dimens.space8),
                                          decoration: BoxDecorationExtension
                                              .customDecoration(
                                            color: MainConfig
                                                .appColors.backgroundWhite,
                                            borderRadius:
                                                Dimens.radius8.borderRadius,
                                            border: Border.all(
                                              color: MainConfig
                                                  .appColors.lightGreyColor,
                                              width: Dimens.borderWidth05,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: CustomTextLabelWidget(
                                                      textAlign: TextAlign.start,
                                                      label: context.appString
                                                          .profileMsgKey,
                                                      maxLines: Dimens.maxLines02,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: context
                                                          .textTheme.displayMedium
                                                          ?.copyWith(
                                                              color: MainConfig
                                                                  .appColors
                                                                  .textBlackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: Dimens
                                                                  .fontSize14,
                                                              height: Dimens
                                                                  .lineHeight18
                                                                  .toLineHeight(Dimens
                                                                      .fontSize14)),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      width: Dimens.space10),
                                                  Assets.svgs.icDAdduser.svg()
                                                ],
                                              ),
                                              const SizedBox(
                                                  height: Dimens.size8),
                                              CustomGradientButtonWidget(
                                                title: context.appString.loginKey,
                                                onTap: () async {


                                                },
                                                height: Dimens.size27,
                                                width: isLanguageAlignmentLTR ? Dimens.size79: Dimens.size85,
                                                titleTextStyle: context
                                                    .textTheme.displayMedium?.copyWith(color: MainConfig.appColors.textWhiteColor, fontWeight:
                                                            FontWeight.w700,
                                                        fontSize:
                                                            Dimens.fontSize14,
                                                        height: Dimens
                                                            .lineHeight16
                                                            .toLineHeight(Dimens
                                                                .fontSize14)),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: Dimens.size16),
          
                                        // ✅ Options list
                                        AccountOptionMenuList(
                                          optionMenuList: loginItems(context),
                                        ),
                                        const SizedBox(height: Dimens.size40),
                                        const SocialMediaWidget(),
                                      ],
                                    )
                                  : LoginedUserProfile(myAccountState: state)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds a list of login-related menu items.
  List<RowItemModel> loginItems(BuildContext context) => <RowItemModel>[
        RowItemModel(
          title: context.appString.languageKey,
          subtitle: AppConstantString.englishText,
        //  route: const ChangeLanguageRoute(),
        ),
        RowItemModel(
          title: context.appString.storeLocationsKey,
        //  route: StoreLocationsRoute(),
        ),
        RowItemModel(
          title: context.appString.aboutAppKey,
          route: CommonWebView(
              title: context.appString.aboutAppKey, url:
          isLanguageAlignmentLTR ? AppConstant.about_us : AppConstant.about_us_ar),
        ),
        RowItemModel(
          title: context.appString.termsAndConditionsKey,
        ),
        RowItemModel(
          title: context.appString.rateTheAppKey,
        ),
      ];
}

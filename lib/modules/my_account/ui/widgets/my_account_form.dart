import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/exports.dart';
import '../../../../app/providers/providers.dart';

/// Widget that displays the main account form with user options and settings.
class MyAccountForm extends ConsumerWidget {
  /// Creates a my account form widget.
  const MyAccountForm({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MyAccountState initialState = MyAccountState.init();
    
    // Listen to state changes
    ref.listen<MyAccountState>(
      myAccountNotifierProvider(initialState),
      (MyAccountState? previous, MyAccountState next) async {
        // Show the message if present
        if (next.msg?.isNotEmpty ?? false) {
          displaySnackBar(next.msg!, context);
        }

        // Handle redirection centrally for logout & delete account
        if (next.redirectRoute != null &&
            (next.status == BaseStateStatus.success &&
                next.logoutStatus == BaseStateStatus.success)) {
          final StackRouter router = context.router;

          // Navigate first, then clear user data
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if (!context.mounted) return;

            // Navigate to the redirect route
            await router.replaceAll(<PageRouteInfo>[next.redirectRoute!]);

            // Clear user-specific data only (language, country, etc. remain intact)
            await SharedPref.instance.clearUserDataOnly();
          });
        }
      },
    );

    final MyAccountState state = ref.watch(myAccountNotifierProvider(initialState));
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
                      title: context.appString.profileKey,
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

        ),
        RowItemModel(
          title: context.appString.termsAndConditionsKey,

        ),
        RowItemModel(
          title: context.appString.rateTheAppKey,
        ),
      ];
}

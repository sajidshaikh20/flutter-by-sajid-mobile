import '../../../../utils/exports.dart';

/// Widget that displays the logged-in user's profile information and account options.
class LoginedUserProfile extends StatelessWidget {
  /// Creates a logged-in user profile widget.
  const LoginedUserProfile({
    super.key,
    required this.myAccountState,
  });

  /// The current account state containing user information.
  final MyAccountState myAccountState;

  @override
  Widget build(BuildContext context) {
    DebugLog.instance.i("${ myAccountState.myAccountInfoModel.firstName}");

    return Column(
      children: <Widget>[
        AccountLoginedUserInfo(userData: myAccountState.myAccountInfoModel), // Pass user data from state
        const SizedBox(
          height: Dimens.size16,
        ),
        AccountOptionMenuList(
          optionMenuList: rowItems(context),
        ),
        const SizedBox(
          height: Dimens.size16,
        ),
        AccountOptionMenuList(
          optionMenuList: settingsItems(context),
        ),
        const SizedBox(
          height: Dimens.size16,
        ),
        AccountOptionMenuList(
          optionMenuList: accountActions(context),
        ),
        const SizedBox(
          height: Dimens.size40,
        ),
        const SocialMediaWidget(),
      ],
    );
  }

  /// Builds a list of row items for the user profile section.
  List<RowItemModel> rowItems(BuildContext context) {
    // Get loyalty points data from the state
    final LoyaltyPointsResponseModel? loyaltyData = myAccountState.loyaltyPointsModel?.data?.isNotEmpty ?? false
        ? myAccountState.loyaltyPointsModel!.data!.first
        : null;

    return <RowItemModel>[
      RowItemModel(
        title: context.appString.myOrdersKey,
        subtitle: loyaltyData?.myOrderCounts?.toString() ?? '0',
      ),
    ];
  }

  /// Builds a list of settings items for account configuration.
  List<RowItemModel> settingsItems(BuildContext context) {
    return <RowItemModel>[
      RowItemModel(
        title: context.appString.languageKey,
        subtitle: context.appString.englishKey,

      ),
      RowItemModel(
          title: context.appString.notificationsSettingsKey,

      ),
      RowItemModel(
          title: context.appString.myAddressesKey, ),
     //# TODO in first phase we don't Gift card but in future its required
     /*RowItemModel(
        title: context.appString.giftCardsKey,
        route: const GiftCardRoute(),
      ),*/
      RowItemModel(
        title: context.appString.myReviewsAndRatingsKey,

      ),
      RowItemModel(
        title: context.appString.referAFriendKey,

      ),
      RowItemModel(
        title: context.appString.contactUsKey,

      ),
      RowItemModel(

        title: context.appString.storeLocationsKey,
      ),
      RowItemModel(
        title: context.appString.faqsKey,

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
        title: context.appString.keyStoreReceiptKey,

      ),
      RowItemModel(
        title: context.appString.rateTheAppKey,
      ),
    ];
  }

  /// Builds a list of account action items like logout.
  List<RowItemModel> accountActions(BuildContext context) => <RowItemModel>[
        RowItemModel(
          title: context.appString.logoutKey,
          isShowDialog: true,

        ),
        RowItemModel(
          isShowDialog: true,
          title: context.appString.deleteAccountKey,
          isDifferentStyle: true,

        ),
      ];
}

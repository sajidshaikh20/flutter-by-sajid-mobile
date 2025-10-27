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
        route: const MyOrderListingRoute(),
      ),
      //# TODO in first phase we don't give loyalty things but in future its required
      /*RowItemModel(
        title: context.appString.loyaltyPointsKey,
        subtitle: loyaltyData?.totalLoyaltyPoints?.toString() ?? '0',
        route: const LoyaltyPointsRoute(),
      ),*/
    /*  RowItemModel(
        route: const MyWalletRoute(),
        title: context.appString.myWalletKey,
        subtitle: loyaltyData?.myWallet?.toString() ?? '0',
      ),*/
    ];
  }

  /// Builds a list of settings items for account configuration.
  List<RowItemModel> settingsItems(BuildContext context) {

    // Get loyalty points data from the state
    final LoyaltyPointsResponseModel? loyaltyData = myAccountState.loyaltyPointsModel?.data?.isNotEmpty ?? false
        ? myAccountState.loyaltyPointsModel!.data!.first
        : null;

   return <RowItemModel>[
      RowItemModel(
        title: context.appString.languageKey,
        subtitle: context.appString.englishKey,
        route: const ChangeLanguageRoute(),
      ),
      RowItemModel(
          title: context.appString.notificationsSettingsKey,
          route:  NotificationSettingRoute(
              orderStatus: loyaltyData?.orderStatus,
              promotionOffers: loyaltyData?.promotionOffers,
              loyalityPoints: loyaltyData?.loyalityPoints
          ),
      ),
      RowItemModel(
          title: context.appString.myAddressesKey, route: ListAddressRoute()),
     //# TODO in first phase we don't Gift card but in future its required
     /*RowItemModel(
        title: context.appString.giftCardsKey,
        route: const GiftCardRoute(),
      ),*/
      RowItemModel(
        title: context.appString.myReviewsAndRatingsKey,
        route: const MyReviewRatingRoute(),
      ),
      RowItemModel(
        title: context.appString.referAFriendKey,
        route: const ReferAFriendRoute(),
      ),
      RowItemModel(
        title: context.appString.contactUsKey,
        route: const ContactUsRoute(),
      ),
      RowItemModel(
        route: StoreLocationsRoute(),
        title: context.appString.storeLocationsKey,
      ),
      RowItemModel(
        title: context.appString.faqsKey,
        route: ViewCmsRoute(
            title: context.appString.faqsKey, url:
        isLanguageAlignmentLTR ? AppConstant.faq : AppConstant.faq_ar
        ),
      ),
      RowItemModel(
        title: context.appString.aboutAppKey,
        route: ViewCmsRoute(
            title: context.appString.aboutAppKey,
            url: isLanguageAlignmentLTR ? AppConstant.about_us : AppConstant.about_us_ar
        ),
      ),
      RowItemModel(
        title: context.appString.termsAndConditionsKey,
        route: ViewCmsRoute(
            title: context.appString.termsAndConditionsKey,
            url: isLanguageAlignmentLTR ? AppConstant.term_conditions: AppConstant.term_conditions_ar),
      ),
      RowItemModel(
        title: context.appString.keyStoreReceiptKey,
        route: const StoreReceiptRoute(),
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

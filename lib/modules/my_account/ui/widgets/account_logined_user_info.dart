import '../../../../utils/exports.dart';

/// Widget that displays logged-in user information and profile details.
class AccountLoginedUserInfo extends StatelessWidget {
  /// The user account information model.
  final MyAccountInfoModel userData;

  /// Creates an account logged-in user info widget.
  const AccountLoginedUserInfo({
    super.key,
    required this.userData,
  });
  @override
  Widget build(BuildContext context) {
    // Get user profile service instance
    final UserProfileService userProfileService = getIt<UserProfileService>();

    // Get user data from login preferences
    final String customerName = userProfileService.customerName;
    final String customerEmail = userProfileService.customerEmail;
    final String phoneNumber = userProfileService.phoneNumber;
    final dynamic rawPrefix = userProfileService.prefix;

    final int phoneNumberPrefix;
    if (rawPrefix == null ||
        rawPrefix == 0 ||
        rawPrefix == "0" ||
        (rawPrefix is String && rawPrefix.isEmpty)) {
      phoneNumberPrefix = AppConstant.defaultCountryCodeInt;
    } else {
      phoneNumberPrefix = rawPrefix;
    }
    DebugLog.instance.i("phoneNumberPrefix $phoneNumberPrefix");
    DebugLog.instance.i("phoneNumberPrefix ${userProfileService.prefix}");

    // Use the first available name (customerName or firstName + lastName)
    final String displayName = customerName.isNotNullOrEmpty
        ? customerName
        : '${userProfileService.firstName} ${userProfileService.lastName}'.trim();

    // Use the first available phone number
    final String displayPhone = (phoneNumber.isNotNullOrEmpty)
        ? '${AppConstant.plus}$phoneNumberPrefix $phoneNumber'
        : '';

    // Get first character of name for avatar, fallback to 'U' if empty
    final String avatarText = displayName.isNotEmpty
        ? displayName[0].toUpperCase()
        : '';

    return DecoratedBox(
      decoration: BoxDecorationExtension.customDecoration(
        color: AppColors.whiteColor,
        borderRadius: Dimens.radius8.borderRadius,
        border: Border.all(
            color: MainConfig.appColors.lightGreyColor, width: Dimens.borderWidth05),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: Dimens.size16,
          ),
          Container(
            alignment: Alignment.center,
            height: Dimens.size52,
            width: Dimens.size52,
            decoration: BoxDecorationExtension.customDecoration(
                color: MainConfig.appColors.iceBlueColor, shape: BoxShape.circle),
            child: CustomTextLabelWidget(
                label: avatarText,
                style: context.textTheme.displayMedium?.copyWith(
                    color: MainConfig.appColors.mainColor,
                    fontWeight: FontWeight.w700,
                    fontSize: Dimens.fontSize24,
                    height:
                        Dimens.lineHeight28.toLineHeight(Dimens.fontSize28))),
          ),
          const SizedBox(
            height: Dimens.size5,
          ),
          CustomTextLabelWidget(
              label: displayName.isNotEmpty ? displayName : '',
              style: context.textTheme.displayMedium?.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w700,
                  fontSize: Dimens.fontSize18,
                  height:
                      Dimens.lineHeight22.toLineHeight(Dimens.fontSize18))),
          const SizedBox(
            height: Dimens.size12,
          ),
          CustomTextLabelWidget(
            textDirection: TextDirection.ltr,
              label:  displayPhone,
              style: context.textTheme.displayMedium?.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimens.fontSize12,
                  height:
                      Dimens.lineHeight16.toLineHeight(Dimens.fontSize12))),
          CustomTextLabelWidget(
              label: customerEmail.isNotNullOrEmpty ? customerEmail : '',
              style: context.textTheme.displayMedium?.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimens.fontSize12,
                  height:
                      Dimens.lineHeight16.toLineHeight(Dimens.fontSize12))),
          const SizedBox(
            height: Dimens.size16,
          ),
          CustomDivider(
              height: Dimens.sizePoint5, color: MainConfig.appColors.lightGreyColor),
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  splashFactory: NoSplash.splashFactory,
                  splashColor: MainConfig.appColors.transparent,
                  highlightColor: MainConfig.appColors.transparent,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  onTap: () async {
                    await context.router.push(
                        EditProfileRoute(editProfile: userData));
                  },
                  child: CustomTextLabelWidget(
                      label: context.appString.editProfileKey,
                      style: context.textTheme.displayMedium?.copyWith(
                          color: MainConfig.appColors.mainColor,
                          fontWeight: FontWeight.w700,
                          fontSize: Dimens.fontSize12,
                          height: Dimens.lineHeight14
                              .toLineHeight(Dimens.fontSize12))),
                ),
              ),
               SizedBox(
                height: Dimens.size32,
                child: VerticalDivider(
                  thickness: .5,
                  width: 0,
                  color: MainConfig.appColors.lightGreyColor,
                ),
              ),
              Expanded(
                child: InkWell(
                  splashFactory: NoSplash.splashFactory,
                  splashColor: MainConfig.appColors.transparent,
                  highlightColor: MainConfig.appColors.transparent,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  onTap: () async {
                    await context.router.push(const ChangePasswordRoute());
                  },
                  child: CustomTextLabelWidget(
                      label: context.appString.changePasswordKey,
                      style: context.textTheme.displayMedium?.copyWith(
                          color: MainConfig.appColors.mainColor,
                          fontWeight: FontWeight.w700,
                          fontSize: Dimens.fontSize12,
                          height: Dimens.lineHeight14
                              .toLineHeight(Dimens.fontSize12))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import '../../../../utils/exports.dart';


/// Widget that displays an individual account menu option item.
class AccountOptionMenuItem extends StatelessWidget {
  /// Creates an account option menu item.
  const AccountOptionMenuItem({
    super.key,
    required this.loginitem,
  });

  /// The row item model containing the menu item data.
  final RowItemModel loginitem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAccountCubit, MyAccountState>(
      buildWhen: (MyAccountState previous, MyAccountState current) {
        // Only rebuild when status changes (for logout/delete account operations)
        return previous.status != current.status;
      },
      builder: (BuildContext context, MyAccountState state) {
        final MyAccountCubit myAccountCubit = context.read<MyAccountCubit>();

        return InkWell(
          splashFactory: NoSplash.splashFactory,
          splashColor: MainConfig.appColors.transparent,
          highlightColor: MainConfig.appColors.transparent,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: () async {
            if (loginitem.route != null) {
              // Use the debounced navigation method to prevent multiple simultaneous navigations
              await myAccountCubit.navigateToRoute(context, loginitem.route!);
            } else if (loginitem.isShowDialog ?? false) {
              if (loginitem.title == context.appString.logoutKey) {
                //  Logout Confirmation Dialog
                showCustomDialog(
                  title: context.appString.logoutKey,
                  context.appString.logoutConformationKey,
                  okBtnTitle: context.appString.yesKey,
                  isDialogHideOnClick: false,
                  barrierDismissible: false,
                  onOkClicked: () async {
                    DebugLog.instance.i('AccountOptionMenuItem: Logout dialog confirmed, closing dialog and calling API');
                    goBack(context);
                    await myAccountCubit.callLogoutAPI();
                  },
                  cancelBtnTitle: context.appString.cancelKey,
                  onCancelClicked: () => goBack(context),
                );
              } else if (loginitem.title == context.appString.deleteAccountKey) {
                // ✅ Delete Account Confirmation Dialog
                showCustomDialog(
                  title: context.appString.deleteAccountKey,
                  context.appString.deleteAccountConformationKey,
                  okBtnTitle: context.appString.yesKey,
                  isDialogHideOnClick : false,
                  barrierDismissible: false,
                  onOkClicked: () async {
                    goBack(context);
                    await myAccountCubit.callDeleteAccountAPI();
                  },
                  cancelBtnTitle: context.appString.cancelKey,
                  onCancelClicked: () => goBack(context),
                );
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: Dimens.space16,
              bottom: Dimens.space16,
              right: Dimens.space8,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // ✅ Title
                Expanded(
                  child: CustomTextLabelWidget(
                    textAlign: TextAlign.start,
                    label: loginitem.title,
                    style: context.textTheme.displayMedium?.copyWith(
                      color: loginitem.isDifferentStyle
                          ? MainConfig.appColors.redColor
                          : MainConfig.appColors.textBlackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: Dimens.fontSize14,
                      height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                    ),
                  ),
                ),
                const SizedBox(width: Dimens.space12),

                // ✅ Subtitle if any
                CustomTextLabelWidget(
                  label: loginitem.subtitle ?? "",
                  textDirection: TextDirection.ltr,
                  style: context.textTheme.displayMedium?.copyWith(
                    color: MainConfig.appColors.mainColor,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimens.fontSize14,
                    height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                  ),
                ),
                const SizedBox(width: Dimens.space12),

                // ✅ Arrow Icon
                RotatedIcon(
                  isLanguageAlignmentLTR: isLanguageAlignmentLTR,
                  iconWidget: Assets.svgs.icRightArrow
                      .svg(height: Dimens.size16, width: Dimens.size16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

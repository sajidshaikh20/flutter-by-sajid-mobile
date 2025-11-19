import '../../../../utils/exports.dart';

/// Widget that displays a list of account menu options.
class AccountOptionMenuList extends StatelessWidget {
  /// Creates an account option menu list.
  const AccountOptionMenuList({super.key, required this.optionMenuList});

  /// The list of menu options to display.
  final List<RowItemModel> optionMenuList;

  @override
  Widget build(BuildContext context) {
    return
      Container(
      padding: const EdgeInsets.only(
        left: Dimens.space8,
      ),
      decoration: BoxDecorationExtension.customDecoration(
        color: AppColors.whiteColor,
        borderRadius: Dimens.radius8.borderRadius,
        border: Border.all(
            color: MainConfig.appColors.lightGreyColor, width: Dimens.borderWidth05),
      ),
      child: CustomListView(
        scrollPhysics: const NeverScrollableScrollPhysics(),
        divColor: MainConfig.appColors.dividerGreyColor,
        divHeight: Dimens.sizePoint5,
        itemBuilder: (BuildContext p0, int position) =>
            AccountOptionMenuItem(loginitem: optionMenuList[position],

            ),
        itemCount: optionMenuList.length,
        isSeparator: true,
        isPadding: true,
      ),
    );
  }
}

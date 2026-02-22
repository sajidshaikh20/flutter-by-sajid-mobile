import '../../../../utils/exports.dart';

/// Profile section row for the home app bar (avatar, user info, balance icon).
class HomeAppBarProfileSection extends StatelessWidget {
  const HomeAppBarProfileSection({
    super.key,
    this.userName,
    this.balance,
    this.profileImagePath,
    this.textColor,
  });

  final String? userName;
  final String? balance;
  final String? profileImagePath;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return _ProfileSectionRow(
      userName: userName,
      balance: balance,
      profileImagePath: profileImagePath,
      textColor: textColor,
    );
  }
}

/// Sub-widget: row layout for profile image, user info, and balance icon.
class _ProfileSectionRow extends StatelessWidget {
  const _ProfileSectionRow({
    this.userName,
    this.balance,
    this.profileImagePath,
    this.textColor,
  });

  final String? userName;
  final String? balance;
  final String? profileImagePath;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        HomeAppBarProfileImage(
          profileImagePath: profileImagePath,
          textColor: textColor,
        ),
        Dimens.space10.widthBox,
        HomeAppBarUserInfoColumn(
          userName: userName,
          balance: balance,
          textColor: textColor,
        ),
        Dimens.space8.widthBox,
        const HomeAppBarBalanceIcon(),
      ],
    );
  }
}

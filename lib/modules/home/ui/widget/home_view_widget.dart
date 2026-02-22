import '../../../../utils/exports.dart';

/// Main home view widget combining all home screen sections.
class HomeViewWidget extends StatelessWidget {
  /// Creates a home view widget.
  const HomeViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gradientStart = MainConfig.appColors.primary;
    final Color gradientEnd = MainConfig.appColors.primaryDark;

    return Container(
    width: double.infinity,
    height: Dimens.size463,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[gradientStart, gradientEnd],
      ),
    ),
    child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.space20,

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Dimens.space10.heightBox,
          const UserGreetingWidget(),
          Dimens.space16.heightBox,
          const BannerCarouselWidget(),
          Dimens.space16.heightBox,
          const WalletCardsWidget(),
          Dimens.space16.heightBox,
          const WalletFundTransferWidget(),
        ],
      ),
    ),
        );
  }
}

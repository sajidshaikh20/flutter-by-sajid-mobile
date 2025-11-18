import '../../../../utils/exports.dart';

/// A circular button widget for accessing FAQ/Help content.
/// 
/// This widget displays a circular button with an FAQ icon that
/// navigates to the terms and conditions page when tapped.
class HomeFaqWidget extends StatelessWidget {
  /// Creates a [HomeFaqWidget].
  const HomeFaqWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
       await context.router.push(CommonWebView(title: "dummy", url: AppConstant.about_us));
      },
      child: Container(
        height: Dimens.size52,
        width: Dimens.size52,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: MainConfig.appColors.mainColor,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.blackColor.withValues(alpha: Dimens.opacity025),
                // Shadow color
                offset: const Offset(Dimens.offset0, Dimens.offset4),
                // Position of the shadow
                blurRadius: Dimens.blurRadius4, // Blurring of the shadow
              ),
            ]),
        child: Padding(
          padding: Dimens.space10.padding,
          child: Assets.svgs.icHomeFaq.svg(),
        ),
      ),
    );
  }
}

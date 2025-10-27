import '../../../utils/exports.dart';

/// Page that displays user's reviews and ratings with pagination.
@RoutePage()
class MyReviewRatingPage extends BaseResponsiveView {
  /// Creates a my review rating page.
  const MyReviewRatingPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) =>
      buildView(context, ScreenType.desktop);

  @override
  Widget buildMobileWidget(BuildContext context) =>
      buildView(context, ScreenType.mobile);

  @override
  Widget buildTabletWidget(BuildContext context) =>
      buildView(context, ScreenType.tablet);

  /// Builds the review rating view with BlocProvider for the specified device type.
  Widget buildView(BuildContext context, ScreenType device) {
    return BlocProvider<MyReviewRatingCubit>(
      create: (BuildContext context) => MyReviewRatingCubit(),
      child: Scaffold(
        backgroundColor: MainConfig.appColors.backgroundWhiteColor,
        body: Column(
          children: <Widget>[
            ProductDetailsAppBar(
              titleText: context.appString.myReviewsAndRatingsKey,
              isLastWidgetDisplay: false,
              titleColors: MainConfig.appColors.textBlackColor,
              prefixIcon: Assets.svgs.icBack.svg(),
            ),
            Expanded(
              child: MyReviewRatingWidget(
                device: device,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays the gift card purchase interface.
class GiftCardPage extends BaseResponsiveView {
  /// Creates a gift card page.
  const GiftCardPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return buildView(context);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return buildView(context);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return buildView(context);
  }

  /// Builds the main view for the gift card page with BlocProvider.
  ///
  /// [context] The build context.
  Widget buildView(BuildContext context) {
    return BlocProvider<GiftCardCubit>(
      create: (BuildContext context) => GiftCardCubit(),
      child: Scaffold(
        backgroundColor: MainConfig.appColors.backgroundLightPinkColor,
        body: const GiftCardPageWidget(),
      ),
    );
  }
}

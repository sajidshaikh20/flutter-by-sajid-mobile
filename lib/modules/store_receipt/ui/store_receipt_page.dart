import '../../../utils/exports.dart';

/// A responsive page that displays store receipts in My Account.
///
/// This page adapts its layout based on the device type (mobile, tablet, desktop)
/// and provides store receipt information to the user.
@RoutePage()
class StoreReceiptPage extends BaseResponsiveView {
  /// Creates a [StoreReceiptPage].
  const StoreReceiptPage({super.key});

  /// Builds the desktop view for the store receipt page.
  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildView(context, ScreenType.desktop);
  }

  /// Builds the mobile view for the store receipt page.
  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildView(context, ScreenType.mobile);
  }

  /// Builds the tablet view for the store receipt page.
  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildView(context, ScreenType.tablet);
  }

  /// Builds the store receipt page with the appropriate [device] type.
  ///
  /// Wraps the page content with a [BlocProvider] for [StoreReceiptCubit]
  /// to manage the state of store receipts.
  BlocProvider<StoreReceiptCubit> _buildView(BuildContext context, ScreenType device) {
    return BlocProvider<StoreReceiptCubit>(
      create: (BuildContext context) =>
          StoreReceiptCubit(cartCountCubit: context.read<CartCountCubit>()),
      child: StoreReceiptPageWidget(device: device),
    );
  }
}

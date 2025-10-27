import '../../../utils/exports.dart';

/// A page that displays available store locations with selection functionality.
/// Can be used for checkout address selection or general store browsing.
@RoutePage()
class StoreLocationsPage extends StatelessWidget {
  /// Whether this page is being used for checkout address selection.
  final bool? isForCheckOut;

  /// The ID of the currently selected address, if any.
  final String? selectedAddressId;

  /// Creates a [StoreLocationsPage].
  ///
  /// [isForCheckOut] indicates if this is for checkout flow.
  /// [selectedAddressId] specifies the currently selected address.
  const StoreLocationsPage(
      {super.key, this.isForCheckOut, this.selectedAddressId});

  /// Builds the view for the store locations page.
  ///
  /// [context] is the build context.
  /// [device] specifies the screen type for responsive design.
  Widget buildView(BuildContext context, ScreenType device) {
    return BlocProvider<StoreLocationsCubit>(
        create: (BuildContext c) => StoreLocationsCubit(
          addressRepositoryImpl: AddressRepositoryImpl(),
        ),
        child: StoreLocationWidget(
          device: device,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return buildView(context, ScreenType.desktop);
  }
}

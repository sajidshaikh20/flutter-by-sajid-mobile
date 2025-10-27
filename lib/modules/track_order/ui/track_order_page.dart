import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays the track order functionality.
class TrackOrderPage extends BaseResponsiveView {
  /// Creates a track order page.
  const TrackOrderPage({required this.orderDetailsResponse, super.key});

  /// The order details response containing order information.
  final MyOrderDetailResponseModel? orderDetailsResponse;

  @override
  Widget buildDesktopWidget(BuildContext context) =>
      _buildView(context, ScreenType.desktop);

  @override
  Widget buildMobileWidget(BuildContext context) =>
      _buildView(context, ScreenType.mobile);

  @override
  Widget buildTabletWidget(BuildContext context) =>
      _buildView(context, ScreenType.tablet);

  /// Builds the track order view with BlocProvider for the specified device type.
  Widget _buildView(BuildContext context, ScreenType device) =>
      BlocProvider<TrackOrderCubit>(
        create: (BuildContext c) => TrackOrderCubit(),
        child: TrackOrderPageWidget(
          orderDetailsResponse: orderDetailsResponse ?? MyOrderDetailResponseModel() ,
          device: device,
        ),
      );
}

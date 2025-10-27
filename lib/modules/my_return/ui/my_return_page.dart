import '../../../utils/exports.dart';

@RoutePage()
/// A responsive widget that displays the MyReturnPage, adapting to different screen sizes.
class MyReturnPage extends BaseResponsiveView {
  /// Constructor to initialize the page.
  const MyReturnPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) =>
      buildView(context, ScreenType.desktop); // Build for desktop view

  @override
  Widget buildMobileWidget(BuildContext context) =>
      buildView(context, ScreenType.mobile); // Build for mobile view

  @override
  Widget buildTabletWidget(BuildContext context) =>
      buildView(context, ScreenType.tablet); // Build for tablet view

  /// Builds the view for the specified device type.
  Widget buildView(BuildContext context, ScreenType device) =>
      BlocProvider<MyReturnCubit>(
        create: (BuildContext context) => MyReturnCubit(), // Provide MyReturnCubit to the widget tree
        child: Scaffold(
          resizeToAvoidBottomInset: false, // Prevent resizing of body on keyboard appearance
          appBar: CustomSearchAppBar(
            device: device, // Pass the device type for app bar customization
            isBackIconVisible: true, // Show back icon in app bar
            onTap: () {
              goBack(context); // Navigate back when tapped
            },
          ),
          body: MyReturnPageWidget(
            device: device, // Pass device type to the page widget
          ),
        ),
      );
}

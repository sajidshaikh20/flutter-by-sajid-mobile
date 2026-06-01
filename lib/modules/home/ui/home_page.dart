import '../../../../utils/exports.dart';

@RoutePage()
class HomePage extends BaseResponsiveView {
  const HomePage({super.key, this.isFromNotification = false});

  final bool? isFromNotification;


  Widget buildview(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (BuildContext c) => HomeCubit(),
      child: const SafeArea(
        child: Scaffold(
          body: Center(
            child: CustomTextLabelWidget(
              label: "Home page",
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return buildview(context);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return buildview(context);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return buildview(context);
  }
}

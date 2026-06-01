import '../../../../utils/exports.dart';

@RoutePage()
class HomePage extends BaseResponsiveView {
  const HomePage({super.key, this.isFromNotification = false});

  final bool? isFromNotification;


  Widget buildview(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (BuildContext c) => HomeCubit(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            title: const CustomTextLabelWidget(label: 'Home'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(Dimens.space16),
            children: <Widget>[
              CustomTextLabelWidget(
                label: 'Settings',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Dimens.space12),
              const AppThemeSettingsTile(),
            ],
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

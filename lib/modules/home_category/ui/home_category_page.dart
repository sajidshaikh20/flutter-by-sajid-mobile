import '../../../utils/exports.dart';

@RoutePage()
class HomeCategoryPage extends BaseResponsiveView {
  const HomeCategoryPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);
  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);
  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<HomeCategoryCubit>(
      create: (BuildContext c) => HomeCategoryCubit(),
      child: const Scaffold(
        body: Center(child: Text('Categories')),
      ),
    );
  }
}

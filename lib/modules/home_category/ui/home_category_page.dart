import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays the home categories section with responsive design.
class HomeCategoryPage extends BaseResponsiveView  {
  /// Creates a home category page.
  const HomeCategoryPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return buildViews(context,ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return buildViews(context,ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return buildViews(context,ScreenType.tablet);
  }

  /// Builds the main view for the home category page with BlocProvider.
  ///
  /// [c] The build context.
  /// [device] The screen type for responsive design.
  Widget buildViews(BuildContext c,ScreenType device) {
    return BlocProvider<HomeCategoryCubit>(
        create: (BuildContext c) => HomeCategoryCubit(homeRepository: HomeRepositoryImpl()),
        child: _pageView(c,device));
  }

  Widget _pageView(BuildContext ctx,ScreenType device) {
    return BlocListener<HomeCategoryCubit, HomeCategoryState>(
      listenWhen: (HomeCategoryState previous, HomeCategoryState current) {
        return current.status != previous.status;
      },
      listener: (BuildContext context, HomeCategoryState state) {
        if (state.msg.isNotNullOrEmpty) {
          displaySnackBar(state.msg.toString(), context);
        }
      },
      child:  HomeCategoryWidget(device: device,),
    );
  }
}

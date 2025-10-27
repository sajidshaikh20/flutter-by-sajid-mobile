import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays the search functionality with product results.
class SearchPage extends BaseResponsiveView {
  /// Creates a search page.
  const SearchPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => buildViews(context,ScreenType.desktop);

  @override
  Widget buildMobileWidget(BuildContext context) => buildViews(context,ScreenType.mobile);

  @override
  Widget buildTabletWidget(BuildContext context) => buildViews(context,ScreenType.tablet);

  /// Builds the search view with BlocProvider for the specified device type.
  Widget buildViews(BuildContext context, ScreenType device) {
    return BlocProvider<SearchCubit>(
      create: (BuildContext context) => SearchCubit(
        repository: SearchRepositoryImpl(),
        intialState: SearchState(
          isLoading: false,
          status: BaseStateStatus.initial,
          searchController: TextEditingController(),
          formKey: GlobalKey<FormState>(),
        ),
      ),
      child:  SearchPageWidget(device: device,),
    );
  }
}

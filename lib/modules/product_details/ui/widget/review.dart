import '../../../../utils/exports.dart';

@RoutePage()
/// Page that displays product reviews and ratings.
class ReviewPage extends BaseResponsiveView {
  /// Creates a review page.
  const ReviewPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildView();
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildView();
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildView();
  }

  Widget _buildView() {
    return _myOrderListView();
  }

  Widget _myOrderListView() {
    return Scaffold(
        backgroundColor: MainConfig.appColors.backgroundWhiteColor,
        appBar: CustomSearchAppBar(
          isBackIconVisible: true,
          onTap: () {
          },
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.space16),
            child: ReviewWidget(entityId: AppConstant.entityIdDefaultInt,),
          ),
        ));
  }
}

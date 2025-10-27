import '../../../utils/exports.dart';

@RoutePage()
/// Page that allows users to cancel their orders with reason selection.
class MyOrderCancelPage extends BaseResponsiveView {
  /// Creates a my order cancel page.
  const MyOrderCancelPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) =>
      _buildView(context, ScreenType.desktop);

  @override
  Widget buildMobileWidget(BuildContext context) =>
      _buildView(context, ScreenType.mobile);

  @override
  Widget buildTabletWidget(BuildContext context) =>
      _buildView(context, ScreenType.tablet);

  Widget _buildView(BuildContext context, ScreenType device) =>
      BlocProvider<MyOrderCancelCubit>(
        create: (_) => MyOrderCancelCubit(
          initialState: MyOrderCancelState(
            commentEditingController: TextEditingController(),
            formKey: GlobalKey<FormState>(),
            cancelReasongList: <String>[
              MainConfig.dynamicString(JsonServiceString.keyIHaveChangedMyMind),
              MainConfig.dynamicString(
                JsonServiceString.keyIBoughtTheWrongItem,
              ),
              MainConfig.dynamicString(
                JsonServiceString.keyIFoundACheaperAlternative,
              ),
              MainConfig.dynamicString(
                JsonServiceString.keyIPlacedADuplicateOrder,
              ),
              MainConfig.dynamicString(
                JsonServiceString.keyOther,
              ),
            ],
            status: BaseStateStatus.initial,
          ),
        ),
        child: MyOrderCancelView(
          device: device,
        ),
      );
}

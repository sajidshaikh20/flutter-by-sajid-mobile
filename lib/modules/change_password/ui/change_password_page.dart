import '../../../../../utils/exports.dart';

/// Page for handling the change password functionality.
///
/// This page extends [BaseResponsiveView] to support responsive layouts
/// for mobile, tablet, and desktop screens.
@RoutePage()
class ChangePasswordPage extends BaseResponsiveView {
  /// Creates a new instance of [ChangePasswordPage].
  const ChangePasswordPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildViews(context,ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildViews(context,ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildViews(context,ScreenType.tablet);
  }

  Widget _buildViews(BuildContext context,ScreenType device) {
    return BlocProvider<ChangePasswordCubit>(
      create: (BuildContext ctx) => ChangePasswordCubit(
          repository: ChangePasswordRepositoryImpl(),
          intialState: ChangePasswordState(
              status: BaseStateStatus.initial,
              cnfPassController: TextEditingController(),
              oldPassController: TextEditingController(),
              newPassController: TextEditingController(),
              oldPassFocusNode: FocusNode(),
              newPassFocusNode: FocusNode(),
              cnfPassFocusNode: FocusNode(),
              formKey: GlobalKey<FormState>())),
      child:  ChangePasswordForm(device: device,),
    );
  }
}

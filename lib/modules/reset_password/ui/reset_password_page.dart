import '../../../../utils/exports.dart';

@RoutePage()
/// Page that displays the reset password form for entering new password.
class ResetPasswordPage extends BaseResponsiveView {
  /// The mobile number associated with the reset password request.
  final String? mobileNumber;

  /// The OTP code for verification.
  final String? otp;

  /// Creates a reset password page.
  const ResetPasswordPage({
    super.key,
    this.mobileNumber = "",
    this.otp = "",
  });

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildViews(context, ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildViews(context, ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildViews(context, ScreenType.tablet);
  }

  Widget _buildViews(BuildContext context, ScreenType device) {
    return BlocProvider<ResetPasswordCubit>(
      create: (BuildContext c) => ResetPasswordCubit(
        repository: ResetPasswordRepoImpl(),
        initialState: ResetPasswordState(
          status: BaseStateStatus.initial,
          newPassController: TextEditingController(),
          conPasswordController: TextEditingController(),
          newPassFocusNode: FocusNode(),
          conPasswordFocusNode: FocusNode(),
          formKey: GlobalKey<FormState>(),
          mobileNumber: mobileNumber ?? "",
        ),
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.appString.resetPasswordKey,
          isLogoVisible: false,
          device: device,
          onTap: () {
            context.router.removeLast();
          },
        ),
        body:Stack(
          children: <Widget>[
        // Background SVG
        Positioned.fill(
        child: Assets.svgs.bgFullscreenCommon.svg(
        fit: BoxFit.fill,),
         ),
        const ResetPasswordPageWidget(),
          ],
        ),
      ),
    );
  }
}

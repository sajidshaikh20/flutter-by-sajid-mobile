import '../../../../utils/exports.dart';

/// A widget that displays a referral code section.
///
/// This widget can adjust its layout or styling based on the type of device
/// (e.g., mobile, tablet, web) using the [device] parameter.
class ReferralCodeWidget extends StatelessWidget {
  /// The type of device to adjust styling and layout accordingly.
  ///
  /// Defaults to [ScreenType.mobile].
  final ScreenType device;

  /// Creates a [ReferralCodeWidget].
  ///
  /// The [device] parameter is optional and defaults to `ScreenType.mobile`.
  const ReferralCodeWidget({super.key, this.device = ScreenType.mobile});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (SignupState previous, SignupState current) {
        // Only rebuild when referral code controller text changes
        return previous.referralCodeController.text != current.referralCodeController.text;
      },
      builder: (BuildContext context, SignupState state) {
        return CommonTextFormFieldWidget(
          isEditable : true,
          device: device,
          maxLength: Dimens.maxLength50,
          controller: state.referralCodeController,
          label: context.appString.referralCodeKey,
          input: TextInputAction.next,
          focusNode: state.referralCodeFocusNode,
          textCapitalization: TextCapitalization.none,
          enableInteractiveSelection: true,
          showCursor: true,
        );
      },
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/exports.dart';
import '../../../../app/providers/providers.dart';
import 'signup_state_helper.dart';

/// A widget that displays a referral code section.
///
/// This widget can adjust its layout or styling based on the type of device
/// (e.g., mobile, tablet, web) using the [device] parameter.
class ReferralCodeWidget extends ConsumerWidget {
  /// The type of device to adjust styling and layout accordingly.
  ///
  /// Defaults to [ScreenType.mobile].
  final ScreenType device;

  /// Creates a [ReferralCodeWidget].
  ///
  /// The [device] parameter is optional and defaults to `ScreenType.mobile`.
  const ReferralCodeWidget({super.key, this.device = ScreenType.mobile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignupState initialState = SignupStateHelper.createInitialState();
    final SignupState state = ref.watch(signupNotifierProvider(initialState));
    
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
  }
}

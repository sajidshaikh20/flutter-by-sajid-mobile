import '../../../../utils/exports.dart';

/// A widget that provides a mobile number input field for adding an address.
///
/// This widget displays a [CustomMobileInputWidget] with country code selection
/// and integrates with [AddressCubit] to manage the mobile number state.
///
/// The layout can adapt based on the [device] type.
class AddAddressMobileNumberWidget extends StatelessWidget {
  /// Creates an [AddAddressMobileNumberWidget].
  ///
  /// The [device] parameter allows customizing the layout for different
  /// screen types (mobile, tablet, web). Defaults to [ScreenType.mobile].
  const AddAddressMobileNumberWidget({
    super.key,
    this.device = ScreenType.mobile,
  });

  /// The type of device to adapt the layout for different screens.
  final ScreenType device;
  @override
  Widget build(BuildContext context) {
    AddressCubit cubit = context.read<AddressCubit>();
    return BlocBuilder<AddressCubit, AddressState>(
      buildWhen: (AddressState previous, AddressState current) {
        return previous.mobileCode != current.mobileCode;
      },
      builder: (BuildContext context, AddressState state) {
        return CustomMobileInputWidget(
          device: device,
            textInputType: TextInputAction.done,
            mobileNumberController: state.mobileNumberEditingController,
            initialCountryCode: state.mobileCode ,
            focusNode: state.mobileNumberFocusNode,
            onCountryCodeChanged: (String? dialCode) {
              cubit.updateMobileCode(dialCode.toString());
            });
      },
    );
  }
}

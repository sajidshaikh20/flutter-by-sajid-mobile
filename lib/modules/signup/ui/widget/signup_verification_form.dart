import 'package:otp_pin_field/otp_pin_field.dart';

import '../../../../utils/exports.dart';

/// Sign up step 2 — sequential email then phone OTP verification.
class SignUpVerificationForm extends StatefulWidget {
  /// Creates [SignUpVerificationForm].
  const SignUpVerificationForm({
    super.key,
    required this.email,
  });

  /// Email passed from basic info via AutoRoute.
  final String email;

  @override
  State<SignUpVerificationForm> createState() => _SignUpVerificationFormState();
}

class _SignUpVerificationFormState extends State<SignUpVerificationForm> {
  final GlobalKey<OtpPinFieldState> _emailOtpKey = GlobalKey<OtpPinFieldState>();
  final GlobalKey<OtpPinFieldState> _phoneOtpKey = GlobalKey<OtpPinFieldState>();

  @override
  Widget build(BuildContext context) {
    final SignUpCubit cubit = context.read<SignUpCubit>();

    return BlocListener<SignUpCubit, SignUpState>(
      listenWhen: (SignUpState p, SignUpState c) =>
          p.showEmailOtpField != c.showEmailOtpField ||
          p.showPhoneOtpField != c.showPhoneOtpField ||
          p.isEmailVerified != c.isEmailVerified ||
          (c.showEmailOtpField &&
              p.emailOtp != c.emailOtp &&
              c.emailOtp.isEmpty) ||
          (c.showPhoneOtpField &&
              p.phoneOtp != c.phoneOtp &&
              c.phoneOtp.isEmpty),
      listener: (BuildContext context, SignUpState state) {
        if (!state.showEmailOtpField) {
          _emailOtpKey.currentState?.clearOtp();
        } else if (state.emailOtp.isEmpty) {
          _emailOtpKey.currentState?.clearOtp();
        }
        if (!state.showPhoneOtpField) {
          _phoneOtpKey.currentState?.clearOtp();
        } else if (state.phoneOtp.isEmpty) {
          _phoneOtpKey.currentState?.clearOtp();
        }
      },
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (BuildContext context, SignUpState state) {
          final String displayEmail =
              widget.email.isNotEmpty ? widget.email : state.email;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.size16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (!state.isEmailVerified) ...<Widget>[
                  _EmailVerificationSection(
                    displayEmail: displayEmail,
                    emailOtpKey: _emailOtpKey,
                    cubit: cubit,
                  ),
                ] else if (!state.isPhoneVerified) ...<Widget>[
                  _PhoneVerificationSection(
                    phoneOtpKey: _phoneOtpKey,
                    cubit: cubit,
                  ),
                ] else ...<Widget>[
                  SignUpStepHeader(
                    title: context.appString.signUpVerificationKey,
                    subtitle: context.appString.signUpVerificationCompleteKey,
                  ),
                  Dimens.size16.heightBox,
                  const Center(
                    child: Icon(
                      Icons.verified_user,
                      color: AppColors.successColor,
                      size: Dimens.size48,
                    ),
                  ),
                ],
                Dimens.size24.heightBox,
              ],
            ),
          );
        },
      ),
    );
  }
}

class _EmailVerificationSection extends StatelessWidget {
  const _EmailVerificationSection({
    required this.displayEmail,
    required this.emailOtpKey,
    required this.cubit,
  });

  final String displayEmail;
  final GlobalKey<OtpPinFieldState> emailOtpKey;
  final SignUpCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState p, SignUpState c) =>
          p.emailErrorMessage != c.emailErrorMessage ||
          p.emailOtpErrorMessage != c.emailOtpErrorMessage ||
          p.showEmailOtpField != c.showEmailOtpField ||
          p.emailResendSecondsRemaining != c.emailResendSecondsRemaining,
      builder: (BuildContext context, SignUpState state) {
        if (!state.showEmailOtpField) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SignUpStepHeader(
                title: context.appString.signUpEmailVerificationKey,
                subtitle: context.appString.signUpEnterEmailToReceiveOtpKey,
              ),
              Dimens.size24.heightBox,
              CommonTextFormFieldWidget(
                controller: state.emailController,
                label: context.appString.signUpEmailAddressKey,
                hint: context.appString.signUpEnterEmailAddressKey,
                input: TextInputAction.done,
                focusNode: state.emailFocusNode,
                errorMsg: state.emailErrorMessage,
                textInputType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                maxLength: Dimens.maxLength50,
                onChange: (String value) {
                  if (value.validateEmailBool() ?? true) {
                    cubit.setEmailError('');
                  }
                },
              ),
              Dimens.size24.heightBox,
              CustomButtonWidget(
                title: context.appString.signUpSendOtpKey,
                height: Dimens.size52,
                borderRadius: Dimens.radius12,
                onTap: () => cubit.sendEmailOtp(context),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SignUpStepHeader(
              title: context.appString.signUpEmailVerificationKey,
              subtitle: context.appString.signUpEmailOtpSentToKey,
            ),
            Dimens.size8.heightBox,
            CustomTextLabelWidget(
              label: displayEmail,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryPurple,
              ),
            ),
            Dimens.size24.heightBox,
            SignUpOtpPinField(
              fieldKey: emailOtpKey,
              onChanged: cubit.setEmailOtp,
              onSubmit: cubit.setEmailOtp,
            ),
            if (state.emailOtpErrorMessage.isNotEmpty) ...<Widget>[
              Dimens.size8.heightBox,
              CustomTextLabelWidget(
                label: state.emailOtpErrorMessage,
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.errorColor,
                ),
              ),
            ],
            Dimens.size24.heightBox,
            CustomButtonWidget(
              title: context.appString.signUpVerifyEmailOtpKey,
              height: Dimens.size52,
              borderRadius: Dimens.radius12,
              onTap: () => cubit.verifyEmailOtp(context),
            ),
            Dimens.size12.heightBox,
            SignUpOtpResendLabel(
              secondsRemaining: state.emailResendSecondsRemaining,
              onResend: () => cubit.resendEmailOtp(context),
            ),
          ],
        );
      },
    );
  }
}

class _PhoneVerificationSection extends StatelessWidget {
  const _PhoneVerificationSection({
    required this.phoneOtpKey,
    required this.cubit,
  });

  final GlobalKey<OtpPinFieldState> phoneOtpKey;
  final SignUpCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState p, SignUpState c) =>
          p.phoneErrorMessage != c.phoneErrorMessage ||
          p.phoneOtpErrorMessage != c.phoneOtpErrorMessage ||
          p.showPhoneOtpField != c.showPhoneOtpField ||
          p.countryDialCode != c.countryDialCode ||
          p.countryIsoCode != c.countryIsoCode ||
          p.phoneResendSecondsRemaining != c.phoneResendSecondsRemaining,
      builder: (BuildContext context, SignUpState state) {
        if (!state.showPhoneOtpField) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SignUpStepHeader(
                title: context.appString.signUpPhoneVerificationKey,
                subtitle: context.appString.signUpEnterPhoneToReceiveOtpKey,
              ),
              Dimens.size24.heightBox,
              SignUpPhoneFieldWidget(
                controller: state.phoneController,
                focusNode: state.phoneFocusNode,
                label: context.appString.mobileNumberKey,
                errorMsg: state.phoneErrorMessage,
                countryIsoCode: state.countryIsoCode,
                dialCode: state.countryDialCode,
                textInputAction: TextInputAction.done,
                onCountryChanged: cubit.updateCountryCode,
                onChanged: (String value) {
                  if (value.isEmpty) {
                    cubit.setPhoneError('');
                    return;
                  }
                  final int? requiredLength = cubit.requiredPhoneLength(
                    state.countryDialCode,
                  );
                  if (requiredLength != null &&
                      value.length == requiredLength) {
                    cubit.setPhoneError('');
                  } else if (requiredLength == null &&
                      value.length >= 6 &&
                      value.length <= 15) {
                    cubit.setPhoneError('');
                  }
                },
              ),
              Dimens.size24.heightBox,
              CustomButtonWidget(
                title: context.appString.signUpSendOtpKey,
                height: Dimens.size52,
                borderRadius: Dimens.radius12,
                onTap: () => cubit.sendPhoneOtp(context),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SignUpStepHeader(
              title: context.appString.signUpPhoneVerificationKey,
              subtitle: context.appString.signUpPhoneOtpSentToKey,
            ),
            Dimens.size8.heightBox,
            CustomTextLabelWidget(
              label: state.fullPhoneNumber,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryPurple,
              ),
            ),
            Dimens.size24.heightBox,
            SignUpOtpPinField(
              fieldKey: phoneOtpKey,
              onChanged: cubit.setPhoneOtp,
              onSubmit: cubit.setPhoneOtp,
            ),
            if (state.phoneOtpErrorMessage.isNotEmpty) ...<Widget>[
              Dimens.size8.heightBox,
              CustomTextLabelWidget(
                label: state.phoneOtpErrorMessage,
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.errorColor,
                ),
              ),
            ],
            Dimens.size24.heightBox,
            CustomButtonWidget(
              title: context.appString.signUpVerifyPhoneOtpKey,
              height: Dimens.size52,
              borderRadius: Dimens.radius12,
              onTap: () => cubit.verifyPhoneOtp(context),
            ),
            Dimens.size12.heightBox,
            SignUpOtpResendLabel(
              secondsRemaining: state.phoneResendSecondsRemaining,
              onResend: () => cubit.resendPhoneOtp(context),
            ),
          ],
        );
      },
    );
  }
}

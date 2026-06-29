import 'package:otp_pin_field/otp_pin_field.dart';
import '../../../utils/exports.dart';
import '../cubit/cubit.dart';
import '../repo/repository.dart';

@RoutePage()
class WhatsAppLoginPage extends StatelessWidget {
  const WhatsAppLoginPage({super.key});

  Widget _buildView(BuildContext context) {
    final bool isDark = context.isDark;
    final Color backgroundColor = isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final Color dotColor = isDark
        ? AppColors.primaryPurple.withValues(alpha: 0.15)
        : AppColors.primaryPurple.withValues(alpha: 0.12);

    final Color titleColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final Color subtitleColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    final bool isRTL = Directionality.of(context) == TextDirection.rtl;
    final GlobalKey<OtpPinFieldState> otpKey = GlobalKey<OtpPinFieldState>();

    return BlocProvider<WhatsAppLoginCubit>(
      create: (BuildContext ctx) => WhatsAppLoginCubit(
        repository: WhatsAppLoginRepositoryImpl(),
        initialState: WhatsAppLoginState(
          status: BaseStateStatus.initial,
          phoneController: TextEditingController(),
          phoneFocusNode: FocusNode(),
        ),
      ),
      child: BlocConsumer<WhatsAppLoginCubit, WhatsAppLoginState>(
        listenWhen: (WhatsAppLoginState previous, WhatsAppLoginState current) {
          return previous.status != current.status || previous.msg != current.msg;
        },
        listener: (BuildContext context, WhatsAppLoginState state) async {
          if (state.msg != null && state.msg!.isNotEmpty) {
            displaySnackBar(state.msg!, context);
            context.read<WhatsAppLoginCubit>().clearMsg();
          }

          if (state.status == BaseStateStatus.loading) {
            unawaited(EasyLoading.show(status: 'Loading...'));
          } else {
            unawaited(EasyLoading.dismiss());
          }

          if (state.status == BaseStateStatus.success && state.redirectRoute != null) {
            await context.router.replaceAll(<PageRouteInfo>[
              state.redirectRoute!,
            ]);
          }
        },
        builder: (BuildContext context, WhatsAppLoginState state) {
          final WhatsAppLoginCubit cubit = context.read<WhatsAppLoginCubit>();

          return Scaffold(
            backgroundColor: backgroundColor,
            resizeToAvoidBottomInset: true,
            body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Positioned.fill(
                  child: CustomPaint(painter: WaveDottedPainter(color: dotColor)),
                ),
                SafeArea(
                  child: Column(
                    children: <Widget>[
                      // Back Arrow
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.size16,
                          vertical: Dimens.size12,
                        ),
                        child: Align(
                          alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => goBack(context),
                            child: RotatedIcon(
                              isLanguageAlignmentLTR: !isRTL,
                              iconWidget: Assets.svgs.icBack.svg(
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Logo
                      DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: isDark
                                  ? AppColors.primaryPurple.withValues(alpha: 0.2)
                                  : AppColors.primaryPurple.withValues(
                                      alpha: 0.08,
                                    ),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Assets.png.icCropWekoIcon.image(
                          height: Dimens.size100,
                          width: Dimens.size100,
                          fit: BoxFit.contain,
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.size16,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Dimens.size20.heightBox,
                                CustomTextLabelWidget(
                                  label: 'WhatsApp Login',
                                  style: context.textTheme.titleLarge?.copyWith(
                                    height: Dimens.lineHeight28.toLineHeight(
                                      Dimens.fontSize24,
                                    ),
                                    fontWeight: FontWeight.w800,
                                    fontSize: Dimens.fontSize24,
                                    color: titleColor,
                                  ),
                                ),
                                Dimens.size8.heightBox,
                                CustomTextLabelWidget(
                                  label: state.isOtpSent
                                      ? 'Enter the 6-digit OTP sent to your WhatsApp'
                                      : 'Connect instantly via WhatsApp OTP',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: subtitleColor,
                                    fontSize: Dimens.fontSize14,
                                  ),
                                ),

                                Dimens.size40.heightBox,

                                if (!state.isOtpSent) ...<Widget>[
                                  SignUpPhoneFieldWidget(
                                    controller: state.phoneController,
                                    focusNode: state.phoneFocusNode,
                                    label: 'WhatsApp Number',
                                    errorMsg: '',
                                    countryIsoCode: state.countryIsoCode,
                                    dialCode: state.countryDialCode,
                                    onCountryChanged: cubit.updateCountryCode,
                                  ),
                                  Dimens.size32.heightBox,
                                  CustomButtonWidget(
                                    title: 'Send OTP',
                                    height: Dimens.size52,
                                    borderRadius: Dimens.radius12,
                                    isButtonEnabled: state.status != BaseStateStatus.loading,
                                    onTap: () => unawaited(cubit.sendOtp()),
                                  ),
                                ] else ...<Widget>[
                                  CustomTextLabelWidget(
                                    label: '${state.countryDialCode} ${state.phone}',
                                    style: context.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryPurple,
                                      fontSize: Dimens.fontSize16,
                                    ),
                                  ),
                                  Dimens.size24.heightBox,
                                  SignUpOtpPinField(
                                    fieldKey: otpKey,
                                    onChanged: cubit.updateOtp,
                                    onSubmit: (String value) {
                                      cubit.updateOtp(value);
                                      unawaited(cubit.verifyOtp());
                                    },
                                  ),
                                  Dimens.size32.heightBox,
                                  CustomButtonWidget(
                                    title: 'Verify & Login',
                                    height: Dimens.size52,
                                    borderRadius: Dimens.radius12,
                                    isButtonEnabled: state.status != BaseStateStatus.loading &&
                                        state.otpCode.length == 6,
                                    onTap: () => unawaited(cubit.verifyOtp()),
                                  ),
                                  Dimens.size16.heightBox,
                                  GestureDetector(
                                    onTap: cubit.resetFlow,
                                    child: CustomTextLabelWidget(
                                      label: 'Change Phone Number',
                                      style: context.textTheme.bodyMedium?.copyWith(
                                        color: AppColors.primaryPurple,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildView(context);
}

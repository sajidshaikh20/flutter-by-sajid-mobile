import '../../../../../utils/exports.dart';



/// Shows the Enter OTP modal bottom sheet (reuses [showCommonBottomSheet]).
/// Call this from Send Money sheet without closing it – OTP sheet stacks on top.
/// State is managed by [EnterOtpCubit]; OTP fields default to "1".
Future<void> showEnterOtpBottomSheet(BuildContext context) async {
  await showCommonBottomSheet<void>(
    context: context,
    child: BlocProvider<EnterOtpCubit>(
      create: (BuildContext context) => EnterOtpCubit(),
      child: const EnterOtpBottomSheetContent(),
    ),
  );
}

/// Content for Enter OTP bottom sheet: title, 5 circular digit fields, Submit, Back.
/// Stateless; [EnterOtpCubit] holds controllers, focus nodes, and OTP state.
class EnterOtpBottomSheetContent extends StatelessWidget {
  const EnterOtpBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    final EnterOtpCubit cubit = context.read<EnterOtpCubit>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimens.space20,
        Dimens.space8,
        Dimens.space20,
        Dimens.space24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CustomTextLabelWidget(
            label: 'Enter OTP',
            textAlign: TextAlign.start,
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: Dimens.fontSize18,
              color: AppColors.blackColor,
            ),
          ),
          Dimens.space24.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List<Widget>.generate(kEnterOtpLength, (int index) {
              return OtpDigitField(
                controller: cubit.controllers[index],
                focusNode: cubit.focusNodes[index],
                onChanged: (String value) {
                  cubit.updateDigit(index, value);
                  if (value.isNotEmpty && index < kEnterOtpLength - 1) {
                    FocusScope.of(context).requestFocus(cubit.focusNodes[index + 1]);
                  }
                },
              );
            }),
          ),
          Dimens.space24.heightBox,
          CustomButtonWidget(
            title: 'Submit',
            onTap: () => _onSubmit(context),
            backgroundColor: AppColors.blackColor,
            height: Dimens.space34,
            borderRadius: Dimens.radius50,
            isPrimaryButton: false,
            titleTextStyle: context.textTheme.titleMedium?.copyWith(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: Dimens.fontSize14,
            ),
          ),
          Dimens.space24.heightBox,
          GestureDetector(
            onTap: () => context.router.maybePop(),
            behavior: HitTestBehavior.opaque,
            child: Center(
              child: CustomTextLabelWidget(
                label: 'Back',
                style: context.textTheme.titleMedium?.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: Dimens.fontSize14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onSubmit(BuildContext context) async {
    hideKeyboard();
    final String otp = context.read<EnterOtpCubit>().otp;
    if (otp.length == kEnterOtpLength) {
      await context.router.maybePop();
      if (context.mounted) {
        await context.router.push(PaymentSuccessRoute());
      }
      return;
    }
    await context.router.maybePop();
  }
}

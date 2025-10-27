import '../../../../utils/exports.dart';

/// Widget that displays alternative authentication options like forgot password.
class OtherAuthView extends StatelessWidget {
  /// Creates an other auth view widget.
  const OtherAuthView({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double forgotPasswordText = Dimens.fontSize14;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        CustomTextLabelWidget(
            label: context.appString.forgotPasswordKey,
            style: context.textTheme.headlineMedium?.copyWith(
              color: AppColors.blackColor,
              height: Dimens.lineHeight20.toLineHeight(forgotPasswordText),
              fontWeight: FontWeight.w600,
              fontSize: forgotPasswordText,
            ),
            onTap: () async {
              await context.router.push(const ForgotPasswordRoute());
            }),
      ],
    );
  }
}

import '../../../../../utils/exports.dart';

/// Shows the Send Money modal bottom sheet (reuses [showCommonBottomSheet]).
/// [sendUpTo] is the limit text, e.g. '₹25,000'.
Future<void> showSendMoneyBottomSheet(
  BuildContext context, {
  required String sendUpTo,
}) async {
  await showCommonBottomSheet<void>(
    context: context,
    child: SendMoneyBottomSheetContent(sendUpTo: sendUpTo),
  );
}

/// Content for Send Money bottom sheet: title, limit, amount field, Send button, Back.
class SendMoneyBottomSheetContent extends StatefulWidget {
  const SendMoneyBottomSheetContent({
    super.key,
    required this.sendUpTo,
  });

  final String sendUpTo;

  @override
  State<SendMoneyBottomSheetContent> createState() =>
      _SendMoneyBottomSheetContentState();
}

class _SendMoneyBottomSheetContentState
    extends State<SendMoneyBottomSheetContent> {
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            label: 'Send Money',
            textAlign: TextAlign.start,
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: Dimens.fontSize18,
              color: AppColors.blackColor,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: CustomRichTextLabel(
              primaryLabel: "You Can Upto ",
              primaryStyle: context.textTheme.bodyMedium?.copyWith(
                  color: MainConfig.appColors.greyTextColor,
                  fontSize: Dimens.fontSize12,
                  fontWeight: FontWeight.w500),
              secondaryLabel: widget.sendUpTo,
              secondaryStyle: context.textTheme.bodyMedium?.copyWith(
                  color: MainConfig.appColors.textBlackColor,
                  fontSize: Dimens.fontSize12,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Dimens.space20.heightBox,
          CommonFormTextField(
            controller: _amountController,
            hint: 'Amount',
            keyboardType: TextInputType.number,
          ),
          Dimens.space20.heightBox,
          CustomButtonWidget(
            title: 'Send Money',
            onTap: () async {
              hideKeyboard();
              await context.router.maybePop();
            },
            backgroundColor: AppColors.blackColor,
            height: Dimens.space34,
            borderRadius: Dimens.radius50,
            isPrimaryButton: false,
            titleTextStyle: context.textTheme.titleMedium?.copyWith(
              color: AppColors.whiteColor,
              fontSize: Dimens.fontSize14,
              fontWeight: FontWeight.w500,
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
                    fontSize: Dimens.fontSize14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

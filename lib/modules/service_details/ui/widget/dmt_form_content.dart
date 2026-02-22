import '../../../../utils/exports.dart';
import 'dmt_form_radio_option.dart';
import 'dmt_form_section_label.dart';

/// DMT form UI – stateless, static fixed layout (exact like design).
/// IMPS selected, Airtel Bank selected. No logic.
class DmtFormContent extends StatelessWidget {
  const DmtFormContent({super.key, required this.dmtLabel});

  final String dmtLabel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.space20,
        vertical: Dimens.space12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CustomTextLabelWidget(
            label: dmtLabel,
            style: context.textTheme.headlineSmall?.copyWith(
              fontSize: Dimens.fontSize18,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
          ),
          Dimens.space24.heightBox,
          const CommonFormTextField(
            hint: 'Sender Mobile Number',
            keyboardType: TextInputType.phone,
            maxLength: Dimens.maxLength10,
          ),
          Dimens.space24.heightBox,
          const DmtFormSectionLabel(label: 'Transaction Type'),
          Dimens.space20.heightBox,
          Row(
            children: <Widget>[
              Expanded(
                child: DmtFormRadioOption(
                  label: 'IMPS',
                  isSelected: true,
                  onTap: () {},
                ),
              ),
              Dimens.space12.widthBox,
              Expanded(
                child: DmtFormRadioOption(
                  label: 'NEFT',
                  isSelected: false,
                  onTap: () {},
                ),
              ),
            ],
          ),
          Dimens.space24.heightBox,
          const DmtFormSectionLabel(label: 'Select Bank'),
          Dimens.space20.heightBox,
          Row(
            children: <Widget>[
              Expanded(
                child: DmtFormRadioOption(
                  label: 'Airtel Bank',
                  isSelected: true,
                  onTap: () {},
                ),
              ),
              Dimens.space12.widthBox,
              Expanded(
                child: DmtFormRadioOption(
                  label: 'Fino Bank',
                  isSelected: false,
                  onTap: () {},
                ),
              ),
            ],
          ),
          Dimens.space32.heightBox,
          CustomButtonWidget(
              height: Dimens.space34,
              backgroundColor: AppColors.blackColor,
              borderRadius: Dimens.radius50,
              isPrimaryButton: false,
              titleTextStyle: context.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontSize: Dimens.fontSize14,
                  fontWeight: FontWeight.w500),
              title: "Search",
              onTap: () {
                unawaited(context.router.maybePop());
                unawaited(context.router.push(const DmtDetailsRoute()));
              }),
          Dimens.space24.heightBox,
        ],
      ),
    );
  }
}

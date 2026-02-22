import '../../../../utils/exports.dart';

const List<_BankItem> _aepsBanks = <_BankItem>[
  _BankItem(name: 'FINO', enabled: true),
  _BankItem(name: 'NSDL', enabled: true),
  _BankItem(name: 'CITY UNION', enabled: false),
];

class _BankItem {
  const _BankItem({required this.name, required this.enabled});
  final String name;
  final bool enabled;
}

/// Shows the "Select Bank" modal bottom sheet (FINO, NSDL, CITY UNION).
/// [aepsLabel] is the AEPS option label (e.g. "AEPS-1", "AEPS-2") used when opening the form sheet on bank select.
Future<void> showSelectBankBottomSheet(
  BuildContext context, {
  required String aepsLabel,
}) async {
  await showCommonBottomSheet<void>(
    context: context,
    child: _SelectBankContent(aepsLabel: aepsLabel),
  );
}

class _SelectBankContent extends StatelessWidget {
  const _SelectBankContent({required this.aepsLabel});

  final String aepsLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(
            Dimens.space20,
            Dimens.space8,
            Dimens.space20,
            Dimens.space16,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CustomTextLabelWidget(
              label: 'Select Bank',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: Dimens.fontSize18,
                color: AppColors.blackColor,
              ),
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            Dimens.space20,
            0,
            Dimens.space20,
            Dimens.space24,
          ),
          itemCount: _aepsBanks.length,
          separatorBuilder: (_, __) => Dimens.space12.heightBox,
          itemBuilder: (BuildContext context, int index) {
            final _BankItem bank = _aepsBanks[index];
            return SelectBankListItem(
              name: bank.name,
              enabled: bank.enabled,
              onBankSelected: bank.enabled
                  ? (String name) async {
                      Navigator.of(context).pop();
                      await showAepsFormBottomSheet(
                        context,
                        aepsLabel: aepsLabel,
                        bankName: name,
                      );
                    }
                  : null,
            );
          },
        ),
      ],
    );
  }
}

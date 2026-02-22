import '../../../../utils/exports.dart';


/// Shows the AEPS transaction form bottom sheet (same common sheet as Select Bank).
/// [aepsLabel] is the title (e.g. "AEPS-1", "AEPS-2"). [bankName] is the selected bank.
Future<void> showAepsFormBottomSheet(
  BuildContext context, {
  required String aepsLabel,
  required String bankName,
}) async {
  await showCommonBottomSheet<void>(
    context: context,
    child: _AepsFormStateful(aepsLabel: aepsLabel, bankName: bankName),
  );
}


class _AepsFormStateful extends StatefulWidget {
  const _AepsFormStateful({
    required this.aepsLabel,
    required this.bankName,
  });

  final String aepsLabel;
  final String bankName;

  @override
  State<_AepsFormStateful> createState() => _AepsFormStatefulState();
}

class _AepsFormStatefulState extends State<_AepsFormStateful> {
  String? _selectedMethod;
  String? _selectedBank;
  final TextEditingController _aadhaarController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _selectedMachine = 'Morpho';

  @override
  void initState() {
    super.initState();
    _selectedBank = widget.bankName;
  }

  @override
  void dispose() {
    _aadhaarController.dispose();
    _mobileController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _clearAll() {
    setState(() {
      _selectedMethod = null;
      _selectedBank = widget.bankName;
      _aadhaarController.clear();
      _mobileController.clear();
      _amountController.clear();
      _selectedMachine = 'Morpho';
    });
  }

  @override
  Widget build(BuildContext context) {
    return _AepsFormContent(
      aepsLabel: widget.aepsLabel,
      selectedMethod: _selectedMethod,
      selectedBank: _selectedBank,
      aadhaarController: _aadhaarController,
      mobileController: _mobileController,
      amountController: _amountController,
      selectedMachine: _selectedMachine,
      onMethodChanged: (String? val) => setState(() => _selectedMethod = val),
      onBankChanged: (String? val) => setState(() => _selectedBank = val),
      onClearAll: _clearAll,
      onMorphoTap: () => setState(() => _selectedMachine = 'Morpho'),
      onMantraTap: () => Navigator.of(context).pop(),
    );
  }
}

/// AEPS form UI – stateless. State is held by [_AepsFormStateful].
class _AepsFormContent extends StatelessWidget {
  const _AepsFormContent({
    super.key,
    required this.aepsLabel,
    required this.selectedMethod,
    required this.selectedBank,
    required this.aadhaarController,
    required this.mobileController,
    required this.amountController,
    required this.selectedMachine,
    required this.onMethodChanged,
    required this.onBankChanged,
    required this.onClearAll,
    required this.onMorphoTap,
    required this.onMantraTap,
  });



  final String aepsLabel;
  final String? selectedMethod;
  final String? selectedBank;
  final TextEditingController aadhaarController;
  final TextEditingController mobileController;
  final TextEditingController amountController;
  final String selectedMachine;
  final ValueChanged<String?> onMethodChanged;
  final ValueChanged<String?> onBankChanged;
  final VoidCallback onClearAll;
  final VoidCallback onMorphoTap;
  final VoidCallback onMantraTap;

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
          AepsFormHeader(
            title: aepsLabel,
            onClearTap: onClearAll,
          ),
          Dimens.space24.heightBox,
          AepsFormDropdownField(
            hint: 'Select Method',
            value: selectedMethod,
            items: AppConstant.methods,
            onChanged: onMethodChanged,
          ),
          Dimens.space14.heightBox,
          AepsFormDropdownField(
            hint: 'Select Bank',
            value: selectedBank,
            items: AppConstant.banks,
            onChanged: onBankChanged,
          ),
          Dimens.space14.heightBox,
          AepsFormTextField(
            controller: aadhaarController,
            hint: 'Aadhaar Number',
            keyboardType: TextInputType.number,
            maxLength: Dimens.maxLength10,
          ),
          Dimens.space14.heightBox,
          AepsFormTextField(
            controller: mobileController,
            hint: 'Mobile Number',
            keyboardType: TextInputType.phone,
            maxLength: Dimens.maxLength10,
          ),
          Dimens.space14.heightBox,
          AepsFormTextField(
            controller: amountController,
            hint: 'Amount',
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
          ),
          Dimens.space24.heightBox,
          CustomTextLabelWidget(
            label: 'Select Machine',
            style: context.textTheme.titleMedium?.copyWith(
              fontSize: Dimens.fontSize13,
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
            ),
          ),
          Dimens.space8.heightBox,
          Row(
            children: <Widget>[
              Expanded(
                child: AepsMachineButton(
                  label: 'Morpho',
                  isSelected: selectedMachine == 'Morpho',
                  onTap: onMorphoTap,
                  selectedColor: MainConfig.appColors.primary,
                ),
              ),
              Dimens.space12.widthBox,
              Expanded(
                child: AepsMachineButton(
                  label: 'Mantra',
                  isSelected: selectedMachine == 'Mantra',
                  onTap: onMantraTap,
                  unselectedColor: MainConfig.appColors.primaryDark,
                ),
              ),
            ],
          ),
          Dimens.space24.heightBox,
        ],
      ),
    );
  }
}

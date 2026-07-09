import '../../../../utils/exports.dart';

class FirstLoginDialog extends StatefulWidget {
  const FirstLoginDialog({super.key});

  @override
  State<FirstLoginDialog> createState() => _FirstLoginDialogState();
}

class _FirstLoginDialogState extends State<FirstLoginDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _balanceController = TextEditingController(text: '1000');
  final TextEditingController _riskController = TextEditingController(text: '1');
  bool _isCustomLoading = false;
  bool _isDefaultLoading = false;

  bool get _isLoading => _isCustomLoading || _isDefaultLoading;

  double get _estimatedRisk {
    final double balance = double.tryParse(_balanceController.text) ?? 0.0;
    final double risk = double.tryParse(_riskController.text) ?? 0.0;
    return (balance * risk) / 100;
  }

  @override
  void initState() {
    super.initState();
    _balanceController.addListener(_onFormChanged);
    _riskController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _balanceController.dispose();
    _riskController.dispose();
    super.dispose();
  }

  Future<void> _submitCustom() async {
    if (!_formKey.currentState!.validate() || _isLoading) return;

    setState(() => _isCustomLoading = true);
    final double balance = double.parse(_balanceController.text);
    final double risk = double.parse(_riskController.text);

    final ResponseHandler<BaseResponse<ClientProfileResponse>> response =
        await ProfileRepositoryImpl().updateBalanceAndRisk(
      amountBalance: balance,
      riskPercentage: risk,
    );

    if (!mounted) return;
    setState(() => _isCustomLoading = false);

    if (response.isSuccess()) {
      final ClientProfileResponse? profile = response.getSuccessInstance()?.response.data;
      if (profile != null) {
        await UserProfileService.instance().updateUserProfile(
          amountBalance: profile.amountBalance,
          riskPercentage: profile.riskPercentage,
          firstTimeLogin: false,
        );
      }
      if (!mounted) return;
      Navigator.of(context).pop(true);
      displaySnackBar('Trading preferences saved: \$${balance.toStringAsFixed(0)} Balance & $risk% Risk.', context);
    } else {
      final String errorMsg = response.getFailureInstance()?.error?.errorMessage ??
          'Unable to save preferences.';
      displaySnackBar(errorMsg, context);
    }
  }

  Future<void> _submitDefault() async {
    if (_isLoading) return;

    setState(() => _isDefaultLoading = true);

    // Call updateBalanceAndRisk with nulls to let the backend use defaults
    final ResponseHandler<BaseResponse<ClientProfileResponse>> response =
        await ProfileRepositoryImpl().updateBalanceAndRisk();

    if (!mounted) return;
    setState(() => _isDefaultLoading = false);

    if (response.isSuccess()) {
      final ClientProfileResponse? profile = response.getSuccessInstance()?.response.data;
      await UserProfileService.instance().updateUserProfile(
        amountBalance: profile?.amountBalance ?? 1000.0,
        riskPercentage: profile?.riskPercentage ?? 1.0,
        firstTimeLogin: false,
      );
      if (!mounted) return;
      Navigator.of(context).pop(true);
      displaySnackBar('Default settings applied: \$1000 Balance & 1% Risk.', context);
    } else {
      final String errorMsg = response.getFailureInstance()?.error?.errorMessage ??
          'Unable to apply default settings.';
      displaySnackBar(errorMsg, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color bgColor = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subTextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color cardColor = isDark ? AppColors.cardDark : AppColors.backgroundLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;

    return PopScope(
      canPop: false,
      child: Dialog(
        elevation: Dimens.elevation4,
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.radius16)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimens.space20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Title & Icon Row
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(Dimens.space8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryPurple.withValues(alpha: 0.15),
                      ),
                      child: const Icon(
                        Icons.trending_up,
                        color: AppColors.primaryPurple,
                        size: Dimens.size20,
                      ),
                    ),
                    const SizedBox(width: Dimens.space10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomTextLabelWidget(
                            label: 'Trading Preferences',
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: textColor,
                              fontSize: Dimens.fontSize16,
                            ),
                          ),
                          const SizedBox(height: 2),
                          CustomTextLabelWidget(
                            label: 'Set your trade parameters to continue.',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: subTextColor,
                              fontSize: Dimens.fontSize11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimens.space20),

                // Side by side input fields
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Balance input
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomTextLabelWidget(
                            label: 'Balance (\$)',
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: textColor,
                              fontSize: Dimens.fontSize12,
                            ),
                          ),
                          const SizedBox(height: Dimens.space6),
                          TextFormField(
                            controller: _balanceController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))
                            ],
                            style: TextStyle(color: textColor, fontSize: Dimens.fontSize13),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: Dimens.space10, vertical: Dimens.space12),
                              prefixIcon: Icon(Icons.attach_money, color: subTextColor, size: Dimens.size16),
                              prefixIconConstraints: const BoxConstraints(minWidth: 30),
                              hintText: '1000',
                              hintStyle: TextStyle(color: subTextColor.withValues(alpha: 0.6), fontSize: Dimens.fontSize13),
                              filled: true,
                              fillColor: cardColor,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimens.radius8),
                                borderSide: BorderSide(color: borderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimens.radius8),
                                borderSide: const BorderSide(color: AppColors.primaryPurple, width: 1.5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimens.radius8),
                                borderSide: const BorderSide(color: AppColors.errorColor),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimens.radius8),
                                borderSide: const BorderSide(color: AppColors.errorColor, width: 1.5),
                              ),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              final double? balance = double.tryParse(value);
                              if (balance == null || balance < 100) {
                                return 'Min \$100';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: Dimens.space12),
                    // Risk input
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomTextLabelWidget(
                            label: 'Risk (%)',
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: textColor,
                              fontSize: Dimens.fontSize12,
                            ),
                          ),
                          const SizedBox(height: Dimens.space6),
                          TextFormField(
                            controller: _riskController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))
                            ],
                            style: TextStyle(color: textColor, fontSize: Dimens.fontSize13),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: Dimens.space10, vertical: Dimens.space12),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: Dimens.space8),
                                child: CustomTextLabelWidget(
                                  label: '%',
                                  style: TextStyle(color: subTextColor, fontWeight: FontWeight.bold, fontSize: Dimens.fontSize12),
                                ),
                              ),
                              suffixIconConstraints: const BoxConstraints(minWidth: 20),
                              hintText: '1',
                              hintStyle: TextStyle(color: subTextColor.withValues(alpha: 0.6), fontSize: Dimens.fontSize13),
                              filled: true,
                              fillColor: cardColor,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimens.radius8),
                                borderSide: BorderSide(color: borderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimens.radius8),
                                borderSide: const BorderSide(color: AppColors.primaryPurple, width: 1.5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimens.radius8),
                                borderSide: const BorderSide(color: AppColors.errorColor),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimens.radius8),
                                borderSide: const BorderSide(color: AppColors.errorColor, width: 1.5),
                              ),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              final double? risk = double.tryParse(value);
                              if (risk == null || risk < 0.1 || risk > 100) {
                                return '0.1 - 100%';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimens.space12),

                // Compact Estimated Risk Row/Card
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.space12, vertical: Dimens.space10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryPurple.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(Dimens.radius8),
                    border: Border.all(color: AppColors.primaryPurple.withValues(alpha: 0.15)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CustomTextLabelWidget(
                        label: 'Estimated Risk Per Trade:',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: subTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: Dimens.fontSize11,
                        ),
                      ),
                      CustomTextLabelWidget(
                        label: '\$${_estimatedRisk.toStringAsFixed(2)}',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: AppColors.primaryPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimens.fontSize13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimens.space20),

                // Continue & Default Buttons Row
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isLoading ? null : () => unawaited(_submitDefault()),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: Dimens.space14),
                          side: BorderSide(color: borderColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Dimens.radius8),
                          ),
                        ),
                        child: _isDefaultLoading
                            ? SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: textColor,
                                ),
                              )
                            : CustomTextLabelWidget(
                                label: 'Use Default',
                                style: TextStyle(
                                  color: _isLoading ? textColor.withValues(alpha: 0.5) : textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: Dimens.fontSize12,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(width: Dimens.space10),
                    Expanded(
                      child: GestureDetector(
                        onTap: _isLoading ? null : () => unawaited(_submitCustom()),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: Dimens.space14),
                          decoration: BoxDecoration(
                            gradient: _isLoading ? null : AppColors.primaryButtonGradient,
                            color: _isLoading ? (isDark ? Colors.white10 : Colors.black12) : null,
                            borderRadius: BorderRadius.circular(Dimens.radius8),
                          ),
                          child: Center(
                            child: _isCustomLoading
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.whiteColor,
                                    ),
                                  )
                                : const CustomTextLabelWidget(
                                    label: 'Continue',
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: Dimens.fontSize12,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

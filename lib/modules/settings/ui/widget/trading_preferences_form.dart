import '../../../../utils/exports.dart';
import '../../cubit/trading_preferences_cubit.dart';
import '../../cubit/trading_preferences_state.dart';

class TradingPreferencesForm extends StatelessWidget {
  const TradingPreferencesForm({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TradingPreferencesCubit cubit = context
        .read<TradingPreferencesCubit>();
    final bool isDark = context.isDark;
    final Color backgroundColor = isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final Color tileColor = isDark
        ? AppColors.surfaceDark
        : AppColors.surfaceLight;
    final Color textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final Color subTextColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    final Color inputFieldBg = isDark
        ? AppColors.cardDark
        : AppColors.backgroundLight;
    final Color borderCol = isDark
        ? AppColors.borderDark
        : AppColors.borderLight;

    return BlocListener<TradingPreferencesCubit, TradingPreferencesState>(
      listenWhen:
          (TradingPreferencesState previous, TradingPreferencesState current) =>
              (previous.status == BaseStateStatus.loading &&
                  current.status == BaseStateStatus.success) ||
              current.status == BaseStateStatus.failure,
      listener: (BuildContext context, TradingPreferencesState state) {
        if (state.status == BaseStateStatus.success &&
            state.msg != null &&
            state.msg!.isNotEmpty) {
          displaySnackBar(state.msg!, context);
        } else if (state.status == BaseStateStatus.failure &&
            state.msg != null &&
            state.msg!.isNotEmpty) {
          displaySnackBar(state.msg!, context);
        }
      },
      child: BlocBuilder<TradingPreferencesCubit, TradingPreferencesState>(
        builder: (BuildContext context, TradingPreferencesState state) {
          final double estimatedRisk =
              (state.amountBalance * state.riskPercentage) / 100;
          final bool isLoading =
              state.status == BaseStateStatus.loading &&
              (state.msg == null || state.msg!.isEmpty);
          final bool isSaving =
              state.status == BaseStateStatus.loading &&
              state.msg == 'Saving...';

          return Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  // Premium Header custom implementation
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.space16,
                      vertical: Dimens.space12,
                    ),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => context.router.back(),
                          child: Container(
                            padding: const EdgeInsets.all(Dimens.space8),
                            decoration: BoxDecoration(
                              color: tileColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: textColor,
                              size: Dimens.size16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: Dimens.size32,
                              ),
                              child: CustomTextLabelWidget(
                                label: 'Trading Preferences',
                                style: TextStyle(
                                  fontSize: Dimens.fontSize18,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(Dimens.space24),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            CustomTextLabelWidget(
                              label:
                                  'Set up your default trading preferences below. These values will be used to calculate lot sizes automatically during trade execution.',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: subTextColor,
                              ),
                            ),
                            const SizedBox(height: Dimens.space24),

                            // Account Balance
                            CustomTextLabelWidget(
                              label: 'Account Balance (\$)',
                              style: context.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: Dimens.space8),
                            TextFormField(
                              controller: cubit.balanceController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d*'),
                                ),
                              ],
                              style: TextStyle(color: textColor),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.attach_money,
                                  color: subTextColor,
                                  size: Dimens.size20,
                                ),
                                hintText: '1000',
                                hintStyle: TextStyle(
                                  color: subTextColor.withValues(alpha: 0.6),
                                ),
                                filled: true,
                                fillColor: inputFieldBg,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Dimens.radius10,
                                  ),
                                  borderSide: BorderSide(color: borderCol),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Dimens.radius10,
                                  ),
                                  borderSide: const BorderSide(
                                    color: AppColors.primaryPurple,
                                    width: 1.5,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Dimens.radius10,
                                  ),
                                  borderSide: const BorderSide(
                                    color: AppColors.errorColor,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Dimens.radius10,
                                  ),
                                  borderSide: const BorderSide(
                                    color: AppColors.errorColor,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter account balance';
                                }
                                final double? balance = double.tryParse(value);
                                if (balance == null || balance < 100) {
                                  return 'Minimum balance is \$100';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: Dimens.space20),

                            // Risk Per Trade
                            CustomTextLabelWidget(
                              label: 'Risk Per Trade (%)',
                              style: context.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: Dimens.space8),
                            TextFormField(
                              controller: cubit.riskController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d*'),
                                ),
                              ],
                              style: TextStyle(color: textColor),
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(Dimens.space12),
                                  child: CustomTextLabelWidget(
                                    label: '%',
                                    style: TextStyle(
                                      color: subTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                hintText: '1',
                                hintStyle: TextStyle(
                                  color: subTextColor.withValues(alpha: 0.6),
                                ),
                                filled: true,
                                fillColor: inputFieldBg,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Dimens.radius10,
                                  ),
                                  borderSide: BorderSide(color: borderCol),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Dimens.radius10,
                                  ),
                                  borderSide: const BorderSide(
                                    color: AppColors.primaryPurple,
                                    width: 1.5,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Dimens.radius10,
                                  ),
                                  borderSide: const BorderSide(
                                    color: AppColors.errorColor,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Dimens.radius10,
                                  ),
                                  borderSide: const BorderSide(
                                    color: AppColors.errorColor,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter risk percentage';
                                }
                                final double? risk = double.tryParse(value);
                                if (risk == null || risk < 0.1 || risk > 100) {
                                  return 'Enter value between 0.1 and 100';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: Dimens.space24),

                            // Estimated Risk Card
                            Container(
                              padding: const EdgeInsets.all(Dimens.space16),
                              decoration: BoxDecoration(
                                color: AppColors.primaryPurple.withValues(
                                  alpha: 0.05,
                                ),
                                borderRadius: BorderRadius.circular(
                                  Dimens.radius12,
                                ),
                                border: Border.all(
                                  color: AppColors.primaryPurple.withValues(
                                    alpha: 0.15,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  CustomTextLabelWidget(
                                    label: 'Estimated Risk Per Trade',
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                          color: subTextColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  const SizedBox(height: Dimens.space4),
                                  CustomTextLabelWidget(
                                    label:
                                        '\$${estimatedRisk.toStringAsFixed(2)}',
                                    style: context.textTheme.headlineMedium
                                        ?.copyWith(
                                          color: AppColors.primaryPurple,
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                  const SizedBox(height: Dimens.space4),
                                  CustomTextLabelWidget(
                                    label:
                                        'Based on your current balance and selected risk percentage.',
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                          fontSize: Dimens.fontSize10,
                                          color: subTextColor,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: Dimens.space32),

                            // Save Preferences Button
                            CustomButtonWidget(
                              title: 'Save Changes',
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  unawaited(cubit.savePreferences());
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import '../../../utils/exports.dart';

@RoutePage()
/// Page for calculating FX Position Size and Pip values based on account balance, risk, stop loss, and lot size.
class PipCalculatorPage extends BaseResponsiveView {
  const PipCalculatorPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<PipCalculatorCubit>(
      create: (BuildContext context) => PipCalculatorCubit(),
      child: const PipCalculatorViewBody(),
    );
  }
}

class PipCalculatorViewBody extends StatefulWidget {
  const PipCalculatorViewBody({super.key});

  @override
  State<PipCalculatorViewBody> createState() => _PipCalculatorViewBodyState();
}

class _PipCalculatorViewBodyState extends State<PipCalculatorViewBody> {
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _riskController = TextEditingController();
  final TextEditingController _stopLossController = TextEditingController();
  final TextEditingController _lotController = TextEditingController();

  final FocusNode _balanceFocusNode = FocusNode();
  final FocusNode _riskFocusNode = FocusNode();
  final FocusNode _stopLossFocusNode = FocusNode();
  final FocusNode _lotFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final PipCalculatorState state = context.read<PipCalculatorCubit>().state;
    _balanceController.text = state.balance != null ? state.balance.toString() : '';
    _riskController.text = state.riskPercentage != null ? state.riskPercentage.toString() : '';
    _stopLossController.text = state.stopLoss != null ? state.stopLoss.toString() : '';
    _lotController.text = state.lotSize != null ? state.lotSize.toString() : '';
  }

  @override
  void dispose() {
    _balanceController.dispose();
    _riskController.dispose();
    _stopLossController.dispose();
    _lotController.dispose();
    _balanceFocusNode.dispose();
    _riskFocusNode.dispose();
    _stopLossFocusNode.dispose();
    _lotFocusNode.dispose();
    super.dispose();
  }

  String _getCurrencySymbol(String currency) {
    switch (currency) {
      case 'USD':
        return r'$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      case 'AUD':
        return r'A$';
      case 'CAD':
        return r'C$';
      case 'CHF':
        return 'CHF';
      case 'NZD':
        return r'NZ$';
      default:
        return currency;
    }
  }



  void _showPairSelector(BuildContext context, PipCalculatorState state) {
    unawaited(showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext sheetContext) {
        final bool isDark = context.isDark;
        final Color bg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
        final Color textCol = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

        return Container(
          padding: const EdgeInsets.all(Dimens.space24),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimens.radius24),
              topRight: Radius.circular(Dimens.radius24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: Dimens.size40,
                height: Dimens.size4,
                margin: const EdgeInsets.only(bottom: Dimens.space20),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white24 : Colors.black26,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              CustomTextLabelWidget(
                label: 'Select Currency Pair',
                style: TextStyle(
                  color: textCol,
                  fontSize: Dimens.fontSize18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Dimens.space16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: PipCalculatorCubit.currencyPairs.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    final Map<String, dynamic> pair = PipCalculatorCubit.currencyPairs[index];
                    final String name = pair['name'] as String;
                    final double val = pair['value'] as double;
                    return ListTile(
                      leading: CurrencyFlagWidget(currencyOrPair: name),
                      title: CustomTextLabelWidget(
                        label: name,
                        style: TextStyle(
                          color: textCol,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      trailing: state.selectedCurrencyName == name
                          ? const Icon(Icons.check_circle, color: AppColors.primaryPurple)
                          : null,
                      onTap: () {
                        context.read<PipCalculatorCubit>().selectCurrencyPair(name, val);
                        Navigator.pop(sheetContext);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    ));
  }

  void _showInfoDialog(BuildContext context) {
    unawaited(showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        backgroundColor: context.isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        title: CustomTextLabelWidget(
          label: 'About Forex Calculator',
          style: TextStyle(
            color: context.isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: CustomTextLabelWidget(
          label: 'This calculator provides both Position Size and Pip Value tools.\n\nPosition Size helps calculate your exact standard lot sizes based on stop loss and account risk percentage.\n\nPip Value calculates the exact value of 1 pip based on lot size.',
          style: TextStyle(
            color: context.isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
          textAlign: TextAlign.start,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const CustomTextLabelWidget(
              label: 'Close',
              style: TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    ));
  }



  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color pageBg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderCol = isDark ? AppColors.borderDark : AppColors.borderLight;

    return BlocListener<PipCalculatorCubit, PipCalculatorState>(
      listenWhen: (PipCalculatorState prev, PipCalculatorState curr) =>
          prev.selectedCurrencyName != curr.selectedCurrencyName,
      listener: (BuildContext context, PipCalculatorState state) {
        // Results are reset inside the cubit upon currency change.
      },
      child: BlocBuilder<PipCalculatorCubit, PipCalculatorState>(
        builder: (BuildContext context, PipCalculatorState state) {
          return Scaffold(
            backgroundColor: pageBg,
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  // Header
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
                              color: cardBg,
                              shape: BoxShape.circle,
                              border: Border.all(color: borderCol),
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
                            child: CustomTextLabelWidget(
                              label: 'Position Size Calculator',
                              style: TextStyle(
                                fontSize: Dimens.fontSize18,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _showInfoDialog(context),
                          child: Container(
                            padding: const EdgeInsets.all(Dimens.space8),
                            decoration: BoxDecoration(
                              color: cardBg,
                              shape: BoxShape.circle,
                              border: Border.all(color: borderCol),
                            ),
                            child: Icon(
                              Icons.info_outline_rounded,
                              color: textColor,
                              size: Dimens.size16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: Dimens.space8),
                          // Header Graphic Banner
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: isDark ? AppColors.darkPromoBannerGradient : AppColors.lightPromoBannerGradient,
                              borderRadius: BorderRadius.circular(Dimens.radius16),
                              border: Border.all(color: borderCol),
                            ),
                            padding: const EdgeInsets.all(Dimens.space16),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      CustomTextLabelWidget(
                                        label: state.activeTab == 'position'
                                            ? 'Calculate your position size based on proper risk management'
                                            : 'Calculate pip value for any currency pair',
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: Dimens.fontSize16,
                                          fontWeight: FontWeight.bold,
                                          height: 1.3,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: Dimens.space8),
                                const HeaderGraphic(),
                              ],
                            ),
                          ),
                          const SizedBox(height: Dimens.space24),

                          // Tab switcher
                          PipCalculatorTabSwitcher(
                            activeTab: state.activeTab,
                            onTabChanged: (String tab) {
                              context.read<PipCalculatorCubit>().updateActiveTab(tab);
                            },
                          ),
                          const SizedBox(height: Dimens.space24),

                          // Form inputs depending on the active tab with swap animation
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              switchInCurve: Curves.easeIn,
                              switchOutCurve: Curves.easeOut,
                              child: state.activeTab == 'position'
                                  ? Column(
                                      key: const ValueKey<String>('position_form_fields'),
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CommonTextFormFieldWidget(
                                          controller: _balanceController,
                                          focusNode: _balanceFocusNode,
                                          fillColor: cardBg,
                                          label: "Account Balance",
                                          borderColor: borderCol,
                                          hint: 'Enter balance',
                                          hintStyle: TextStyle(
                                            color: subtextColor.withValues(alpha: 0.5),
                                            fontSize: Dimens.fontSize14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textInputType: const TextInputType.numberWithOptions(decimal: true),
                                          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                                          onChange: (String val) {
                                            final double? d = double.tryParse(val);
                                            context.read<PipCalculatorCubit>().updateBalance(d);
                                          },
                                        ),
                                        const SizedBox(height: Dimens.space20),

                                        CommonTextFormFieldWidget(
                                          controller: _riskController,
                                          focusNode: _riskFocusNode,
                                          fillColor: cardBg,
                                          label: "Risk %",
                                          borderColor: borderCol,
                                          hint: 'e.g. 2',
                                          hintStyle: TextStyle(
                                            color: subtextColor.withValues(alpha: 0.5),
                                            fontSize: Dimens.fontSize14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textInputType: const TextInputType.numberWithOptions(decimal: true),
                                          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                                          suffix: Padding(
                                            padding: const EdgeInsets.only(right: Dimens.space12),
                                            child: CustomTextLabelWidget(
                                              label: '%',
                                              style: TextStyle(color: subtextColor, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          onChange: (String val) {
                                            final double? d = double.tryParse(val);
                                            context.read<PipCalculatorCubit>().updateRiskPercentage(d);
                                          },
                                        ),
                                        const SizedBox(height: Dimens.space20),

                                        CommonTextFormFieldWidget(
                                          controller: _stopLossController,
                                          focusNode: _stopLossFocusNode,
                                          fillColor: cardBg,
                                          label: "Stop Loss (pips)",
                                          borderColor: borderCol,
                                          hint: 'e.g. 20',
                                          hintStyle: TextStyle(
                                            color: subtextColor.withValues(alpha: 0.5),
                                            fontSize: Dimens.fontSize14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textInputType: const TextInputType.numberWithOptions(decimal: true),
                                          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                                          suffix: Padding(
                                            padding: const EdgeInsets.only(right: Dimens.space12),
                                            child: CustomTextLabelWidget(
                                              label: 'pips',
                                              style: TextStyle(color: subtextColor, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          onChange: (String val) {
                                            final double? d = double.tryParse(val);
                                            context.read<PipCalculatorCubit>().updateStopLoss(d);
                                          },
                                        ),
                                        const SizedBox(height: Dimens.space20),
                                      ],
                                    )
                                  : Column(
                                      key: const ValueKey<String>('pip_form_fields'),
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CommonTextFormFieldWidget(
                                          controller: _lotController,
                                          focusNode: _lotFocusNode,
                                          fillColor: cardBg,
                                          label: "Lot Size",
                                          borderColor: borderCol,
                                          hint: '0.01',
                                          hintStyle: TextStyle(
                                            color: subtextColor.withValues(alpha: 0.5),
                                            fontSize: Dimens.fontSize14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textInputType: const TextInputType.numberWithOptions(decimal: true),
                                          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                                          suffix: Padding(
                                            padding: const EdgeInsets.only(right: Dimens.space12),
                                            child: CustomTextLabelWidget(
                                              label: 'Lots',
                                              style: TextStyle(color: subtextColor, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          onChange: (String val) {
                                            final double? d = double.tryParse(val);
                                            context.read<PipCalculatorCubit>().updateLotSize(d);
                                          },
                                        ),
                                      ],
                                    ),
                            ),
                          ),

                          // Currency Pair selector dropdown style
                          CustomTextLabelWidget(
                            label: 'Currency Pair',
                            style: TextStyle(
                              color: subtextColor,
                              fontSize: Dimens.fontSize13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: Dimens.space8),
                          GestureDetector(
                            onTap: () => _showPairSelector(context, state),
                            child: Container(
                              height: 52,
                              padding: const EdgeInsets.symmetric(horizontal: Dimens.space12),
                              decoration: BoxDecoration(
                                color: cardBg,
                                borderRadius: BorderRadius.circular(Dimens.radius12),
                                border: Border.all(color: borderCol),
                              ),
                              child: Row(
                                children: <Widget>[
                                  CurrencyFlagWidget(currencyOrPair: state.selectedCurrencyName),
                                  const SizedBox(width: Dimens.space12),
                                  CustomTextLabelWidget(
                                    label: state.selectedCurrencyName,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: Dimens.fontSize15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(Icons.keyboard_arrow_down_rounded, color: subtextColor),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimens.space28),

                          // Calculate Button
                          GestureDetector(
                            onTap: () {
                              _balanceFocusNode.unfocus();
                              _riskFocusNode.unfocus();
                              _stopLossFocusNode.unfocus();
                              _lotFocusNode.unfocus();

                              if (state.activeTab == 'position') {
                                context.read<PipCalculatorCubit>().calculatePositionSize();
                              } else {
                                context.read<PipCalculatorCubit>().calculatePipValue();
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 52,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimens.radius12),
                                color: AppColors.primaryPurple,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.calculate_outlined, color: Colors.white),
                                  SizedBox(width: Dimens.space8),
                                  CustomTextLabelWidget(
                                    label: 'Calculate',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimens.fontSize16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimens.space24),

                          // Animated Results Card
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              switchInCurve: Curves.easeIn,
                              switchOutCurve: Curves.easeOut,
                              child: (state.activeTab == 'position' && state.positionSize != null)
                                  ? Container(
                                      key: const ValueKey<String>('position_results_card'),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: isDark ? const Color(0xFF0F0B22) : Colors.white,
                                        borderRadius: BorderRadius.circular(Dimens.radius16),
                                        border: Border.all(
                                          color: isDark ? AppColors.borderDark : AppColors.borderLight,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(Dimens.space16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                width: 48,
                                                height: 48,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.primaryPurple.withValues(alpha: 0.15),
                                                ),
                                                alignment: Alignment.center,
                                                child: const Icon(Icons.assessment_outlined,
                                                    color: AppColors.primaryPurple, size: Dimens.size24),
                                              ),
                                              const SizedBox(width: Dimens.space12),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  CustomTextLabelWidget(
                                                    label: 'Required Position Size',
                                                    style: TextStyle(
                                                      color: subtextColor,
                                                      fontSize: Dimens.fontSize12,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  CustomTextLabelWidget(
                                                    label: '${state.positionSize!.toStringAsFixed(2)} Lots',
                                                    style: const TextStyle(
                                                      color: AppColors.primaryPurple,
                                                      fontSize: Dimens.fontSize24,
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  CustomTextLabelWidget(
                                                    label: 'Standard Lots',
                                                    style: TextStyle(
                                                      color: subtextColor,
                                                      fontSize: Dimens.fontSize11,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: Dimens.space16),
                                          const Divider(color: AppColors.borderDark, height: 1),
                                          const SizedBox(height: Dimens.space16),
                                          CalculatorDetailRowWidget(
                                            label: 'Currency Pair',
                                            value: state.selectedCurrencyName,
                                            textColor: textColor,
                                            subTextColor: subtextColor,
                                          ),
                                          const SizedBox(height: Dimens.space12),
                                          CalculatorDetailRowWidget(
                                            label: 'Account Balance',
                                            value: '${_getCurrencySymbol("USD")}${state.balance?.toStringAsFixed(2) ?? "0.00"}',
                                            textColor: textColor,
                                            subTextColor: subtextColor,
                                          ),
                                          const SizedBox(height: Dimens.space12),
                                          CalculatorDetailRowWidget(
                                            label: 'Risk Percentage',
                                            value: '${state.riskPercentage?.toStringAsFixed(1) ?? "0.0"}%',
                                            textColor: textColor,
                                            subTextColor: subtextColor,
                                          ),
                                          const SizedBox(height: Dimens.space12),
                                          CalculatorDetailRowWidget(
                                            label: 'Stop Loss',
                                            value: '${state.stopLoss?.toStringAsFixed(0) ?? "0"} pips',
                                            textColor: textColor,
                                            subTextColor: subtextColor,
                                          ),
                                        ],
                                      ),
                                    )
                                  : (state.activeTab == 'pip' && state.pipValue != null)
                                      ? Container(
                                          key: const ValueKey<String>('pip_results_card'),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: isDark ? const Color(0xFF0F0B22) : Colors.white,
                                            borderRadius: BorderRadius.circular(Dimens.radius16),
                                            border: Border.all(
                                              color: isDark ? AppColors.borderDark : AppColors.borderLight,
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(Dimens.space16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: 48,
                                                    height: 48,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppColors.primaryPurple.withValues(alpha: 0.15),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: const Icon(Icons.attach_money_rounded,
                                                        color: AppColors.primaryPurple, size: Dimens.size24),
                                                  ),
                                                  const SizedBox(width: Dimens.space12),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      CustomTextLabelWidget(
                                                        label: 'Pip Value',
                                                        style: TextStyle(
                                                          color: subtextColor,
                                                          fontSize: Dimens.fontSize12,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      CustomTextLabelWidget(
                                                        label: '${_getCurrencySymbol("USD")}${state.pipValue!.toStringAsFixed(2)}',
                                                        style: const TextStyle(
                                                          color: AppColors.primaryPurple,
                                                          fontSize: Dimens.fontSize24,
                                                          fontWeight: FontWeight.w800,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      CustomTextLabelWidget(
                                                        label: 'Value of 1 Pip',
                                                        style: TextStyle(
                                                          color: subtextColor,
                                                          fontSize: Dimens.fontSize11,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: Dimens.space16),
                                              const Divider(color: AppColors.borderDark, height: 1),
                                              const SizedBox(height: Dimens.space16),
                                              CalculatorDetailRowWidget(
                                                label: 'Currency Pair',
                                                value: state.selectedCurrencyName,
                                                textColor: textColor,
                                                subTextColor: subtextColor,
                                              ),
                                              const SizedBox(height: Dimens.space12),
                                              CalculatorDetailRowWidget(
                                                label: 'Lot Size',
                                                value: '${state.lotSize?.toStringAsFixed(2) ?? "0.00"} Lots',
                                                textColor: textColor,
                                                subTextColor: subtextColor,
                                              ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox.shrink(key: ValueKey<String>('no_results')),
                            ),
                          ),
                          const SizedBox(height: Dimens.space32),
                        ],
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

class CurrencyFlagWidget extends StatelessWidget {
  final String currencyOrPair;
  final double size;

  const CurrencyFlagWidget({
    super.key,
    required this.currencyOrPair,
    this.size = 26,
  });

  static String _getEmojiForCurrency(String currency) {
    switch (currency) {
      case 'USD':
        return '🇺🇸';
      case 'EUR':
        return '🇪🇺';
      case 'GBP':
        return '🇬🇧';
      case 'JPY':
        return '🇯🇵';
      case 'AUD':
        return '🇦🇺';
      case 'CAD':
        return '🇨🇦';
      case 'CHF':
        return '🇨🇭';
      case 'NZD':
        return '🇳🇿';
      case 'ZAR':
        return '🇿🇦';
      case 'SGD':
        return '🇸🇬';
      case 'HKD':
        return '🇭🇰';
      case 'MXN':
        return '🇲🇽';
      case 'INR':
        return '🇮🇳';
      case 'CNH':
        return '🇨🇳';
      case 'BTC':
        return '🪙';
      case 'ETH':
        return '🪙';
      case 'USOIL':
        return '🛢️';
      default:
        return '🏳️';
    }
  }

  Widget _buildSingleFlag(String currency) {
    final String emoji = _getEmojiForCurrency(currency);
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
      ),
      child: Text(
        emoji,
        style: TextStyle(fontSize: size * 0.7),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> parts = currencyOrPair.split('/');
    if (parts.length == 2) {
      return SizedBox(
        width: size * 1.6,
        height: size,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              child: _buildSingleFlag(parts[0]),
            ),
            Positioned(
              left: size * 0.54,
              top: 0,
              child: _buildSingleFlag(parts[1]),
            ),
          ],
        ),
      );
    } else {
      return _buildSingleFlag(currencyOrPair);
    }
  }
}

class CalculatorDetailRowWidget extends StatelessWidget {
  final String label;
  final String value;
  final Color textColor;
  final Color subTextColor;

  const CalculatorDetailRowWidget({
    super.key,
    required this.label,
    required this.value,
    required this.textColor,
    required this.subTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomTextLabelWidget(
          label: label,
          style: TextStyle(
            color: subTextColor,
            fontSize: Dimens.fontSize13,
            fontWeight: FontWeight.w500,
          ),
        ),
        CustomTextLabelWidget(
          label: value,
          style: TextStyle(
            color: textColor,
            fontSize: Dimens.fontSize13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class PipCalculatorTabSwitcher extends StatelessWidget {
  final String activeTab;
  final ValueChanged<String> onTabChanged;

  const PipCalculatorTabSwitcher({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color activeColor = AppColors.primaryPurple;
    final Color inactiveBgColor = isDark ? const Color(0xFF1E1736) : Colors.black.withValues(alpha: 0.05);
    final Color activeTextColor = Colors.white;
    final Color inactiveTextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: inactiveBgColor,
        borderRadius: BorderRadius.circular(Dimens.radius12),
      ),
      child: SizedBox(
        height: 40,
        child: Stack(
          children: <Widget>[
            // Sliding selection indicator background
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: activeTab == 'position' ? Alignment.centerLeft : Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    color: activeColor,
                    borderRadius: BorderRadius.circular(Dimens.radius8),
                  ),
                ),
              ),
            ),
            // Text buttons
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onTabChanged('position'),
                    child: Center(
                      child: Text(
                        'Position Size',
                        style: TextStyle(
                          color: activeTab == 'position' ? activeTextColor : inactiveTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimens.fontSize14,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onTabChanged('pip'),
                    child: Center(
                      child: Text(
                        'Pip Value',
                        style: TextStyle(
                          color: activeTab == 'pip' ? activeTextColor : inactiveTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimens.fontSize14,
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
    );
  }
}


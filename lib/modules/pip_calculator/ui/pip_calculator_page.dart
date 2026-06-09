import '../../../utils/exports.dart';

@RoutePage()
/// Page for calculating FX Pip values based on lots, pair, price, and account currency.
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
  final TextEditingController _lotController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final FocusNode _lotFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final PipCalculatorState state = context.read<PipCalculatorCubit>().state;
    _lotController.text = state.lotSize.toStringAsFixed(2);
    _priceController.text = state.currentPrice.toString();
  }

  @override
  void dispose() {
    _lotController.dispose();
    _priceController.dispose();
    _lotFocusNode.dispose();
    _priceFocusNode.dispose();
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

  String _getEmojiForCurrency(String currency) {
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
      default:
        return '🏳️';
    }
  }

  Widget _buildSingleFlag(String currency) {
    final String emoji = _getEmojiForCurrency(currency);
    return Container(
      width: 26,
      height: 26,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
      ),
      child: Text(
        emoji,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildDoubleFlags(String base, String quote) {
    return SizedBox(
      width: 42,
      height: 26,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            child: _buildSingleFlag(base),
          ),
          Positioned(
            left: 14,
            top: 0,
            child: _buildSingleFlag(quote),
          ),
        ],
      ),
    );
  }

  void _showPairSelector(BuildContext context, PipCalculatorState state) {
    final List<String> pairs = <String>[
      'EUR/USD',
      'GBP/USD',
      'USD/JPY',
      'AUD/USD',
      'USD/CAD',
      'USD/CHF',
      'NZD/USD',
      'EUR/GBP'
    ];

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
                  itemCount: pairs.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    final String pair = pairs[index];
                    final List<String> parts = pair.split('/');
                    return ListTile(
                      leading: _buildDoubleFlags(parts[0], parts[1]),
                      title: CustomTextLabelWidget(
                        label: pair,
                        style: TextStyle(
                          color: textCol,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      trailing: state.selectedCurrencyPair == pair
                          ? const Icon(Icons.check_circle, color: AppColors.primaryPurple)
                          : null,
                      onTap: () {
                        context.read<PipCalculatorCubit>().updateCurrencyPair(pair);
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

  void _showAccountCurrencySelector(BuildContext context, PipCalculatorState state) {
    final List<String> currencies = <String>[
      'USD',
      'EUR',
      'GBP',
      'JPY',
      'AUD',
      'CAD',
      'CHF',
      'NZD'
    ];

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
                label: 'Select Account Currency',
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
                  itemCount: currencies.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    final String currency = currencies[index];
                    return ListTile(
                      leading: _buildSingleFlag(currency),
                      title: CustomTextLabelWidget(
                        label: currency,
                        style: TextStyle(
                          color: textCol,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      trailing: state.selectedAccountCurrency == currency
                          ? const Icon(Icons.check_circle, color: AppColors.primaryPurple)
                          : null,
                      onTap: () {
                        context.read<PipCalculatorCubit>().updateAccountCurrency(currency);
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
          label: 'About PIP Calculator',
          style: TextStyle(
            color: context.isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: CustomTextLabelWidget(
          label: 'PIP stands for "percentage in point". It represents a tiny measure of the change in a currency pair in the forex market. This calculator helps determine the exact monetary value of 1 pip based on your lot size, currency pair, current price, and account base currency.',
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
    final Color headerBannerBg = isDark ? const Color(0xFF130E26) : const Color(0xFFF1EAFF);

    return BlocListener<PipCalculatorCubit, PipCalculatorState>(
      listenWhen: (PipCalculatorState prev, PipCalculatorState curr) =>
          prev.selectedCurrencyPair != curr.selectedCurrencyPair,
      listener: (BuildContext context, PipCalculatorState state) {
        _priceController.text = state.currentPrice.toString();
        context.read<PipCalculatorCubit>().calculate();
      },
      child: BlocBuilder<PipCalculatorCubit, PipCalculatorState>(
        builder: (BuildContext context, PipCalculatorState state) {
          final String baseCurrency = state.selectedCurrencyPair.split('/')[0];
          final String quoteCurrency = state.selectedCurrencyPair.split('/')[1];

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
                              label: 'PIP Calculator',
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
                              color: headerBannerBg,
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
                                        label: 'Calculate pip value for any currency pair',
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: Dimens.fontSize18,
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

                          // Dropdowns and text inputs
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
                                  _buildDoubleFlags(baseCurrency, quoteCurrency),
                                  const SizedBox(width: Dimens.space12),
                                  CustomTextLabelWidget(
                                    label: state.selectedCurrencyPair,
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
                          const SizedBox(height: Dimens.space20),

                          CustomTextLabelWidget(
                            label: 'Account Currency',
                            style: TextStyle(
                              color: subtextColor,
                              fontSize: Dimens.fontSize13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: Dimens.space8),
                          GestureDetector(
                            onTap: () => _showAccountCurrencySelector(context, state),
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
                                  _buildSingleFlag(state.selectedAccountCurrency),
                                  const SizedBox(width: Dimens.space12),
                                  CustomTextLabelWidget(
                                    label: state.selectedAccountCurrency,
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
                          const SizedBox(height: Dimens.space20),

                          // Lot Size Input
                          Row(
                            children: <Widget>[
                              CustomTextLabelWidget(
                                label: 'Lot Size',
                                style: TextStyle(
                                  color: subtextColor,
                                  fontSize: Dimens.fontSize13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: Dimens.space6),
                              GestureDetector(
                                onTap: () {
                                  unawaited(showDialog<void>(
                                    context: context,
                                    builder: (BuildContext ctx) => AlertDialog(
                                      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                                      title: const CustomTextLabelWidget(label: 'Lot Size Info'),
                                      content: const CustomTextLabelWidget(
                                        label: 'Standard Forex Lot sizes are 1.00 (100,000 units), Mini is 0.10 (10,000 units), and Micro is 0.01 (1,000 units).',
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ));
                                },
                                child: Icon(Icons.info_outline_rounded, size: Dimens.size14, color: subtextColor),
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimens.space8),
                          CustomTextFormFieldInputWidget(
                            controller: _lotController,
                            focusNode: _lotFocusNode,
                            fillColor: cardBg,
                            borderColor: borderCol,
                            textInputType: const TextInputType.numberWithOptions(decimal: true),
                            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                            suffix: CustomTextLabelWidget(
                              label: 'Lots',
                              style: TextStyle(color: subtextColor, fontWeight: FontWeight.bold),
                            ),
                            onChange: (String val) {
                              final double? d = double.tryParse(val);
                              if (d != null) {
                                context.read<PipCalculatorCubit>().updateLotSize(d);
                              }
                            },
                          ),
                          const SizedBox(height: Dimens.space20),

                          // Current Price Input
                          CustomTextLabelWidget(
                            label: 'Current Price',
                            style: TextStyle(
                              color: subtextColor,
                              fontSize: Dimens.fontSize13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: Dimens.space8),
                          CustomTextFormFieldInputWidget(
                            controller: _priceController,
                            focusNode: _priceFocusNode,
                            fillColor: cardBg,
                            borderColor: borderCol,
                            textInputType: const TextInputType.numberWithOptions(decimal: true),
                            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                            onChange: (String val) {
                              final double? d = double.tryParse(val);
                              if (d != null) {
                                context.read<PipCalculatorCubit>().updateCurrentPrice(d);
                              }
                            },
                          ),
                          const SizedBox(height: Dimens.space20),

                          // Pip Size Selector
                          CustomTextLabelWidget(
                            label: 'Pip Size',
                            style: TextStyle(
                              color: subtextColor,
                              fontSize: Dimens.fontSize13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: Dimens.space8),
                          GestureDetector(
                            onTap: () {
                              unawaited(showModalBottomSheet<void>(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (BuildContext sheetContext) {
                                  final List<double> sizes = <double>[0.0001, 0.01];
                                  final Color bg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
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
                                        CustomTextLabelWidget(
                                          label: 'Select Pip Size',
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: Dimens.fontSize16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: Dimens.space12),
                                        ...sizes.map((double sz) => ListTile(
                                              title: CustomTextLabelWidget(
                                                label: sz.toString(),
                                                style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                                              ),
                                              trailing: state.selectedPipSize == sz
                                                  ? const Icon(Icons.check, color: AppColors.primaryPurple)
                                                  : null,
                                              onTap: () {
                                                context.read<PipCalculatorCubit>().updatePipSize(sz);
                                                Navigator.pop(sheetContext);
                                              },
                                            )),
                                      ],
                                    ),
                                  );
                                },
                              ));
                            },
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
                                  CustomTextLabelWidget(
                                    label: state.selectedPipSize.toString(),
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
                              _lotFocusNode.unfocus();
                              _priceFocusNode.unfocus();
                              context.read<PipCalculatorCubit>().calculate();
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
                                    label: 'Calculate Pip Value',
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

                          // Results Card
                          Container(
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
                                // Top Value row
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
                                          label:
                                              '${_getCurrencySymbol(state.selectedAccountCurrency)} ${state.pipValue.toStringAsFixed(2)}',
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

                                // Detail grid
                                _buildDetailRow('Currency Pair', state.selectedCurrencyPair, textColor, subtextColor),
                                const SizedBox(height: Dimens.space12),
                                _buildDetailRow(
                                    'Account Currency', state.selectedAccountCurrency, textColor, subtextColor),
                                const SizedBox(height: Dimens.space12),
                                _buildDetailRow(
                                    'Lot Size', '${state.lotSize.toStringAsFixed(2)} Lots', textColor, subtextColor),
                                const SizedBox(height: Dimens.space12),
                                _buildDetailRow('Pip Size', state.selectedPipSize.toString(), textColor, subtextColor),
                                const SizedBox(height: Dimens.space12),
                                _buildDetailRow(
                                    'Current Price', state.currentPrice.toStringAsFixed(5), textColor, subtextColor),

                                const SizedBox(height: Dimens.space20),

                                // Note
                                Container(
                                  padding: const EdgeInsets.all(Dimens.space12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimens.radius8),
                                    color: AppColors.primaryPurple.withValues(alpha: 0.1),
                                    border: Border.all(color: AppColors.primaryPurple.withValues(alpha: 0.2)),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      const Icon(Icons.info_outline_rounded,
                                          color: AppColors.primaryPurple, size: Dimens.size16),
                                      const SizedBox(width: Dimens.space8),
                                      Expanded(
                                        child: CustomTextLabelWidget(
                                          label:
                                              '1 Pip in ${state.selectedCurrencyPair} (${state.lotSize.toStringAsFixed(2)} Lots) = ${_getCurrencySymbol(state.selectedAccountCurrency)}${state.pipValue.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            color: AppColors.primaryPurple,
                                            fontSize: Dimens.fontSize12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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

  Widget _buildDetailRow(String label, String value, Color textCol, Color subCol) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomTextLabelWidget(
          label: label,
          style: TextStyle(
            color: subCol,
            fontSize: Dimens.fontSize13,
            fontWeight: FontWeight.w500,
          ),
        ),
        CustomTextLabelWidget(
          label: value,
          style: TextStyle(
            color: textCol,
            fontSize: Dimens.fontSize13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

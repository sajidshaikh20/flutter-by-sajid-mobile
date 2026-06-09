import '../../../utils/exports.dart';

@RoutePage()
/// Page for calculating compound interest with monthly contribution projections.
class CompoundInterestPage extends BaseResponsiveView {
  const CompoundInterestPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<CompoundInterestCubit>(
      create: (BuildContext context) => CompoundInterestCubit(),
      child: const CompoundInterestViewBody(),
    );
  }
}

class CompoundInterestViewBody extends StatefulWidget {
  const CompoundInterestViewBody({super.key});

  @override
  State<CompoundInterestViewBody> createState() => _CompoundInterestViewBodyState();
}

class _CompoundInterestViewBodyState extends State<CompoundInterestViewBody> {
  final TextEditingController _initialController = TextEditingController();
  final TextEditingController _monthlyController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  final FocusNode _initialFocus = FocusNode();
  final FocusNode _monthlyFocus = FocusNode();
  final FocusNode _rateFocus = FocusNode();
  final FocusNode _yearsFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    final CompoundInterestState state = context.read<CompoundInterestCubit>().state;
    _initialController.text = state.initialInvestment.toStringAsFixed(0);
    _monthlyController.text = state.monthlyContribution.toStringAsFixed(0);
    _rateController.text = state.annualInterestRate.toStringAsFixed(0);
    _yearsController.text = state.years.toString();
  }

  @override
  void dispose() {
    _initialController.dispose();
    _monthlyController.dispose();
    _rateController.dispose();
    _yearsController.dispose();
    _initialFocus.dispose();
    _monthlyFocus.dispose();
    _rateFocus.dispose();
    _yearsFocus.dispose();
    super.dispose();
  }

  void _showFrequencySelector(BuildContext context, CompoundInterestState state) {
    final List<String> frequencies = <String>[
      'Daily',
      'Weekly',
      'Monthly',
      'Quarterly',
      'Semi-Annually',
      'Annually',
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
                label: 'Select Compounding Frequency',
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
                  itemCount: frequencies.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    final String freq = frequencies[index];
                    return ListTile(
                      title: CustomTextLabelWidget(
                        label: freq,
                        style: TextStyle(
                          color: textCol,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      trailing: state.compoundFrequency == freq
                          ? const Icon(Icons.check_circle, color: AppColors.primaryPurple)
                          : null,
                      onTap: () {
                        context.read<CompoundInterestCubit>().updateCompoundFrequency(freq);
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
          label: 'About Compound Interest',
          style: TextStyle(
            color: context.isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: CustomTextLabelWidget(
          label: 'Compound interest is interest calculated on the initial principal, which also includes all of the accumulated interest from previous periods on a deposit or loan.',
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

  String _formatCurrency(double val) {
    final NumberFormat formatter = NumberFormat('#,##0.00', 'en_US');
    return '\$${formatter.format(val)}';
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

    return BlocBuilder<CompoundInterestCubit, CompoundInterestState>(
      builder: (BuildContext context, CompoundInterestState state) {
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
                            label: 'Compound Interest',
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
                        // Header Banner
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
                                      label: 'Estimate the future value of your investments',
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
                              // Illustrative bar chart graphic for Compound Interest header
                              SizedBox(
                                width: 100,
                                height: 80,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      child: Container(
                                        width: 16,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryPurple.withValues(alpha: 0.4),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 22,
                                      child: Container(
                                        width: 16,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryPurple.withValues(alpha: 0.6),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 44,
                                      child: Container(
                                        width: 16,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryPurple.withValues(alpha: 0.8),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 66,
                                      child: Container(
                                        width: 16,
                                        height: 75,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryPurple,
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      left: 10,
                                      child: Icon(
                                        Icons.trending_up_rounded,
                                        color: isDark ? Colors.white : AppColors.primaryPurple,
                                        size: 40,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimens.space24),

                        // Initial Investment Input
                        CustomTextLabelWidget(
                          label: 'Initial Investment',
                          style: TextStyle(
                            color: subtextColor,
                            fontSize: Dimens.fontSize13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: Dimens.space8),
                        CustomTextFormFieldInputWidget(
                          controller: _initialController,
                          focusNode: _initialFocus,
                          fillColor: cardBg,
                          borderColor: borderCol,
                          textInputType: TextInputType.number,
                          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                          prefix: Padding(
                            padding: const EdgeInsets.only(right: Dimens.space8, left: Dimens.space4),
                            child: CustomTextLabelWidget(
                              label: r'$',
                              style: TextStyle(color: subtextColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                          onChange: (String val) {
                            final double? d = double.tryParse(val);
                            if (d != null) {
                              context.read<CompoundInterestCubit>().updateInitialInvestment(d);
                            }
                          },
                        ),
                        const SizedBox(height: Dimens.space20),

                        // Monthly Contribution Input
                        CustomTextLabelWidget(
                          label: 'Monthly Contribution',
                          style: TextStyle(
                            color: subtextColor,
                            fontSize: Dimens.fontSize13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: Dimens.space8),
                        CustomTextFormFieldInputWidget(
                          controller: _monthlyController,
                          focusNode: _monthlyFocus,
                          fillColor: cardBg,
                          borderColor: borderCol,
                          textInputType: TextInputType.number,
                          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                          prefix: Padding(
                            padding: const EdgeInsets.only(right: Dimens.space8, left: Dimens.space4),
                            child: CustomTextLabelWidget(
                              label: r'$',
                              style: TextStyle(color: subtextColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                          onChange: (String val) {
                            final double? d = double.tryParse(val);
                            if (d != null) {
                              context.read<CompoundInterestCubit>().updateMonthlyContribution(d);
                            }
                          },
                        ),
                        const SizedBox(height: Dimens.space20),

                        // Annual Interest Rate Input
                        CustomTextLabelWidget(
                          label: 'Annual Interest Rate (%)',
                          style: TextStyle(
                            color: subtextColor,
                            fontSize: Dimens.fontSize13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: Dimens.space8),
                        CustomTextFormFieldInputWidget(
                          controller: _rateController,
                          focusNode: _rateFocus,
                          fillColor: cardBg,
                          borderColor: borderCol,
                          textInputType: const TextInputType.numberWithOptions(decimal: true),
                          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                          suffix: Padding(
                            padding: const EdgeInsets.only(left: Dimens.space8, right: Dimens.space4),
                            child: CustomTextLabelWidget(
                              label: '%',
                              style: TextStyle(color: subtextColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                          onChange: (String val) {
                            final double? d = double.tryParse(val);
                            if (d != null) {
                              context.read<CompoundInterestCubit>().updateAnnualInterestRate(d);
                            }
                          },
                        ),
                        const SizedBox(height: Dimens.space20),

                        // Compound Frequency
                        CustomTextLabelWidget(
                          label: 'Compound Frequency',
                          style: TextStyle(
                            color: subtextColor,
                            fontSize: Dimens.fontSize13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: Dimens.space8),
                        GestureDetector(
                          onTap: () => _showFrequencySelector(context, state),
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
                                  label: state.compoundFrequency,
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

                        // Years Input
                        CustomTextLabelWidget(
                          label: 'Years',
                          style: TextStyle(
                            color: subtextColor,
                            fontSize: Dimens.fontSize13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: Dimens.space8),
                        CustomTextFormFieldInputWidget(
                          controller: _yearsController,
                          focusNode: _yearsFocus,
                          fillColor: cardBg,
                          borderColor: borderCol,
                          textInputType: TextInputType.number,
                          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                          suffix: Padding(
                            padding: const EdgeInsets.only(left: Dimens.space8, right: Dimens.space4),
                            child: CustomTextLabelWidget(
                              label: 'Years',
                              style: TextStyle(color: subtextColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                          onChange: (String val) {
                            final int? v = int.tryParse(val);
                            if (v != null && v > 0) {
                              context.read<CompoundInterestCubit>().updateYears(v);
                            }
                          },
                        ),
                        const SizedBox(height: Dimens.space28),

                        // Calculate Button
                        GestureDetector(
                          onTap: () {
                            _initialFocus.unfocus();
                            _monthlyFocus.unfocus();
                            _rateFocus.unfocus();
                            _yearsFocus.unfocus();
                            context.read<CompoundInterestCubit>().calculate();
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
                                Icon(Icons.trending_up_rounded, color: Colors.white),
                                SizedBox(width: Dimens.space8),
                                CustomTextLabelWidget(
                                  label: 'Calculate Returns',
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
                              // Future Value Header
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
                                    child: const Icon(Icons.show_chart_rounded,
                                        color: AppColors.primaryPurple, size: Dimens.size24),
                                  ),
                                  const SizedBox(width: Dimens.space12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CustomTextLabelWidget(
                                          label: 'Future Value',
                                          style: TextStyle(
                                            color: subtextColor,
                                            fontSize: Dimens.fontSize12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        CustomTextLabelWidget(
                                          label: _formatCurrency(state.futureValue),
                                          style: const TextStyle(
                                            color: AppColors.primaryPurple,
                                            fontSize: Dimens.fontSize24,
                                            fontWeight: FontWeight.w800,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        const SizedBox(height: 2),
                                        CustomTextLabelWidget(
                                          label: 'Total amount after ${state.years} years',
                                          style: TextStyle(
                                            color: subtextColor,
                                            fontSize: Dimens.fontSize11,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimens.space16),
                              const Divider(color: AppColors.borderDark, height: 1),
                              const SizedBox(height: Dimens.space16),

                              _buildDetailRow('Total Invested', _formatCurrency(state.totalInvested), textColor,
                                  AppColors.skyBlueDarkColor),
                              const SizedBox(height: Dimens.space12),
                              _buildDetailRow('Interest Earned', _formatCurrency(state.interestEarned), textColor,
                                  AppColors.successColor),
                              const SizedBox(height: Dimens.space12),
                              _buildDetailRow('Total Contributions', _formatCurrency(state.totalContributions),
                                  textColor, AppColors.warningColor),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimens.space24),

                        // Growth Over Time Chart Card
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
                              CustomTextLabelWidget(
                                label: 'Growth Over Time',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: Dimens.fontSize15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: Dimens.space20),
                              SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: CustomPaint(
                                  painter: ChartPainter(
                                    data: state.yearlyGrowth,
                                    years: state.years,
                                    isDark: isDark,
                                  ),
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
    );
  }

  Widget _buildDetailRow(String label, String value, Color textCol, Color bulletColor) {
    return Row(
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bulletColor,
          ),
        ),
        const SizedBox(width: Dimens.space10),
        CustomTextLabelWidget(
          label: label,
          style: TextStyle(
            color: textCol.withValues(alpha: 0.7),
            fontSize: Dimens.fontSize13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        CustomTextLabelWidget(
          label: value,
          style: TextStyle(
            color: bulletColor,
            fontSize: Dimens.fontSize13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ChartPainter extends CustomPainter {
  ChartPainter({required this.data, required this.years, required this.isDark});

  final List<double> data;
  final int years;
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    const double leftPadding = 50.0;
    const double bottomPadding = 30.0;
    const double topPadding = 20.0;
    const double rightPadding = 20.0;

    final double chartWidth = size.width - leftPadding - rightPadding;
    final double chartHeight = size.height - topPadding - bottomPadding;

    if (data.isEmpty) return;

    final double maxVal = data.last;
    final double range = maxVal > 0 ? maxVal : 1.0;

    // Grid lines Paint
    final Paint gridPaint = Paint()
      ..color = isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.right,
    );

    // Draw Y grid and labels
    for (int i = 0; i <= 4; i++) {
      final double fraction = i / 4.0;
      final double yVal = maxVal * fraction;
      final double yPos = topPadding + chartHeight * (1.0 - fraction);

      canvas.drawLine(
        Offset(leftPadding, yPos),
        Offset(leftPadding + chartWidth, yPos),
        gridPaint,
      );

      textPainter.text = TextSpan(
        text: _formatYAxisLabel(yVal),
        style: TextStyle(
          color: isDark ? Colors.white60 : Colors.black54,
          fontSize: 10,
          fontFamily: 'inter',
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(leftPadding - textPainter.width - 8.0, yPos - textPainter.height / 2),
      );
    }

    // Draw X grid/labels (0%, 25%, 50%, 75%, 100%)
    final double stepX = chartWidth / (data.length - 1);
    final List<double> xLabelFractions = <double>[0.0, 0.25, 0.50, 0.75, 1.0];
    for (final double frac in xLabelFractions) {
      final double yearVal = years * frac;
      final double xPos = leftPadding + chartWidth * frac;

      final String label = frac == 0.0 ? '0' : '${yearVal.toStringAsFixed(1)} Y';

      textPainter.text = TextSpan(
        text: label,
        style: TextStyle(
          color: isDark ? Colors.white60 : Colors.black54,
          fontSize: 10,
          fontFamily: 'inter',
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(xPos - textPainter.width / 2, size.height - bottomPadding + 6.0),
      );
    }

    // Generate Points
    final List<Offset> points = <Offset>[];
    for (int i = 0; i < data.length; i++) {
      final double x = leftPadding + i * stepX;
      final double fraction = data[i] / range;
      final double y = topPadding + chartHeight * (1.0 - fraction);
      points.add(Offset(x, y));
    }

    // Draw Fill Under Line
    if (points.isNotEmpty) {
      final Path fillPath = Path();
      fillPath.moveTo(points.first.dx, topPadding + chartHeight);
      for (int i = 0; i < points.length; i++) {
        fillPath.lineTo(points[i].dx, points[i].dy);
      }
      fillPath.lineTo(points.last.dx, topPadding + chartHeight);
      fillPath.close();

      final Paint fillPaint = Paint()
        ..shader = LinearGradient(
          colors: <Color>[
            AppColors.primaryPurple.withValues(alpha: isDark ? 0.35 : 0.2),
            AppColors.primaryPurple.withValues(alpha: 0.0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTRB(leftPadding, topPadding, leftPadding + chartWidth, topPadding + chartHeight));

      canvas.drawPath(fillPath, fillPaint);
    }

    // Draw Line
    final Paint linePaint = Paint()
      ..color = AppColors.primaryPurple
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Path linePath = Path();
    if (points.isNotEmpty) {
      linePath.moveTo(points.first.dx, points.first.dy);
      for (int i = 1; i < points.length; i++) {
        linePath.lineTo(points[i].dx, points[i].dy);
      }
      canvas.drawPath(linePath, linePaint);
    }

    // Draw Dot Markers
    final Paint dotPaint = Paint()
      ..color = AppColors.primaryPurple
      ..style = PaintingStyle.fill;
    final Paint dotBorderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      final double fraction = i / (points.length - 1);
      if (fraction == 0.0 || fraction == 0.25 || fraction == 0.50 || fraction == 0.75 || fraction == 1.0) {
        canvas.drawCircle(points[i], 5.0, dotBorderPaint);
        canvas.drawCircle(points[i], 3.0, dotPaint);
      }
    }

    // Draw Tooltip on the last point
    if (points.isNotEmpty) {
      final Offset lastPoint = points.last;
      final String tooltipText = '\$${_formatTooltipAmount(maxVal)}\nat $years Years';

      final TextPainter tooltipPainter = TextPainter(
        text: TextSpan(
          text: tooltipText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            fontFamily: 'inter',
            height: 1.2,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      tooltipPainter.layout();

      final double rectW = tooltipPainter.width + 16.0;
      final double rectH = tooltipPainter.height + 12.0;

      final double rectX = lastPoint.dx - rectW - 10.0;
      final double rectY = lastPoint.dy - rectH / 2;

      final RRect tooltipRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(rectX, rectY, rectW, rectH),
        const Radius.circular(8.0),
      );

      final Paint tooltipBgPaint = Paint()
        ..color = const Color(0xFF130E26)
        ..style = PaintingStyle.fill;
      final Paint tooltipBorderPaint = Paint()
        ..color = AppColors.primaryPurple.withValues(alpha: 0.5)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;

      canvas.drawRRect(tooltipRRect, tooltipBgPaint);
      canvas.drawRRect(tooltipRRect, tooltipBorderPaint);

      tooltipPainter.paint(
        canvas,
        Offset(rectX + 8.0, rectY + 6.0),
      );
    }
  }

  String _formatYAxisLabel(double val) {
    if (val >= 1000000) {
      return '\$${(val / 1000000.0).toStringAsFixed(1)}M';
    } else if (val >= 1000) {
      return '\$${(val / 1000.0).toStringAsFixed(0)}K';
    } else {
      return '\$${val.toStringAsFixed(0)}';
    }
  }

  String _formatTooltipAmount(double val) {
    final NumberFormat formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(val);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

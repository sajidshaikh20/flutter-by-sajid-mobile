import '../../../../utils/exports.dart';

class SignUpTraderProfileForm extends StatelessWidget {
  const SignUpTraderProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpCubit cubit = context.read<SignUpCubit>();
    final bool isDark = context.isDark;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.size16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SignUpStepHeader(
            title: 'Trading Details & Verification',
            subtitle: 'Provide your trading style, performance metrics, and upload verify files',
          ),
          Dimens.size24.heightBox,

          // SECTION 1: Trading Background
          _sectionHeader(context, '1. Trading Background'),
          Dimens.size12.heightBox,

          const _FieldLabel(label: 'Trading Experience (Years)', isRequired: true),
          Dimens.size8.heightBox,
          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState p, SignUpState c) =>
                p.tradingExperience != c.tradingExperience,
            builder: (BuildContext context, SignUpState state) {
              return SignUpDropdownFieldWidget(
                value: state.tradingExperience.isEmpty ? null : state.tradingExperience,
                placeholder: 'Select experience',
                items: const <String>['0-1 Years', '1-3 Years', '3-5 Years', '5+ Years'],
                onChanged: (String? val) {
                  if (val != null) {
                    cubit.setTradingExperience(val);
                  }
                },
              );
            },
          ),
          Dimens.size16.heightBox,

          const _FieldLabel(label: 'Have you traded professionally?'),
          Dimens.size8.heightBox,
          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState p, SignUpState c) =>
                p.professionallyTraded != c.professionallyTraded,
            builder: (BuildContext context, SignUpState state) {
              return _buildYesNoRadio(
                isDark: isDark,
                value: state.professionallyTraded,
                onChanged: cubit.setProfessionallyTraded,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.previousFirmController,
                label: 'Previous Firm / Company',
                hint: 'Enter previous firm or company',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          const _FieldLabel(label: 'Markets Traded', isRequired: true),
          Dimens.size8.heightBox,
          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState p, SignUpState c) =>
                p.marketsTraded != c.marketsTraded,
            builder: (BuildContext context, SignUpState state) {
              return Wrap(
                spacing: Dimens.size8,
                runSpacing: Dimens.size8,
                children: <String>[
                  'Forex',
                  'Crypto',
                  'Stocks',
                  'Commodities',
                  'Indices',
                  'Others',
                ].map((String market) {
                  final bool isSelected = state.marketsTraded.contains(market);
                  return GestureDetector(
                    onTap: () => cubit.toggleMarketTraded(market),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.size16,
                        vertical: Dimens.size12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryPurple.withValues(alpha: 0.08)
                            : (isDark ? AppColors.surfaceDark : AppColors.whiteColor),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryPurple
                              : (isDark ? AppColors.borderDark : AppColors.borderLight),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(Dimens.radius8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                            color: isSelected ? AppColors.primaryPurple : Colors.grey,
                            size: Dimens.size20,
                          ),
                          Dimens.size8.widthBox,
                          CustomTextLabelWidget(
                            label: market,
                            style: TextStyle(
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              color: isSelected
                                  ? AppColors.primaryPurple
                                  : (isDark ? Colors.white : Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.primaryInstrumentsController,
                label: 'Primary Instruments',
                hint: 'e.g., EURUSD, Gold, BTCUSD',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.preferredCurrencyPairsController,
                label: 'Preferred Currency Pairs',
                hint: 'e.g., EURUSD, GBPUSD, USDJPY',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          const _FieldLabel(label: 'Trading Style', isRequired: true),
          Dimens.size8.heightBox,
          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState p, SignUpState c) =>
                p.tradingStyle != c.tradingStyle,
            builder: (BuildContext context, SignUpState state) {
              return SignUpDropdownFieldWidget(
                value: state.tradingStyle.isEmpty ? null : state.tradingStyle,
                placeholder: 'Select trading style',
                items: const <String>[
                  'Scalping',
                  'Day Trading',
                  'Swing Trading',
                  'Position Trading'
                ],
                onChanged: (String? val) {
                  if (val != null) {
                    cubit.setTradingStyle(val);
                  }
                },
              );
            },
          ),
          Dimens.size24.heightBox,

          // SECTION 2: Strategy Details
          _sectionHeader(context, '2. Strategy Details'),
          Dimens.size12.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.tradingPlatformController,
                label: 'Trading Platform',
                hint: 'e.g., MT4, MT5, cTrader',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.brokersUsedController,
                label: 'Brokers Used',
                hint: 'e.g., IC Markets, Pepperstone',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.averageTradesPerDayController,
                label: 'Average Trades Per Day',
                hint: 'e.g., 3-5, 10+',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.preferredTimeframesController,
                label: 'Preferred Timeframes',
                hint: 'e.g., 5m, 15m, 1h, 4h',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.preferredSessionsController,
                label: 'Preferred Sessions',
                hint: 'e.g., London, New York',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.strategyDescriptionController,
                label: 'Strategy Description (Min 20 chars)',
                hint: 'Describe your trading strategy and execution rules...',
                maxLines: 4,
                maxLength: 500,
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.primaryEdgeController,
                label: 'Primary Edge',
                hint: 'What gives you an edge in the market?',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.indicatorsToolsController,
                label: 'Indicators / Tools Used',
                hint: 'e.g., Fibonacci, RSI, Moving Averages',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState p, SignUpState c) =>
                p.internetBackup != c.internetBackup,
            builder: (BuildContext context, SignUpState state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const _FieldLabel(label: 'Do you have an internet backup solution?'),
                  Dimens.size8.heightBox,
                  _buildYesNoRadio(
                    isDark: isDark,
                    value: state.internetBackup,
                    onChanged: cubit.setInternetBackup,
                  ),
                ],
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState p, SignUpState c) =>
                p.useVps != c.useVps,
            builder: (BuildContext context, SignUpState state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const _FieldLabel(label: 'Do you use a VPS (Virtual Private Server)?'),
                  Dimens.size8.heightBox,
                  _buildYesNoRadio(
                    isDark: isDark,
                    value: state.useVps,
                    onChanged: cubit.setUseVps,
                  ),
                ],
              );
            },
          ),
          Dimens.size24.heightBox,

          // SECTION 3: Risk Management
          _sectionHeader(context, '3. Risk & Account Performance'),
          Dimens.size12.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.averageRiskPerTradeController,
                label: 'Average Risk Per Trade (%)',
                hint: 'e.g., 1%, 2%',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.riskRewardRatioController,
                label: 'Risk/Reward Ratio',
                hint: 'e.g., 1:2, 1:3',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.maxDailyDrawdownController,
                label: 'Max Daily Drawdown (%)',
                hint: 'e.g., 5%',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.maxOverallDrawdownController,
                label: 'Max Overall Drawdown (%)',
                hint: 'e.g., 10%',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.useStopLossesController,
                label: 'Do you use stop losses? (How?)',
                hint: 'e.g., Yes, always; structural stop',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.averageMonthlyReturnController,
                label: 'Average Monthly Return (%)',
                hint: 'e.g., 5%, 8%',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.averageWinRateController,
                label: 'Average Win Rate (%)',
                hint: 'e.g., 60%',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.largestWinningMonthController,
                label: 'Largest Winning Month (%)',
                hint: 'e.g., 15%',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.largestLosingMonthController,
                label: 'Largest Losing Month (%)',
                hint: 'e.g., -5%',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.currentAccountSizeController,
                label: 'Current Account Size (\$)',
                hint: 'e.g., \$10,000',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.largestAccountManagedController,
                label: 'Largest Account Managed (\$)',
                hint: 'e.g., \$100,000',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState p, SignUpState c) =>
                p.fundedAccountExperience != c.fundedAccountExperience,
            builder: (BuildContext context, SignUpState state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const _FieldLabel(label: 'Funded Account Experience'),
                  Dimens.size8.heightBox,
                  _buildYesNoRadio(
                    isDark: isDark,
                    value: state.fundedAccountExperience,
                    onChanged: cubit.setFundedAccountExperience,
                  ),
                ],
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.propFirmsWorkedController,
                label: 'Prop Firms Worked With',
                hint: 'e.g., FTMO, MFF, None',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState p, SignUpState c) =>
                p.passedFundedChallenge != c.passedFundedChallenge,
            builder: (BuildContext context, SignUpState state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const _FieldLabel(label: 'Passed Funded Challenge?'),
                  Dimens.size8.heightBox,
                  _buildYesNoRadio(
                    isDark: isDark,
                    value: state.passedFundedChallenge,
                    onChanged: cubit.setPassedFundedChallenge,
                  ),
                ],
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.accountSizesPassedController,
                label: 'Account Sizes Passed (\$)',
                hint: 'e.g., \$10k, \$50k, None',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.handlingLosingStreaksController,
                label: 'How do you handle losing streaks?',
                hint: 'Explain your risk adjustment rules...',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.biggestWeaknessController,
                label: 'Biggest Weakness',
                hint: 'What is your main weakness in trading?',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.biggestStrengthController,
                label: 'Biggest Strength',
                hint: 'What is your main strength in trading?',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState p, SignUpState c) =>
                p.maintainTradingJournal != c.maintainTradingJournal,
            builder: (BuildContext context, SignUpState state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const _FieldLabel(label: 'Do you maintain a trading journal?'),
                  Dimens.size8.heightBox,
                  _buildYesNoRadio(
                    isDark: isDark,
                    value: state.maintainTradingJournal,
                    onChanged: cubit.setMaintainTradingJournal,
                  ),
                ],
              );
            },
          ),
          Dimens.size24.heightBox,

          // SECTION 4: Document Verification
          _sectionHeader(context, '4. Verification & Signing'),
          Dimens.size12.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.performanceTrackingLinksController,
                label: 'Performance Tracking Link (myfxbook / fxblue)',
                hint: 'e.g., https://www.myfxbook.com/members/...',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState p, SignUpState c) =>
                p.myfxbookVerified != c.myfxbookVerified ||
                p.fxblueVerified != c.fxblueVerified,
            builder: (BuildContext context, SignUpState state) {
              return Row(
                children: <Widget>[
                  Expanded(
                    child: _buildSimpleCheckbox(
                      isDark: isDark,
                      label: 'Myfxbook Verified',
                      value: state.myfxbookVerified,
                      onChanged: (bool? val) {
                        if (val != null) {
                          cubit.setMyfxbookVerified(val);
                        }
                      },
                    ),
                  ),
                  Dimens.size12.widthBox,
                  Expanded(
                    child: _buildSimpleCheckbox(
                      isDark: isDark,
                      label: 'Fxblue Verified',
                      value: state.fxblueVerified,
                      onChanged: (bool? val) {
                        if (val != null) {
                          cubit.setFxblueVerified(val);
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          Dimens.size20.heightBox,

          // Document upload labels & buttons
          const _FieldLabel(label: 'Upload Required Documents', isRequired: true),
          Dimens.size8.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return Column(
                children: <Widget>[
                  _buildUploadItem(
                    label: 'Government ID *',
                    fileName: state.governmentIdPath?.split('/').last,
                    onTap: () => cubit.pickGovernmentId(),
                  ),
                  Dimens.size12.heightBox,
                  _buildUploadItem(
                    label: 'Broker Statement (PDF/Image)',
                    fileName: state.bankStatementPath?.split('/').last,
                    onTap: () => cubit.pickBankStatement(),
                  ),
                  Dimens.size12.heightBox,
                  _buildUploadItem(
                    label: 'Trading Certificate (Image)',
                    fileName: state.tradingCertificatePath?.split('/').last,
                    onTap: () => cubit.pickTradingCertificate(),
                  ),
                ],
              );
            },
          ),
          Dimens.size20.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.additionalNotesController,
                label: 'Additional Notes',
                hint: 'Enter any additional details or background metrics...',
                maxLines: 3,
                maxLength: 1000,
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.instagramHandleController,
                label: 'Instagram Handle Link (Optional)',
                hint: 'e.g., https://instagram.com/username',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.twitterHandleController,
                label: 'Twitter/X Handle Link (Optional)',
                hint: 'e.g., https://x.com/username',
                input: TextInputAction.next,
              );
            },
          ),
          Dimens.size16.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.traderSignatureController,
                label: 'Enter Signature (Full Legal Name) *',
                hint: 'Type your full legal name as a signature...',
                input: TextInputAction.done,
              );
            },
          ),
          Dimens.size20.heightBox,

          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState p, SignUpState c) =>
                p.declarationConfirmed != c.declarationConfirmed,
            builder: (BuildContext context, SignUpState state) {
              return _buildSimpleCheckbox(
                isDark: isDark,
                label: 'I declare that the information provided is true and correct *',
                value: state.declarationConfirmed,
                onChanged: (bool? val) {
                  if (val != null) {
                    cubit.setDeclarationConfirmed(val);
                  }
                },
              );
            },
          ),
          Dimens.size32.heightBox,
        ],
      ),
    );
  }

  // Helper builder for Checkbox
  Widget _buildSimpleCheckbox({
    required bool isDark,
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primaryPurple,
        ),
        Expanded(
          child: CustomTextLabelWidget(
            textAlign: TextAlign.start,
            label: label,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: Dimens.fontSize12,
            ),
          ),
        ),
      ],
    );
  }


  // Helper builder for Yes/No selector cards
  Widget _buildYesNoRadio({
    required bool isDark,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(true),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: Dimens.size14),
              decoration: BoxDecoration(
                color: value
                    ? AppColors.primaryPurple.withValues(alpha: 0.08)
                    : (isDark ? AppColors.surfaceDark : AppColors.whiteColor),
                border: Border.all(
                  color: value
                      ? AppColors.primaryPurple
                      : (isDark ? AppColors.borderDark : AppColors.borderLight),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(Dimens.radius12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    value ? Icons.radio_button_checked : Icons.radio_button_off,
                    color: value ? AppColors.primaryPurple : Colors.grey,
                    size: Dimens.size20,
                  ),
                  Dimens.size8.widthBox,
                   CustomTextLabelWidget(
                    label: 'Yes',
                    style: TextStyle(
                      fontWeight: value ? FontWeight.bold : FontWeight.normal,
                      color: value
                          ? AppColors.primaryPurple
                          : (isDark ? Colors.white : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Dimens.size12.widthBox,
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(false),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: Dimens.size14),
              decoration: BoxDecoration(
                color: !value
                    ? AppColors.primaryPurple.withValues(alpha: 0.08)
                    : (isDark ? AppColors.surfaceDark : AppColors.whiteColor),
                border: Border.all(
                  color: !value
                      ? AppColors.primaryPurple
                      : (isDark ? AppColors.borderDark : AppColors.borderLight),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(Dimens.radius12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    !value ? Icons.radio_button_checked : Icons.radio_button_off,
                    color: !value ? AppColors.primaryPurple : Colors.grey,
                    size: Dimens.size20,
                  ),
                  Dimens.size8.widthBox,
                   CustomTextLabelWidget(
                    label: 'No',
                    style: TextStyle(
                      fontWeight: !value ? FontWeight.bold : FontWeight.normal,
                      color: !value
                          ? AppColors.primaryPurple
                          : (isDark ? Colors.white : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Section divider and label
  Widget _sectionHeader(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Divider(thickness: 1),
        Dimens.size8.heightBox,
        CustomTextLabelWidget(
          label: title,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.primaryPurple,
            fontSize: Dimens.fontSize16,
          ),
        ),
      ],
    );
  }

  // Uploader tile builder
  Widget _buildUploadItem({
    required String label,
    required String? fileName,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(Dimens.size12),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.05),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(Dimens.radius8),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomTextLabelWidget(
                  label: label,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: Dimens.fontSize12),
                ),
                if (fileName != null) ...<Widget>[
                  Dimens.size4.heightBox,
                  CustomTextLabelWidget(
                    label: fileName,
                    style: const TextStyle(color: Colors.green, fontSize: Dimens.fontSize10),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: onTap,
            icon: const Icon(Icons.upload_file, size: Dimens.size16),
            label: CustomTextLabelWidget(
              label: fileName != null ? 'Change' : 'Upload',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.size12, vertical: Dimens.size8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.radius6)),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  final bool isRequired;

  const _FieldLabel({required this.label, this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CustomTextLabelWidget(
          label: label,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        if (isRequired) ...<Widget>[
          Dimens.size4.widthBox,
          const CustomTextLabelWidget(
            label: '*',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ],
    );
  }
}

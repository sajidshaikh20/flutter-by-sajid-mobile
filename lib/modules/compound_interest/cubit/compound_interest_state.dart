import '../../../utils/exports.dart';

/// State class for Compound Interest screen.
class CompoundInterestState extends BaseState {
  const CompoundInterestState({
    this.initialInvestment = 10000.0,
    this.monthlyContribution = 0.0,
    this.annualInterestRate = 7.0,
    this.compoundFrequency = 'Annually',
    this.years = 10,
    this.futureValue = 0.0,
    this.totalInvested = 0.0,
    this.interestEarned = 0.0,
    this.totalContributions = 0.0,
    this.yearlyGrowth = const <double>[],
    this.selectedCurrency = 'USD',
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  final double initialInvestment;
  final double monthlyContribution;
  final double annualInterestRate;
  final String compoundFrequency;
  final int years;
  final double futureValue;
  final double totalInvested;
  final double interestEarned;
  final double totalContributions;
  final List<double> yearlyGrowth;
  final String selectedCurrency;

  factory CompoundInterestState.initial() => const CompoundInterestState();

  CompoundInterestState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    double? initialInvestment,
    double? monthlyContribution,
    double? annualInterestRate,
    String? compoundFrequency,
    int? years,
    double? futureValue,
    double? totalInvested,
    double? interestEarned,
    double? totalContributions,
    List<double>? yearlyGrowth,
    String? selectedCurrency,
  }) =>
      CompoundInterestState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        initialInvestment: initialInvestment ?? this.initialInvestment,
        monthlyContribution: monthlyContribution ?? this.monthlyContribution,
        annualInterestRate: annualInterestRate ?? this.annualInterestRate,
        compoundFrequency: compoundFrequency ?? this.compoundFrequency,
        years: years ?? this.years,
        futureValue: futureValue ?? this.futureValue,
        totalInvested: totalInvested ?? this.totalInvested,
        interestEarned: interestEarned ?? this.interestEarned,
        totalContributions: totalContributions ?? this.totalContributions,
        yearlyGrowth: yearlyGrowth ?? this.yearlyGrowth,
        selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        initialInvestment,
        monthlyContribution,
        annualInterestRate,
        compoundFrequency,
        years,
        futureValue,
        totalInvested,
        interestEarned,
        totalContributions,
        yearlyGrowth,
        selectedCurrency,
      ];
}

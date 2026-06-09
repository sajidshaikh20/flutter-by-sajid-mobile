import '../../../utils/exports.dart';

/// State class for Compound Interest screen.
class CompoundInterestState extends BaseState {
  const CompoundInterestState({
    this.initialInvestment = 10000.0,
    this.monthlyContribution = 500.0,
    this.annualInterestRate = 12.0,
    this.compoundFrequency = 'Monthly',
    this.years = 10,
    this.futureValue = 148023.21,
    this.totalInvested = 70000.0,
    this.interestEarned = 78023.21,
    this.totalContributions = 60000.0,
    this.yearlyGrowth = const <double>[10000.0, 148023.21],
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
      ];
}

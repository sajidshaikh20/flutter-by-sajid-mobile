import '../../../utils/exports.dart';

/// Cubit managing Compound Interest page state and mathematical projections.
class CompoundInterestCubit extends BaseCubit<CompoundInterestState> {
  CompoundInterestCubit() : super(CompoundInterestState.initial()) {
    calculate();
  }

  /// Updates initial investment.
  void updateInitialInvestment(double value) {
    emit(state.copyWith(initialInvestment: value));
    calculate();
  }

  /// Updates monthly contribution.
  void updateMonthlyContribution(double value) {
    emit(state.copyWith(monthlyContribution: value));
    calculate();
  }

  /// Updates annual interest rate.
  void updateAnnualInterestRate(double value) {
    emit(state.copyWith(annualInterestRate: value));
    calculate();
  }

  /// Updates compounding frequency.
  void updateCompoundFrequency(String freq) {
    emit(state.copyWith(compoundFrequency: freq));
    calculate();
  }

  /// Updates duration in years.
  void updateYears(int val) {
    emit(state.copyWith(years: val));
    calculate();
  }

  /// Performs the compound interest month-by-month calculation and populates historical growth.
  void calculate() {
    final double p = state.initialInvestment;
    final double pmt = state.monthlyContribution;
    final double r = state.annualInterestRate / 100.0;
    final String freq = state.compoundFrequency;
    final int t = state.years;

    double k = 12.0;
    switch (freq) {
      case 'Daily':
        k = 365.0;
      case 'Weekly':
        k = 52.0;
      case 'Monthly':
        k = 12.0;
      case 'Quarterly':
        k = 4.0;
      case 'Semi-Annually':
        k = 2.0;
      case 'Annually':
        k = 1.0;
    }

    // Equivalent monthly interest rate
    final double rm = pow(1.0 + r / k, k / 12.0) - 1.0;

    double balance = p;
    final List<double> growth = <double>[p];

    final int totalMonths = t * 12;
    for (int m = 1; m <= totalMonths; m++) {
      // Compounding applied monthly with deposits at the end of each month
      balance = balance * (1.0 + rm) + pmt;

      // Record balance at the end of each year
      if (m % 12 == 0) {
        growth.add(balance);
      }
    }

    // If years is 0, make sure growth has at least year 0
    if (growth.length == 1 && t > 0) {
      growth.add(balance);
    }

    final double totalCont = pmt * 12 * t;
    final double totalInv = p + totalCont;
    final double interest = balance - totalInv;

    emit(state.copyWith(
      futureValue: balance,
      totalInvested: totalInv,
      interestEarned: interest > 0 ? interest : 0.0,
      totalContributions: totalCont,
      yearlyGrowth: growth,
    ));
  }

  @override
  CompoundInterestState getResetErrorState() => state.copyWith(msg: '');

  @override
  CompoundInterestState getResetRedirectionState() => state.copyWith();
}

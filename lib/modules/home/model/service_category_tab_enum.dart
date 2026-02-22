/// Enum representing the All Services category tabs.
enum ServiceCategoryTab {
  /// Banking services category.
  bankingServices('Banking Services'),

  /// Recharge and bill pay category.
  rechargeAndBillPay('Recharge And Bill Pay'),

  /// Tour and travel category.
  tourAndTravel('Tour & Travel');

  /// Creates a [ServiceCategoryTab] with the given display label.
  const ServiceCategoryTab(this.label);

  /// Display label for the tab.
  final String label;

  /// All tab values for iteration.
  static const List<ServiceCategoryTab> tabs = <ServiceCategoryTab>[
    ServiceCategoryTab.bankingServices,
    ServiceCategoryTab.rechargeAndBillPay,
    ServiceCategoryTab.tourAndTravel,
  ];
}

/// Model class representing a gift card amount option.
class AmountModel {
  /// Whether this amount is currently selected.
  final bool isSelected;

  /// The price amount as a string (e.g., "120 KD").
  final String price;

  /// Creates an instance of [AmountModel].
  AmountModel({
    required this.isSelected,
    required this.price,
  });

  /// Predefined list of gift card amount options for display.
  static final List<AmountModel> dummyAmounts = <AmountModel>[
    AmountModel(
      isSelected: true,
      price: '120 KD',
    ),
    AmountModel(
      isSelected: false,
      price: '100 KD',
    ),
    AmountModel(
      isSelected: false,
      price: '300 KD',
    ),
  ];
}

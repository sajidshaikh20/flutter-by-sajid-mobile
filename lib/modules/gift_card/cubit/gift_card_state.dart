import '../../../utils/exports.dart';

/// Immutable state representing the gift card screen.
class GiftCardState extends BaseState {
  /// The index of the currently selected predefined amount.
  final int selectedAmountIndex;

  /// The index of the last selected predefined amount (used for restoration).
  final int lastSelectedAmountIndex; // Stores previous selection

  /// Controller for the recipient full name input field.
  final TextEditingController recipientFullNameController;

  /// Controller for the recipient email input field.
  final TextEditingController recipientEmailController;

  /// Controller for the custom amount input field.
  final TextEditingController customAmountController;

  /// Focus node for the recipient full name input field.
  final FocusNode recipientFullNameFocusNode;

  /// Focus node for the recipient email input field.
  final FocusNode recipientEmailFocusNode;

  /// Focus node for the custom amount input field.
  final FocusNode customAmountFocusNode;

  /// Validation error message for the recipient full name field.
  final String? recipientFullNameErrorMessage;

  /// Validation error message for the recipient email field.
  final String? recipientEmailErrorMessage;

  /// Creates an instance of [GiftCardState].
  const GiftCardState({
    required super.status,
    this.selectedAmountIndex = 0,
    required this.recipientFullNameController,
    required this.recipientEmailController,
    required this.customAmountController,
    required this.recipientFullNameFocusNode,
    required this.recipientEmailFocusNode,
    required this.customAmountFocusNode,
    this.recipientFullNameErrorMessage,
    this.lastSelectedAmountIndex = 0,
    this.recipientEmailErrorMessage,
  });

  @override
  List<Object?> get props => <Object?>[
        status,
        selectedAmountIndex,
        recipientFullNameController,
        recipientEmailController,
        recipientFullNameFocusNode,
        recipientEmailFocusNode,
        customAmountFocusNode,
        recipientFullNameErrorMessage,
        recipientEmailErrorMessage,
        lastSelectedAmountIndex,
      ];

  /// Creates a copy of this [GiftCardState] with optional new values.
  GiftCardState copyWith({
    BaseStateStatus? status,
    int? selectedAmountIndex,
    TextEditingController? recipientFullNameController,
    TextEditingController? recipientEmailController,
    TextEditingController? customAmountController,
    FocusNode? recipientFullNameFocusNode,
    FocusNode? recipientEmailFocusNode,
    FocusNode? customAmountFocusNode,
    String? recipientFullNameErrorMessage,
    String? recipientEmailErrorMessage,
    int? lastSelectedAmountIndex,
  }) {
    return GiftCardState(
      status: status ?? this.status,
      selectedAmountIndex: selectedAmountIndex ?? this.selectedAmountIndex,
      lastSelectedAmountIndex:
          lastSelectedAmountIndex ?? this.lastSelectedAmountIndex,
      recipientFullNameController:
          recipientFullNameController ?? this.recipientFullNameController,
      recipientEmailController:
          recipientEmailController ?? this.recipientEmailController,
      customAmountController:
          customAmountController ?? this.customAmountController,
      recipientFullNameFocusNode:
          recipientFullNameFocusNode ?? this.recipientFullNameFocusNode,
      recipientEmailFocusNode:
          recipientEmailFocusNode ?? this.recipientEmailFocusNode,
      customAmountFocusNode:
          customAmountFocusNode ?? this.customAmountFocusNode,
      recipientFullNameErrorMessage:
          recipientFullNameErrorMessage ?? this.recipientFullNameErrorMessage,
      recipientEmailErrorMessage:
          recipientEmailErrorMessage ?? this.recipientEmailErrorMessage,
    );
  }

  /// Creates an initial state instance.
  factory GiftCardState.initial() {
    return GiftCardState(
      status: BaseStateStatus.initial,
      recipientFullNameController: TextEditingController(),
      recipientEmailController: TextEditingController(),
      customAmountController: TextEditingController(),
      recipientFullNameFocusNode: FocusNode(),
      recipientEmailFocusNode: FocusNode(),
      customAmountFocusNode: FocusNode(),
    );
  }
}

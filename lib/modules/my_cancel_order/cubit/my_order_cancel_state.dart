import '../../../utils/exports.dart';

/// State for managing the order cancellation process.
class MyOrderCancelState extends BaseState {

  /// Creates an instance of MyOrderCancelState with required parameters.
  const MyOrderCancelState({
    required this.commentEditingController,
    required this.formKey,
    required super.status,
    super.msg,
    super.redirectRoute,
    this.showDefaultErrMsg = false,
    this.showSelectionErrMsg = false,
    this.cancelReasongList = const <String>[],
    this.selectedIndex = -1,
  });

  /// Controller for the comment input field.
  final TextEditingController commentEditingController;

  /// Key used to identify the form in the UI.
  final GlobalKey<FormState> formKey;

  /// Index of the selected cancellation reason.
  final int selectedIndex;

  /// List of available cancellation reasons.
  final List<String> cancelReasongList;

  /// Flag to indicate if the default error message should be shown.
  final bool? showDefaultErrMsg;

  /// Flag to indicate if the selection error message should be shown.
  final bool? showSelectionErrMsg;

  /// Returns a list of properties for comparison in testing.
  @override
  List<Object?> get props => <Object?>[
    cancelReasongList,
    selectedIndex,
    showDefaultErrMsg,
    showSelectionErrMsg,
    ...super.props,
  ];

  /// Creates a copy of the state with updated values.
  MyOrderCancelState copyWith({
    required BaseStateStatus status,
    List<String>? cancelReasongList,
    int? selectedIndex,
    PageRouteInfo? redirectRoute,
    String? msg,
    bool? showDefaultErrMsg,
    bool? showSelectionErrMsg,
  }) =>
      MyOrderCancelState(
        status: status,
        cancelReasongList: cancelReasongList ?? this.cancelReasongList,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        redirectRoute: redirectRoute,
        msg: msg,
        showDefaultErrMsg: showDefaultErrMsg ?? this.showDefaultErrMsg,
        showSelectionErrMsg: showSelectionErrMsg ?? this.showSelectionErrMsg,
        formKey: formKey,
        commentEditingController: commentEditingController,
      );
}

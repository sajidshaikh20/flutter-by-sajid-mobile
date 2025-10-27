import '../../../utils/exports.dart';

/// State class responsible for managing the state of the user's return orders.
/// It extends from [BaseState] and includes properties like [myReturnOrderList],
/// which contains the list of return orders.
class MyReturnState extends BaseState {
  /// Constructor to initialize the [MyReturnState] with [status], [myReturnOrderList],
  /// [redirectRoute], and an optional ] (defaults to empty string).
  const MyReturnState({
    required super.status,
    this.myReturnOrderList, // A nullable property holding the return order list.
    super.redirectRoute,
    super.msg = '', // Default empty string for error message.
  });

  /// A nullable model that holds the return order list.
  final MyReturnModel? myReturnOrderList;

  /// Creates a copy of the current [MyReturnState]
  /// with optional overrides for its properties.
  ///
  /// The copyWith method allows for modifying specific fields
  /// of the state without
  /// changing others. For example, it allows updating the [status]
  /// or [myReturnOrderList].
  MyReturnState copyWith({
    BaseStateStatus? status,
    PageRouteInfo? redirectRoute,
    MyReturnModel? myReturnOrderList,
    String? errorMessage,
  }) =>
      MyReturnState(
        status: status ?? this.status,
        msg: errorMessage,
        myReturnOrderList: myReturnOrderList ?? this.myReturnOrderList,
        redirectRoute: redirectRoute ?? this.redirectRoute,
      );

  /// Overrides [BaseState]'s `props` to include the [myReturnOrderList]
  /// in the comparison
  /// when determining whether two states are equal or not.
  /// This is useful for testing
  /// and state equality checks.
  @override
  List<Object?> get props => <Object?>[
        myReturnOrderList,
        ...super.props,
      ];
}

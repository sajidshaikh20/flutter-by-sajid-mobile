import '../../../utils/exports.dart';

/// Represents the state for order details, extending BaseState.
class MyOrderDetailState extends BaseState {
  /// Initializes order detail state with default and provided values.
  const MyOrderDetailState({
    required super.status,
    super.msg = '',
    super.redirectRoute,
    this.showDefaultErrMsg = false,
    this.incrementId = '',
    this.orderId,
    this.response,
    this.orderDetailsList,
    this.successMsg = '',
  });

  /// Indicates whether to show the default error message.
  final bool? showDefaultErrMsg;
  /// The unique increment ID for the order.
  final String? incrementId;
  ///order Id
  final int? orderId;
  /// The response model containing order details data.
  final MyOrderDetailResponseModel? response;
  /// The list of order details data.
  final List<MyOrderDetailResponseModel>? orderDetailsList;
  /// The success message related to the order detail operation.
  final String successMsg;

  @override
  List<Object?> get props => <Object?>[
        response,
        orderDetailsList,
        showDefaultErrMsg,
        successMsg,
        orderId,
        ...super.props,
      ];

  /// Creates a copy of the state with updated values for specific fields.
  MyOrderDetailState copyWith({
    required BaseStateStatus? status,
    PageRouteInfo? redirectRoute,
    String? msg,
    bool? showDefaultErrMsg,
    String? incrementId,
    int? orderId,
    MyOrderDetailResponseModel? response,
    List<MyOrderDetailResponseModel>? orderDetailsList,
    String? successMsg,
  }) =>
      MyOrderDetailState(
        status: status ?? this.status,
        redirectRoute: redirectRoute,
        msg: msg,
        showDefaultErrMsg: showDefaultErrMsg ?? this.showDefaultErrMsg,
        incrementId: incrementId ?? this.incrementId,
        response: response ?? this.response,
        orderDetailsList: orderDetailsList ?? this.orderDetailsList,
        successMsg: successMsg ?? this.successMsg,
        orderId: orderId ?? this.orderId,
      );
}

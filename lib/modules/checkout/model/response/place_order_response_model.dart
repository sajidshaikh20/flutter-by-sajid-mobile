import '../../../../utils/exports.dart';

part 'place_order_response_model.g.dart';

@JsonSerializable(ignoreUnannotated: false)
/// A model class representing the response from placing an order.
class PlaceOrderResponseModel {

  /// Creates a new instance of [PlaceOrderResponseModel].
  ///
  /// [success] The success status of the order placement.
  /// [message] The message providing details of the order status.
  /// [cartCount] The count of items in the cart at the time of placing the order.
  /// [isSplitOrder] Indicates whether the order is split into multiple parts.
  /// [email] The customer's email associated with the order.
  /// [canReorder] Indicates whether the customer can reorder the placed order.
  /// [customerDetails] Contains details of the customer placing the order.
  /// [orderIds] A list of order IDs generated for the placed order.
  /// [incrementIds] A list of increment IDs for the placed order.
  /// [orderId] The unique identifier for the placed order.
  /// [incrementId] The unique increment ID for the placed order.
  /// [timeslotDetails] Contains information about the delivery timeslot.
  /// [date] The date the order was placed.
  /// [total] The total amount of the order in integer form.
  /// [formattedTotal] The formatted total amount of the order.
  /// [amountLabel] The label for the total amount.
  /// [orderLabel] The label for the order.
  PlaceOrderResponseModel({
    this.success,
    this.message,
    this.cartCount,
    this.isSplitOrder,
    this.email,
    this.canReorder,
    this.customerDetails,
    this.orderIds,
    this.incrementIds,
    this.orderId,
    this.incrementId,
    this.timeslotDetails,
    this.date,
    this.total,
    this.formattedTotal,
    this.amountLabel,
    this.orderLabel,
  });

  /// Creates a [PlaceOrderResponseModel] from a JSON map.
  ///
  /// The [json] map must contain keys matching the parameters of the constructor.
  factory PlaceOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderResponseModelFromJson(json);

  /// The success status of the order placement.
  @JsonKey(name: 'success')
  final bool? success;

  /// The message providing details of the order status.
  @JsonKey(name: 'message')
  final String? message;

  /// The count of items in the cart at the time of placing the order.
  @JsonKey(name: 'cartCount')
  final int? cartCount;

  /// Indicates whether the order is split into multiple parts.
  @JsonKey(name: 'isSplitOrder')
  final int? isSplitOrder;

  /// The customer's email associated with the order.
  @JsonKey(name: 'email')
  final String? email;

  /// Indicates whether the customer can reorder the placed order.
  @JsonKey(name: 'canReorder')
  final bool? canReorder;

  /// Contains details of the customer placing the order.
  @JsonKey(name: 'customerDetails')
  final CustomerDetails? customerDetails;

  /// A list of order IDs generated for the placed order.
  @JsonKey(name: 'orderIds')
  final List<String>? orderIds;

  /// A list of increment IDs for the placed order.
  @JsonKey(name: 'incrementIds')
  final List<String>? incrementIds;

  /// The unique identifier for the placed order.
  @JsonKey(name: 'orderId')
  final String? orderId;

  /// The unique increment ID for the placed order.
  @JsonKey(name: 'incrementId')
  final String? incrementId;

  /// Contains information about the delivery timeslot.
  @JsonKey(name: 'timeslotDetails')
  final TimeslotDetails? timeslotDetails;

  /// The date the order was placed.
  @JsonKey(name: 'date')
  final String? date;

  /// The total amount of the order in integer form.
  @JsonKey(name: 'total')
  final int? total;

  /// The formatted total amount of the order.
  @JsonKey(name: 'formattedTotal')
  final String? formattedTotal;

  /// The label for the total amount.
  @JsonKey(name: 'amountLabel')
  final String? amountLabel;

  /// The label for the order.
  @JsonKey(name: 'orderLabel')
  final String? orderLabel;

  /// Converts the [PlaceOrderResponseModel] instance into a JSON map.
  ///
  /// Returns a map of key-value pairs representing the order response's fields.
  Map<String, dynamic> toJson() => _$PlaceOrderResponseModelToJson(this);
}


@JsonSerializable(ignoreUnannotated: false)
/// A model class representing the details of a customer.
class CustomerDetails {

  /// Creates a new instance of [CustomerDetails].
  ///
  /// [guestCustomer] The guest customer flag (1 for guest, 0 for registered).
  /// [groupId] The customer group ID.
  /// [firstname] The first name of the customer.
  /// [email] The email address of the customer.
  /// [lastname] The last name of the customer.
  CustomerDetails({
    this.guestCustomer,
    this.groupId,
    this.firstname,
    this.email,
    this.lastname,
  });

  /// Creates a [CustomerDetails] from a JSON map.
  ///
  /// The [json] map must contain keys matching the parameters of the constructor.
  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      _$CustomerDetailsFromJson(json);

  /// The guest customer flag (1 for guest, 0 for registered).
  @JsonKey(name: 'guestCustomer')
  final int? guestCustomer;

  /// The customer group ID.
  @JsonKey(name: 'groupId')
  final int? groupId;

  /// The first name of the customer.
  @JsonKey(name: 'firstname')
  final String? firstname;

  /// The email address of the customer.
  @JsonKey(name: 'email')
  final String? email;

  /// The last name of the customer.
  @JsonKey(name: 'lastname')
  final String? lastname;

  /// Converts the [CustomerDetails] instance into a JSON map.
  ///
  /// Returns a map of key-value pairs representing the customer details.
  Map<String, dynamic> toJson() => _$CustomerDetailsToJson(this);
}

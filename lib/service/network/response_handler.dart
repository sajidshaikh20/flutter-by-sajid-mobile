import '../../utils/exports.dart';

/// This class is used to handle success and failure of the APIs.
abstract class ResponseHandler<T> {

  /// Returns the instance representing a successful response.
  OnSuccessResponse<T>? getSuccessInstance();

  /// Returns the instance representing a failed response.
  OnFailureResponse<T>? getFailureInstance();

  /// Checks if the response was successful.
  bool isSuccess();

  // bool isLoading(); // Optional method for loading state (if needed)

  /// Checks if the response was a failure.
  bool isFailure();
}


/// This class is used to represent Success Response.
///
/// Response is handled using generics.
class OnSuccessResponse<T> extends ResponseHandler<T> {

  /// Constructor that accepts the successful response.
  OnSuccessResponse({required this.response});

  /// The actual response data of type [T].
  final T response;

  /// To avoid type casting everywhere in the app we have added this
  /// helping method to get instance of
  /// [OnFailureResponse] class without heavy type castings.
  @override
  OnFailureResponse<T>? getFailureInstance() => null;

  /// To avoid type casting everywhere in the app we have added this
  /// helping method to get instance of
  /// [OnSuccessResponse] class without heavy type castings.
  @override
  OnSuccessResponse<T>? getSuccessInstance() => this;

  /// To avoid type casting everywhere in the app we have added this
  /// helping method to determine directly that
  /// it's success or failure instance.
  @override
  bool isFailure() => false;

  /// To avoid type casting everywhere in the app we have added this
  /// helping method to determine directly
  /// that it's success or failure instance.
  @override
  bool isSuccess() => true;
}


/// This class is used to represent Failure Response.
///
/// Response is handled using generics.
class OnFailureResponse<T> extends ResponseHandler<T> {

  /// Constructor that accepts the failure details.
  OnFailureResponse({this.statusCode, this.error});

  /// The status code of the failure response.
  final int? statusCode;

  /// The error details in case of failure.
  final ErrorResult? error;

  /// To avoid type casting everywhere in the app we have added this
  /// helping method to get instance of
  /// [OnFailureResponse] class without heavy type castings.
  @override
  OnFailureResponse<T>? getFailureInstance() => this;

  /// To avoid type casting everywhere in the app we have added this
  /// helping method to get instance of
  /// [OnSuccessResponse] class without heavy type castings.
  @override
  OnSuccessResponse<T>? getSuccessInstance() => null;

  /// To avoid type casting everywhere in the app we have added this
  /// helping method to determine directly that
  /// it's success or failure instance.
  @override
  bool isFailure() => true;

  /// To avoid type casting everywhere in the app we have added this
  /// helping method to determine directly that it's
  /// success or failure instance.
  @override
  bool isSuccess() => false;
}


// class OnLoading extends ResponseHandler {}

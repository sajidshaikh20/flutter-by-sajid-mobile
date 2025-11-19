import '../../utils/exports.dart';

/// Represents an error result containing the error message, type, and status.
class ErrorResult {
  /// Constructs an [ErrorResult] with the given error
  /// message, type, and retry status.
  ErrorResult({
    required this.errorMessage,
    required this.type,
    this.isRetry = false,
    this.statusCode,
  });

  /// Factory method to generate an [ErrorResult] based on a DioException.
  factory ErrorResult.getErrorResult(dynamic exception) {
    if (exception is DioException) {
      switch (exception.type) {
        case DioExceptionType.cancel:
          return ErrorResult(
            errorMessage: "Cancel",
            type: DioExceptionType.cancel,
          );

        case DioExceptionType.connectionTimeout:
          return ErrorResult(
            errorMessage: "Something Went Wrong",
            type: DioExceptionType.connectionTimeout,
          );
        case DioExceptionType.sendTimeout:
          return ErrorResult(
            errorMessage: "Something Went Wrong",
            type: DioExceptionType.sendTimeout,
          );
        case DioExceptionType.receiveTimeout:
          return ErrorResult(
            errorMessage: "Something Went Wrong",
            type: DioExceptionType.receiveTimeout,
          );
        case DioExceptionType.badResponse:
          return ErrorResult(
            errorMessage: "Something Went Wrong",
            type: DioExceptionType.badResponse,
          );

        case DioExceptionType.unknown:
          return ErrorResult(
            errorMessage: "Something Went Wrong",
            type: DioExceptionType.connectionError,
          );
        // default:
        //   return ErrorResult(
        //     errorMessage: exception.message ??
        //         MainConfig.dynamicString(
        //           JsonServiceString.keySomethingWentWrong,
        //         ),
        //     type: DioExceptionType.unknown,
        //   );
        case DioExceptionType.badCertificate:
          return ErrorResult(
            errorMessage: exception.message ??
                "Something Went Wrong",
            type: DioExceptionType.badCertificate,
          );
        case DioExceptionType.connectionError:
          return ErrorResult(
            errorMessage: exception.message ??
                "Something Went Wrong",
            type: DioExceptionType.connectionError,
          );
      }
    } else {
      return ErrorResult(
        errorMessage: (exception is DioException ? exception.message : null) ??
            "Something Went Wrong",
        type: DioExceptionType.unknown,
      );
    }

    /*else {
      return ErrorResult(
        errorMessage: exception.message ??
            MainConfig.dynamicString(JsonServiceString.keySomethingWentWrong),
        type: DioExceptionType.unknown,
      );
    }*/
  }

  /// The error message returned from the API or exception.
  String errorMessage;

  /// The type of DioException that occurred.
  DioExceptionType type;

  /// The HTTP status code, if available, otherwise -1.
  int? statusCode = -1;

  /// A flag indicating if the error should be retried.
  bool isRetry;
}

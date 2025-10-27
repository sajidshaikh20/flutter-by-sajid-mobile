import '../../utils/exports.dart';

/// Base class for ApiRepositories.
///
/// Every repository class should must extend this class.
abstract class BaseRepository {
  // final ApiClient apiClient = Get.find(tag: (ApiClient).toString());

  /// Generic Parser Function.
  ///
  /// This function will check for Success And Failure and parse the response
  /// in the Defined generic T type.
  ResponseHandler<T> getParsedResponseHandler<T>({
    required ResponseHandler<Map<String, dynamic>?> responseHandler,
    required T Function(Map<String, dynamic> value) parser,
  }) {
    try {
      if (responseHandler.isSuccess()) {
        dynamic parsedData =
            parser.call(responseHandler.getSuccessInstance()?.response ?? <String, dynamic>{});
        return OnSuccessResponse<T>(response: parsedData);
      } else {
        return OnFailureResponse<T>(
          statusCode: responseHandler.getFailureInstance()?.statusCode,
          error: responseHandler.getFailureInstance()?.error,
        );
      }
    } on Exception catch (error,printStack) {
      DebugLog.instance.d(printStack.toString());
      return OnFailureResponse<T>(
        statusCode: responseHandler.getFailureInstance()?.statusCode,
        error: responseHandler.getFailureInstance()?.error,
      );
    }
  }
}

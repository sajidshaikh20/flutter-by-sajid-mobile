import 'package:network_cache_interceptor/network_cache_interceptor.dart';

import '../../utils/exports.dart';

/// Service of [ApiClient] (DIO).
///
/// Used to provide singleton instance of [ApiClient].
class ApiClient {
  /// Private static instance of ApiClient to enforce singleton pattern
  factory ApiClient() => _instance;

  ApiClient._internal() {
    _dio = initApiHandlerDio(configBaseUrl);
    _dio?.interceptors.add(


      NetworkCacheInterceptor(
        noCacheStatusCodes: <int>[401, 403],
      ),
    );

  }

  /// The Dio instance used to make API calls.
  Dio? _dio;

  /// A tag used for logging purposes to identify API-related logs.
  String tag = 'API call :';

  /// A cancel token that can be used to cancel ongoing API requests.
  CancelToken? _cancelToken;

  static final ApiClient _instance = ApiClient._internal();

  /// Initializes a Dio instance with the given base URL and
  /// standard configurations.
  ///
  /// The function sets up Dio for making HTTP requests with necessary timeouts,
  /// headers, and content types. It also adds interceptors
  ///  for handling requests
  /// and logging in debug mode.
  ///
  /// [url] is the base URL for the API requests.
  Dio initApiHandlerDio(String url) {
    // Create a cancel token to cancel requests if needed
    _cancelToken = CancelToken();

    // Configure the base options for Dio
    BaseOptions baseOption = BaseOptions(
      // Timeout for connecting to the server
      connectTimeout: const Duration(seconds: 60),

      // Timeout for receiving a response from the server
      receiveTimeout: const Duration(seconds: 60),

      // Timeout for sending data to the server
      sendTimeout: const Duration(seconds: 60),

      // The base URL for all the API requests
      baseUrl: url,

      // Content type to be used for the requests
      contentType: 'application/json',

      // Default headers to include in every request
      headers: <String, String>{
        // 'authKey': '', // Placeholder for authorization key (if needed)
        // 'Authorization':APIConstant.bearerToken,
        // 'platform': 'mobile', // Platform info (mobile in this case)
      },
    );

    // Create a Dio instance with the configured options
    Dio mDio = Dio(baseOption);

    // Add interceptors for handling request and response behaviors
    mDio.interceptors.add(HttpHandleInterceptor());

    // Add Chucker interceptor for in-app HTTP inspection in debug mode
   /* if (kDebugMode) {
      mDio.interceptors.add(ChuckerDioInterceptor());
    }*/
    // Add a logging interceptor for debugging in development mode
    if (kDebugMode) {
      mDio.interceptors.add(
        AwesomeDioInterceptor(
          // Optionally, you could log requests here (for debugging)
          logger: (String log) => DebugLog.instance.d(log),
        ),
      );
    }

    // Return the initialized Dio instance
    return mDio;
  }

  /// Cancels ongoing requests.
  ///
  /// If a `cancelToken` is provided, the method will cancel
  ///  the request associated with that token.
  /// Otherwise, it will cancel the request associated with
  /// the default `_cancelToken`.
  void cancelRequests({CancelToken? cancelToken}) {
    // If no cancelToken is provided, use the default _cancelToken.
    cancelToken == null
        ? _cancelToken?.cancel(
        'Cancelled') // Cancel the request with the default cancel token.
        : cancelToken
        .cancel(); // Cancel the request with the provided cancel token.
  }

  /// Handles API calls (GET, POST, DELETE) with options for caching,
  /// multipart form data,
  /// and request cancellation.
  /// Returns a [ResponseHandler<T?>] containing the response data or error.
  Future<ResponseHandler<T?>> handleApiCall<T>({
    String endUrl = '',
    ApiType apiType = ApiType.get,
    bool isB2cCall = false,
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    Options? options,
    FormData? formData,
    bool isMultipartFormData = false,
    CancelToken? cancelToken,
    bool showLoader = false,
    bool dismissLoader = true,
    bool needToCache = false,
    int cacheDurationMnt = 0,
  }) async {
    late ResponseHandler<T?> handler;
    try {
      await _showLoading(showLoader);
      if (apiType == ApiType.get) {
        handler = await get<T>(
          endUrl,
          params: params,
          data: data,
          options: options,
          cancelToken: cancelToken,
          needToCache: needToCache,
          cacheDurationMnt: cacheDurationMnt,
        );
      } else if (apiType == ApiType.post) {
        handler = await post<T>(
          endUrl,
          data: data,
          params: params,
          options: options,
          cancelToken: cancelToken,
          formData: formData,
          isMultipartFormData: isMultipartFormData,
          needToCache: needToCache,
          cacheDurationMnt: cacheDurationMnt,
        );
      } else if (apiType == ApiType.patch) {
        handler = await patch<T>(
          endUrl,
          data: data,
          params: params,
          options: options,
          cancelToken: cancelToken,
          formData: formData,
          isMultipartFormData: isMultipartFormData,
          needToCache: needToCache,
          cacheDurationMnt: cacheDurationMnt,
        );
      }
      else if (apiType == ApiType.delete) {
        handler = await delete<T>(
          endUrl,
          data: data,
          params: params,
          options: options,
          cancelToken: cancelToken,
        );
      }
    } on FormatException {
      handler = OnFailureResponse<T?>(
        error: ErrorResult(
          errorMessage: APIConstant.badRequest,
          type: DioExceptionType.unknown,
        ),
      );
    } on DioException catch (e) {
      // For DioException, we can't use _responseHandler<T> since the data type is unknown
      // Instead, create a failure response directly
      String errorMessage = _extractErrorMessage(e.response?.data, e.response?.statusMessage ?? e.message ?? '');

      handler = OnFailureResponse<T?>(
        error: ErrorResult(
          errorMessage: errorMessage,
          type: e.type,
        ),
        statusCode: e.response?.statusCode,
      );
    }
    await _dismissLoading(dismissLoader);
    return handler;
  }

  /// Performs a GET request and returns a response handler.
  ///
  /// [T] is the type of the response body.
  ///
  /// [endUrl]: The endpoint URL for the GET request.
  /// [params]: Optional query parameters to send with the request.
  /// [options]: Optional additional request options.
  /// [cancelToken]: Optional cancel token to cancel the request.
  /// [needToCache]: Whether the response should be cached (default is `false`).
  /// [cacheDurationMnt]: Duration in minutes to cache the response
  ///  (only used if `needToCache` is `true`).
  FutureOr<ResponseHandler<T?>> get<T>(
      String endUrl, {
        Map<String, dynamic>? params,
        Map<String, dynamic>? data,
        Options? options,
        CancelToken? cancelToken,
        bool needToCache = false,
        int? cacheDurationMnt,
      }) async =>
      _responseHandler<T>(
        // Performing the GET request using Dio.
        await _dio?.get<T>(
          endUrl, // Endpoint URL
          data: data,
          queryParameters: params,
          // Query parameters for the request
          cancelToken: cancelToken ?? _cancelToken,
          // Use provided cancelToken or default one
          options: _handleCacheOption(
            // Handling cache option (if required)
            options,
            needToCache: needToCache,
            cacheDuration: cacheDurationMnt,
          ),
        ),
      );

  /// Performs a POST request and returns a response handler.
  ///
  /// [T] is the type of the response body.
  ///
  /// [endUrl]: The endpoint URL for the POST request.
  /// [data]: Optional body data to send in the request.
  /// [params]: Optional query parameters to send with the request.
  /// [options]: Optional additional request options.
  /// [formData]: Optional FormData to send.
  /// [cancelToken]: Optional cancel token to cancel the request.
  /// [isMultipartFormData]: Whether the data is multipart form data.
  /// [needToCache]: Whether the response should be cached (default is `false`).
  /// [cacheDurationMnt]: Duration in minutes to cache the response.
  FutureOr<ResponseHandler<T?>> post<T>(
      String endUrl, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? params,
        Options? options,
        FormData? formData,
        CancelToken? cancelToken,
        bool isMultipartFormData = false,
        bool needToCache = false,
        int? cacheDurationMnt,
      }) async =>
      _responseHandler<T>(
        // Performing the POST request using Dio.
        await _dio?.post<T>(
          endUrl, // Endpoint URL
          data: isMultipartFormData ? formData : data,
          // Use formData if multipart, else use data
          queryParameters: params,
          // Query parameters for the request
          cancelToken: cancelToken ?? _cancelToken,
          // Use provided cancelToken or default one
          options: _handleCacheOption(
            // Handling cache option (if required)
            options,
            needToCache: needToCache,
            cacheDuration: cacheDurationMnt,
          ),
        ),
      );

  /// patch api call
  FutureOr<ResponseHandler<T?>> patch<T>(
      String endUrl, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? params,
        Options? options,
        FormData? formData,
        CancelToken? cancelToken,
        bool isMultipartFormData = false,
        bool needToCache = false,
        int? cacheDurationMnt,
      }) async =>
      _responseHandler<T>(
        // Performing the POST request using Dio.
        await _dio?.patch<T>(
          endUrl, // Endpoint URL
          data: isMultipartFormData ? formData : data,
          // Use formData if multipart, else use data
          queryParameters: params,
          // Query parameters for the request
          cancelToken: cancelToken ?? _cancelToken,
          // Use provided cancelToken or default one
          options: _handleCacheOption(
            // Handling cache option (if required)
            options,
            needToCache: needToCache,
            cacheDuration: cacheDurationMnt,
          ),
        ),
      );

  /// Performs a DELETE request and returns a response handler.
  ///
  /// [T] is the type of the response body.
  ///
  /// [endUrl]: The endpoint URL for the DELETE request.
  /// [data]: Optional body data to send in the request.
  /// [params]: Optional query parameters to send with the request.
  /// [options]: Optional additional request options.
  /// [cancelToken]: Optional cancel token to cancel the request.
  FutureOr<ResponseHandler<T?>> delete<T>(
      String endUrl, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async =>
      _responseHandler<T>(
        // Performing the DELETE request using Dio.
        await _dio?.delete<T>(
          endUrl, // Endpoint URL
          data: data,
          // Optional body data (may be used depending on API)
          queryParameters: params,
          // Query parameters for the request
          cancelToken: cancelToken ?? _cancelToken,
          // Use provided cancelToken or default one
          options: options, // Additional request options (headers, etc.)
        ),
      );

  // Modifies the given [options] to enable caching if [needToCache] is true.
  /// Adds 'cache' and 'validate_time' to the extra field to
  /// specify cache settings.
  /// Returns updated [options] or the original [options]
  /// if caching is not needed.
  Options? _handleCacheOption(
      Options? options, {
        bool needToCache = false,
        int? cacheDuration,
      }) {
    if (needToCache) {
      options = options ?? Options();
      return options.copyWith(
        extra: <String, Object?>{
          ApiConst.cacheArgument: needToCache,
          // Explicitly enable caching
          ApiConst.cacheDurationArgument: cacheDuration,
          // Cache validity time (minutes)
        },
      );
    }
    return options;
  }

  /// Downloads a file from the given [url]
  /// and saves it with the specified [fileName].
  /// Returns the file path where the file is saved.
  Future<String> downloadFile({
    required String url,
    required String fileName,
    Function(int received, int total)? onProgress,
    bool showLoader = true,
    bool dismissLoader = true,
  }) async {
    try {
      await _showLoading(showLoader);
      // Get the directory to save the file
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/$fileName';

      Dio downloadDio = Dio();

      // Download the file and save it to the specified path
      await downloadDio.download(
        url,
        filePath,
        onReceiveProgress: onProgress,
      );

      return fileName;
    } on Exception catch (e, printstack) {
      DebugLog.instance.d('Error downloading file: $e');
      DebugLog.instance.d('printstack downloading file: $printstack');
      return '';
    } finally {
      await _dismissLoading(dismissLoader);
    }
  }

  /// Helper method to extract error message from response data
  String _extractErrorMessage(dynamic responseData, String defaultMessage) {
    try {
      if (responseData != null) {
        if (responseData is Map) {
          final Map<String, dynamic> data = responseData as Map<String, dynamic>;
          if (data.containsKey('message') && data['message'] != null) {
            return data['message'].toString();
          }
        } else if (responseData is String && responseData.toString().isNotEmpty) {
          return responseData.toString();
        }
      }
    } on Exception catch (e) {
    DebugLog.instance.d(e.toString());
    }
    return defaultMessage;
  }

  ResponseHandler<T?> _responseHandler<T>(Response<T>? response) {
    if (response?.statusCode == 200) {
      return OnSuccessResponse<T?>(response: response?.data);
    } else if (response?.statusCode == 400) {
      final String message = _extractErrorMessage(response?.data, APIConstant.badRequestStateKey);
      return OnFailureResponse<T?>(
        error: ErrorResult(
          errorMessage: message,
          type: DioExceptionType.badResponse,
        ),
        statusCode: 400,
      );
    } else if (response?.statusCode == 401) {
      final String message = _extractErrorMessage(response?.data, APIConstant.unauthorizedKey);
      return OnFailureResponse<T?>(
        error: ErrorResult(
          errorMessage: message,
          type: DioExceptionType.badResponse,
        ),
        statusCode: 401,
      );
    } else if (response?.statusCode == 404) {
      final String message = _extractErrorMessage(response?.data, '');
      return OnFailureResponse<T?>(
        error: ErrorResult(
          errorMessage: message,
          type: DioExceptionType.badResponse,
        ),
        statusCode: 404,
      );
    } else if (response?.statusCode == 500) {
      final String message = _extractErrorMessage(response?.data, APIConstant.serverNotRespondKey);
      return OnFailureResponse<T?>(
        error: ErrorResult(
          errorMessage: message,
          type: DioExceptionType.badResponse,
        ),
        statusCode: 500,
      );
    } else {
      return OnFailureResponse<T?>(
        error: ErrorResult(
          errorMessage: "Something Went Wrong",
          type: DioExceptionType.unknown,
        ),
      );
    }
  }


  //use in future for error handling
  /* ResponseHandler<T?> _errorHandler<T>(DioException error) {
    if (error.type == DioExceptionType.badResponse) {
      return OnSuccessResponse<T?>(response: error.response?.data);
    }
    return OnFailureResponse(error: ErrorResult.getErrorResult(error));
  }*/

  Future<void> _showLoading(bool showLoader) async {
    if (showLoader) {
      await EasyLoading.show();
    }
  }

  Future<void> _dismissLoading(bool dismissLoader) async {
    if (dismissLoader) {
      await EasyLoading.dismiss();
    }
  }

  /// Sends a request to refresh the token.
  /// Returns the raw [Response] from the API.
  Future<Response<dynamic>?>? handleRefreshToken(
      String endUrl, {
        Map<String, dynamic>? params,
        Map<String, dynamic>? data,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    Response<dynamic>? response = await _dio?.request(
      endUrl,
      data: data,
      queryParameters: params,
      cancelToken: cancelToken,
      options: options,
    );
    return response;
  }
}

/// Interceptor to intercept api request and response.
class HttpHandleInterceptor extends Interceptor {
  /// Tracks if the internet connection dialog is currently visible.
  static bool isInternetDialogVisible = false;

  /// Indicates if a 401 Unauthorized error request is currently in progress.
  static bool is401InProgress = false;

  FutureOr<bool> _checkInternet() async {
    List<ConnectivityResult> connectivityResult =
    await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    }
    return false;
  }

  ///this method is used to check internet connection
  ///if internet is not available then it will show dialog
  ///to retry or cancel the api call
  ///if dialog is visible then it will reject the current api call
  Future<void> _checkInternetConnection(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    bool isConnected = await _checkInternet();

    if (isConnected) {
      // Proceed with the API call if the internet is available
      handler.next(options);
    } else {
      await _dismissLoading();
      // Ensure the request completes with an error instead of hanging
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'No Internet Connection',
        ),
      );
    }

    /**
     *  this needs to be kept for the no internet screen,
     *  commenting as of now because work is pending
     */
    // if (isConnected) {
    //   handler.next(options);
    // } else {
    //   _dismissLoading();
    //   final requestOptions = options;
    //   final router = MainConfig.context.router;
    //   bool isNoInternetPageInStack =
    //       router.stack.any((route) => route.name == NoInternetRoute.name);
    //   if (!isNoInternetPageInStack) {
    //     MainConfig.context.router.push(NoInternetRoute(onTryAgain: () async {
    //       var isConnected = await _checkInternet();
    //       if (isConnected) {
    //         MainConfig.context.router.maybePop();
    //         retryApiCall(requestOptions, handler);
    //       }
    //     }));
    //   } else {
    //     // handler.reject(DioException(
    //     //   requestOptions: options,
    //     //   error: 'No Internet',
    //     // ));
    //   }
    // }
  }

  /// Retries an API call with the same request options.
  ///
  /// This method attempts to re-execute the API call using the provided
  /// [RequestOptions]. If the request is successful, it resolves the handler
  /// with the response. If an error occurs,
  /// it rejects the handler with the error.
  ///
  /// [options] - The [RequestOptions] used for the retry.
  /// [handler] - The [RequestInterceptorHandler] to resolve
  /// or reject the response.
  Future<void> retryApiCall(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    try {
      // Retry the API call with the same options
      Response<dynamic> response = await Dio().fetch(options);
      handler.resolve(response);
    } on Exception catch (error) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: error,
        ),
      );
    }
  }

  static String _tokenFromProfileJson(String jsonStr) {
    if (jsonStr.isEmpty) return '';
    try {
      final Map<String, dynamic> map = jsonDecode(jsonStr) as Map<String, dynamic>;
      return map['customerToken'] as String? ?? '';
    } on Object catch (_) {
      return '';
    }
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path == Apis.reviewAndPayment) {
      final String profileJson = SharedPref.instance.getString(PrefsKey.userProfileKey, '');
      final String authToken = _tokenFromProfileJson(profileJson);
      options.headers.addAll(<String,dynamic>{'Authorization': authToken});
    } else if (options.path == Apis.placeOrder) {
      final String profileJson = SharedPref.instance.getString(PrefsKey.userProfileKey, '');
      final String authToken = _tokenFromProfileJson(profileJson);
      options.headers.clear();
      options.headers.addAll(<String,dynamic>{
        'Content-Type': APIConstant.contentType,
        'Authorization': authToken,
        'Cookie': APIConstant.cookie,
      });
    }
    await _checkInternetConnection(options, handler);
  }

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    if (err.response?.statusCode == 401 && !is401InProgress) {
      is401InProgress = true;

      // Log the 401 error for debugging
      DebugLog.instance.e('API 401 Error: ${err.requestOptions.path}');
      DebugLog.instance.e('Request data: ${err.requestOptions.data}');
      DebugLog.instance.e('Response: ${err.response?.data}');

      // Check if this is a critical API that should trigger logout
      bool isCriticalApi = _isCriticalApi(err.requestOptions.path);

      if (isCriticalApi) {
        DebugLog.instance.e('Critical API 401 - Clearing user data and redirecting to login');
        await SharedPref.instance.clearData();
        MainConfig.context.router.popUntilRoot();
      } else {
        DebugLog.instance.w('Non-critical API 401 - Not clearing user data, just logging error');
        // For non-critical APIs, just log the error but don't clear data
        // This prevents accidental data clearing for minor API issues
      }

      is401InProgress = false;
    } else {
      return handler.next(err);
    }
  }

  /// Check if the API endpoint is critical and should trigger logout on 401
  bool _isCriticalApi(String path) {
    // Define critical APIs that should trigger logout on 401
    final List<String> criticalApis = <String>[
      Apis.login,
      Apis.getAccountInfo,
      Apis.editProfile,
      Apis.logout,
      Apis.deleteAccount,
    ];

    return criticalApis.any((String api) => path.contains(api));
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) =>
      handler.next(response);

  Future<void> _dismissLoading() async {
    await EasyLoading.dismiss();
  }
}

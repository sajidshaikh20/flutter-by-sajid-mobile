import '../../../utils/exports.dart';

/// Implementation of [LanguageSelectionRepository] that handles
/// fetching available languages from the API and downloading language files.
class LanguageSelectionRepositoryImpl extends LanguageSelectionRepository {
  ///The `getLanguageList` method  an API call to retrieve a list of languages based
  /// on the provided `LanguageRequestModel`.
  @override
  Future<ResponseHandler<BaseResponse<LanguageResponseModel>>> getLanguageList(
      // {required LanguageRequestModel languageRequestModel,
        /*  {bool showLoader = true}*/) async {
    final ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.listOfCountryAndLanguage,
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        // Parse using BaseResponse structure
        return BaseResponse<LanguageResponseModel>.fromJson(
          value,
              (Object? json) => LanguageResponseModel.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  /// Downloads a file from the given [url] and stores it in the app's storage with the given [fileName].
  /// Returns the file path of the downloaded file.
  @override
  FutureOr<String> downloadFileAndStoreInAppStorage(
      {required String url,
      required String fileName,
      Function(int received, int total)? onProgress,
      bool showLoader = false}) async {
    return await MainConfig.apiClient.downloadFile(
        url: url,
        fileName: fileName,
        onProgress: onProgress,
        showLoader: showLoader);
  }
}

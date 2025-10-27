import '../../../utils/exports.dart';

/// Implementation of [LanguageSelectionRepository] that handles
/// fetching available languages from the API and downloading language files.
abstract class LanguageSelectionRepository extends BaseRepository {
  ///The `getLanguageList` method  an API call to retrieve a list of languages based
  /// on the provided `LanguageRequestModel`.
  Future<ResponseHandler<BaseResponse<LanguageResponseModel>>> getLanguageList(
      // {required LanguageRequestModel languageRequestModel,
      //     {bool showLoader = true}
      );


  /// Downloads a file from the given [url] and stores it in the app's storage with the given [fileName].
  /// Returns the file path of the downloaded file.
  FutureOr<String> downloadFileAndStoreInAppStorage(
      {required String url,
      required String fileName,
      Function(int received, int total)? onProgress,
      bool showLoader = false});
}

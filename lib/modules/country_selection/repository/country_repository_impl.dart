import '../../../utils/exports.dart';

/// A concrete implementation of the [CountryRepository] that handles
/// fetching country data from an API.
class CountryRepositoryImpl extends CountryRepository {
  /// Fetches the list of countries by making an API call.
  ///
  /// This method calls the API client to fetch country data from the endpoint
  /// defined in [Apis.getCountryList].
  /// Once the response is received, it is
  /// parsed into a [CountryResponseModel] using the
  /// `getParsedResponseHandler` method.
  ///
  /// Returns a [ResponseHandler<CountryResponseModel>]
  /// containing the parsed response.
  @override
  Future<ResponseHandler<CountryResponseModel>> getCountryList() async {
    // Make the API call to fetch country list
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.getCountryList,
    );

    // Parse and return the response using the response handler
    return getParsedResponseHandler(
      responseHandler: response,
      parser: CountryResponseModel.fromJson,
    );
  }
}

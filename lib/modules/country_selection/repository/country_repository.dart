import '../../../../utils/exports.dart';

/// An abstract repository class for handling country-related data.
abstract class CountryRepository extends BaseRepository {

  /// Fetches the list of countries.
  ///
  /// This method should be implemented by a concrete class to perform the actual
  /// network request or database query and return a [ResponseHandler] containing
  /// a [CountryResponseModel]. The response should indicate whether the operation
  /// was successful or not.
  ///
  /// Returns a [ResponseHandler<CountryResponseModel>] containing the response.
  Future<ResponseHandler<CountryResponseModel>> getCountryList();
}


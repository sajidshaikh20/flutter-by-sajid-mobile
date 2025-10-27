import '../../../utils/exports.dart';

/// Abstract repository class for fetching category listing data.
///
/// This class defines the contract for a repository that fetches category listing
/// data. It extends [BaseRepository] and provides an abstract method
/// [getCategoryListing] which needs to be implemented by the concrete repository
/// class (e.g., [CategoryListingRepositoryImpl]).
abstract class CategoryListingRepository extends BaseRepository {

  /// Constructor for [CategoryListingRepository]
  CategoryListingRepository();

  /// Fetches the category listing data from a data source.
  ///
  /// This method must be implemented by subclasses to provide the actual
  /// functionality for retrieving category listing data based on the provided
  /// [categoryModel]. It returns a [ResponseHandler] containing the parsed
  /// [CategoryListingResponse].
  ///
  /// [categoryModel] - The model containing the parameters for the API request.
  ///
  /// Returns a [ResponseHandler] containing the parsed [CategoryListingResponse].
  Future<ResponseHandler<CategoryListingResponse>> getCategoryListing({
    required CategoryListingModel categoryModel,
  });
}

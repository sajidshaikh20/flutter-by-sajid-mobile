import '../../../utils/exports.dart';

/// Abstract repository for my account operations.
abstract class MyAccountRepository extends BaseRepository {
  /// Creates an instance of [MyAccountRepository].
  MyAccountRepository();

  /// Calls the logout API.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<dynamic>]
  /// indicating the success or failure of the logout operation.
  Future<ResponseHandler<BaseResponse<dynamic>>> callLogoutApi();

  /// Calls the delete account API.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<dynamic>]
  /// indicating the success or failure of the account deletion.
  Future<ResponseHandler<BaseResponse<dynamic>>> callDeleteAccountAPI();

  /// Fetches account details.
  ///
  /// Returns a [ResponseHandler] containing [MyAccountInfoModel]
  /// with the user's account information.
  Future<ResponseHandler<MyAccountInfoModel>> callAccountDetails();

  /// Fetches CMS content.
  ///
  /// [cmsRequestModel] The request model containing CMS parameters.
  ///
  /// Returns a [ResponseHandler] containing [CmsResponseModel]
  /// with the CMS content data.
  Future<ResponseHandler<CmsResponseModel>> callCMSApi({
    required CmsRequestModel cmsRequestModel,
  });

  /// Fetches loyalty points data.
  ///
  /// [request] The request model containing loyalty points parameters.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<List<LoyaltyPointsResponseModel>>]
  /// with the loyalty points data.
  Future<ResponseHandler<BaseResponse<List<LoyaltyPointsResponseModel>>>> getLoyaltyPoints(
      LoyaltyPointsRequestModel request,
      );
}

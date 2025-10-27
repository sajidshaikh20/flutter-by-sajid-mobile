import '../../../utils/exports.dart';

/// A concrete implementation of the [CheckOutRepository] that interacts
/// with the API
/// to fetch shipping methods, address lists, time slots, and set the
/// selected time slot.
class CheckoutRepositoryImpl extends CheckOutRepository {






  /// Sets the selected time slot for the checkout.
  ///
  /// [setSlotRequestModel] The [SetSlotRequestModel] containing the parameters
  /// for setting the selected time slot.
  ///
  /// Returns a [ResponseHandler] containing [SetSlotResponseModel] with the
  /// status and message of the operation.
  @override
  Future<ResponseHandler<SetSlotResponseModel>> setSlot({
    required SetSlotRequestModel setSlotRequestModel,
  }) async {
    // Make the API call to set the selected time slot
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.setSlot,
      apiType: ApiType.post,
      params: setSlotRequestModel.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: SetSlotResponseModel.fromJson,
    );
  }
}

import '../../../utils/exports.dart';

/// An abstract class that defines the contract for a checkout repository.
///
/// This repository provides methods to fetch shipping methods, address lists,
/// available time slots, and to set the selected time slot for checkout.
abstract class CheckOutRepository extends BaseRepository {



  /// Sets the selected time slot for the checkout.
  ///
  /// [setSlotRequestModel] The [SetSlotRequestModel] containing the parameters
  /// for setting the selected time slot.
  ///
  /// Returns a [ResponseHandler] containing [SetSlotResponseModel] with the
  /// status and message of the operation.
  Future<ResponseHandler<SetSlotResponseModel>> setSlot({
    required SetSlotRequestModel setSlotRequestModel,
  });
}

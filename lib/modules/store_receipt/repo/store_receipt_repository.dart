import '../../../utils/exports.dart';

/// Abstract repository class for handling store receipt-related API calls.
abstract class StoreReceiptRepository extends BaseRepository {
  /// Default constructor for [StoreReceiptRepository].
  StoreReceiptRepository();

  /// Fetches the list of store receipts using the same API as my order listing.
  ///
  /// - [myOrderRequestModel]: Request model with parameters for the API call.
  /// - Returns a [ResponseHandler] containing a [BaseResponse] with list of [ListOfMyOrderResponse].
  Future<ResponseHandler<BaseResponse<List<ListOfMyOrderResponse>>>> callStoreReceiptList(MyOrderRequestModel myOrderRequestModel);

  /// Downloads a specific receipt.
  ///
  /// - [receiptId]: The ID of the receipt to be downloaded.
  /// - Returns a [ResponseHandler] containing the download response.
  Future<ResponseHandler<Map<String, dynamic>>> callDownloadReceiptAPI(
    String? receiptId,
  );
} 
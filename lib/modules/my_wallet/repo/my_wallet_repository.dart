import '../../../utils/exports.dart';

/// Abstract class for fetching wallet data.
abstract class MyWalletRepository extends BaseRepository {
  /// Creates an instance of [MyWalletRepository].
  MyWalletRepository();

  /// Fetches wallet data based on the provided [MyWalletRequest].
  Future<ResponseHandler<MyWalletResponse>> getMyWalletData({
    required MyWalletRequest myWalletRequest,
  });
}

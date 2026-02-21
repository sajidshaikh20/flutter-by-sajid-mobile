import '../../../utils/exports.dart';

/// UI-only MyAccountCubit. No repository, no API, no business logic.
class MyAccountCubit extends Cubit<MyAccountState> {
  MyAccountCubit() : super(MyAccountState.init());

  Future<void> getInitialData() async {}

  Future<void> callLoyaltyPointsApi() async {}

  Future<void> callAccountDetails() async {}

  Future<void> logout() async {}

  Future<void> updateProfile() async {}
}

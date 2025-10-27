import '../../../utils/exports.dart';


/// Cubit for managing the wallet state in the application. It handles fetching
/// wallet data, updating the state based on the response, and changing visibility.
class MyWalletCubit extends Cubit<MyWalletState> {
  /// Constructor to initialize the cubit with the given initial state and repository.
  MyWalletCubit({
    required MyWalletState initialState,
    required this.myWalletRepository,
  }) : super(initialState) {
    displayShimmer();
   /* Future<void>.microtask(
          () async => _getMyWalletData(),
    );*/
  }

  /// Repository for fetching the wallet data from the API.
  MyWalletRepositoryImpl myWalletRepository;

  /// Retrieves wallet data by calling the private method `_getMyWalletData`.
  Future<void> getWalletData() async {
    await _getMyWalletData();
  }

  /// Private method to fetch wallet data and update the state accordingly.
  /// It creates a request model and calls the repository's API method.
  Future<void> _getMyWalletData() async {
    emit(state.copyWith(status: BaseStateStatus.loading));

    // Request model to be sent for wallet data
    MyWalletRequest myWalletRequest = MyWalletRequest(
      storeId: getIt<CountryService>().store.toString(),
      websiteId: getIt<CountryService>().websiteId,
      customerToken: getIt<UserProfileService>().customerToken,
      pageNumber: '1',
    );

    // Fetch wallet data and handle the response
    await myWalletRepository
        .getMyWalletData(myWalletRequest: myWalletRequest)
        .then((ResponseHandler<MyWalletResponse> value) {
      if (value.isSuccess()) {
        // Success: Update the state with wallet data
        if (value.getSuccessInstance()?.response.success ?? false) {
          MyWalletResponse myAccountDetails = value.getSuccessInstance()!.response;
          emit(
            state.copyWith(
              status: BaseStateStatus.success,
              totalCount: myAccountDetails.totalCount,
              walletAmount: myAccountDetails.walletAmount,
              /*collection: myAccountDetails.collection,*/
            ),
          );
        } else {
          // Failure: Emit state with failure message
          emit(
            state.copyWith(
              status: BaseStateStatus.failure,
              errorMessage: value.getSuccessInstance()!.response.message ?? '',
            ),
          );
        }
      } else if (value.isFailure()) {
        // Failure: Emit state with error message
        emit(
          state.copyWith(
            status: BaseStateStatus.failure,
            errorMessage: value.getSuccessInstance()!.response.message ?? '',
          ),
        );
      }
    });
  }

  /// Changes the visibility of certain UI elements in the wallet screen.
  /// Toggles the current visibility state.
  void changeVisibility() {
    // Set loading status before toggling visibility
    emit(
      state.copyWith(
        status: BaseStateStatus.loading,
      ),
    );

    // Toggle visibility
    emit(
      state.copyWith(
        status: BaseStateStatus.success,
        isVisible: !state.isVisible,
      ),
    );
  }
  /// Displays a shimmer effect by emitting loading state and then success after a delay.
  void displayShimmer(){
    emit(state.copyWith(status: BaseStateStatus.loading));
    Future<void>.delayed(const Duration(seconds: 3), () {
      if (!isClosed)
      {
        emit(state.copyWith(status: BaseStateStatus.success));
      }

    });
  }
}

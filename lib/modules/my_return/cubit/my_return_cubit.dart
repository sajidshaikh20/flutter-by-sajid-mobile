import '../../../utils/exports.dart';

/// A [Cubit] class responsible for managing the state related to user's return
/// orders. It interacts with [MyReturnRepository] to fetch return data and
/// emits various states based on the outcome of the operations.
class MyReturnCubit extends Cubit<MyReturnState> {
  /// Factory constructor to create a new instance of [MyReturnCubit].
  /// This constructor uses an internal private constructor to initialize
  /// the repository.
  factory MyReturnCubit() => MyReturnCubit._internal(MyReturnRepositoryImpl());

  /// Internal constructor that initializes the repository and the initial state
  /// of the [MyReturnCubit]. It also triggers the loading of the return list
  /// asynchronously when the cubit is created.
  MyReturnCubit._internal(this._repository)
      : super(const MyReturnState(status: BaseStateStatus.initial)) {
    scheduleMicrotask(
          () async => _loadMyReturnList(),
    );
  }

  /// Repository to handle the API calls and data fetching for the return orders.
  final MyReturnRepository _repository;

  /// Fetches and loads the user's return list asynchronously. This method
  /// delegates the fetching task to the private method [_loadMyReturnList].
  Future<void> getMyReturnList() async {
    await _loadMyReturnList();
  }

  /// Calls the API to fetch the user's return orders and updates the state
  /// accordingly based on the response.
  ///
  /// Emits states to indicate loading, success, or failure based on the
  /// outcome of the API call.
  Future<void> callApiMyReturn() async {
    // Set state to loading before starting the API call
    emit(state.copyWith(status: BaseStateStatus.loading));
    try {
      // Perform the API call to fetch the return orders
      ResponseHandler<MyReturnModel> response =
      await _repository.getMyReturnList(
        myReturnRequestModel: ReturnOrderRequestModel(
          customerToken: getIt<UserProfileService>().customerToken,
          websiteId: getIt<CountryService>().websiteId,
          p: AppConstant.pageNum.toString(),
        ),
      );

      // Check if the response is successful and update the state accordingly
      if (response.isSuccess()) {
        emit(
          state.copyWith(
            status: BaseStateStatus.success,
            myReturnOrderList: response.getSuccessInstance()?.response,
          ),
        );
      } else if (response.isFailure()) {
        // Handle failure case and display the error message
        emit(
          state.copyWith(
            status: BaseStateStatus.failure,
            errorMessage: response.getFailureInstance()?.error?.errorMessage ?? '',
          ),
        );
      }
    } on Exception catch (e) {
      // Handle exception during API call and emit failure state with error message
      emit(
        state.copyWith(
          status: BaseStateStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// A private method that loads the user's return list from a local JSON file
  /// stored in the assets folder. This method is invoked when the cubit is first
  /// created or when the data needs to be fetched from the local file.
  Future<void> _loadMyReturnList() async {
    // Set state to loading while fetching the data
    emit(
      state.copyWith(
        status: BaseStateStatus.loading,
      ),
    );
    try {
      // Load the JSON file from assets
      String jsonString = await rootBundle.loadString(Assets.json.myReturn);
      // Parse the JSON data
      Map<String, dynamic> jsonResponse = json.decode(jsonString);
      MyReturnModel myReturnModel = MyReturnModel.fromJson(jsonResponse);
      // Emit the success state with the parsed data
      emit(
        state.copyWith(
          status: BaseStateStatus.success,
          myReturnOrderList: myReturnModel,
        ),
      );
    } on Exception catch (e) {
      // Handle exception if loading or parsing fails and emit failure state
      emit(
        state.copyWith(
          status: BaseStateStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// A temporary method to simulate the no data state. It emits a success state
  /// with an empty [MyReturnModel] when called.
  void changeVisibility() {
    emit(
      state.copyWith(
        status: BaseStateStatus.success,
        myReturnOrderList: MyReturnModel(),
      ),
    );
  }
}

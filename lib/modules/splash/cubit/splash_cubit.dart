import '../../../utils/exports.dart';

/// A Cubit responsible for managing the splash screen logic,
/// such as triggering navigation after a delay and handling
/// initial app configuration tasks.
class SplashCubit extends Cubit<SplashState> {
  /// Creates a [SplashCubit] with the given [repository].
  ///
  /// Upon creation, it schedules [_showAfterDelay] to be called asynchronously
  /// after the initial state is emitted.
  SplashCubit({required this.repository})
      : super(const SplashState(status: BaseStateStatus.initial)) {
    //_fetchRemoteConfig();
    scheduleMicrotask(
      () async => _showAfterDelay(),
    );
  }

  /// The [LanguageSelectionRepository] used for fetching language data
  /// and related configurations during splash screen initialization.
  final LanguageSelectionRepository repository;

  // navigate to language screen
  Future<void> _showAfterDelay() async {
    // First check if user is already logged in
    bool isLoggedIn = SharedPref.instance.getBool(
      PrefsKey.isLoggedInKey,
      defValue: false,
    );

    DebugLog.instance.d('Calling _fetchLanguageData()');
    // Load existing LanguageService data from SharedPreferences
    await SharedPref.instance.loadAndStoreLanguageService();

    // Load existing UserProfileService data from SharedPreferences
    await SharedPref.instance.loadAndStoreUserProfileService();

    // User is not logged in, proceed with normal flow
    await _fetchLanguageData();

    if (isLoggedIn) {
      // User is logged in, go directly to dashboard
      await Future<void>.delayed(
        const Duration(seconds: Dimens.seconds3),
        () {
          Locale locale = getLocale();
          emit(state.copyWith(
            languageAlignment: locale.languageCode == AppConstant.en
                ? AppConstant.defaultLanguageAlignment
                : AppConstant.rtlLanguageAlignment,
            languageCode: locale.languageCode,
            status: BaseStateStatus.success,
            redirectPath: AppPaths.dashboard,
          ));
        },
      );
      return;
    }
    

    // Introduce a delay of 3 seconds
    await Future<void>.delayed(
      const Duration(seconds: Dimens.seconds3),
      () {
        Locale locale = getLocale();

        emit(state.copyWith(
          languageAlignment: locale.languageCode == AppConstant.en
              ? AppConstant.defaultLanguageAlignment
              : AppConstant.rtlLanguageAlignment,
          languageCode: locale.languageCode,
          status: BaseStateStatus.success,
          redirectPath: SharedPref.instance.getBool(
                  PrefsKey.isCountryAndLanguageSelectedKey,
                  defValue: false)
              ? AppPaths.socialLogin
              : AppPaths.languageSelection,
        ));
      },
    );
  }



  /// Fetch language list from API
  Future<void> _fetchLanguageData() async {
    DebugLog.instance.d('Calling _fetchLanguageData()');

    emit(state.copyWith(status: BaseStateStatus.loading));

    final ResponseHandler<BaseResponse<LanguageResponseModel>> response =
        await repository.getLanguageList();
    DebugLog.instance.d('API Response: ${response.toString()}');
    DebugLog.instance.d('Is Success: ${response.isSuccess()}');
    DebugLog.instance.d('Success Instance: ${response.getSuccessInstance()}');
    DebugLog.instance.d('Failure Instance: ${response.getFailureInstance()}');

    if (response.isSuccess()) {
      final OnSuccessResponse<BaseResponse<LanguageResponseModel>>?
          successInstance = response.getSuccessInstance();

      if (successInstance != null) {
        final BaseResponse<LanguageResponseModel> baseResponse =
            successInstance.response;
        // Check if the BaseResponse is successful and has data
        if (baseResponse.success && baseResponse.data != null) {
          final LanguageResponseModel languageData = baseResponse.data!;
          await _handleSuccess(languageData);
        } else {
          // Handle case where BaseResponse indicates failure
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: baseResponse.message.isNotEmpty ? baseResponse.message : '',
          ));
        }
      } else {
        Locale locale = getLocale();

        emit(state.copyWith(
          status: BaseStateStatus.failure,
          languageAlignment: locale.languageCode == AppConstant.en
              ? AppConstant.defaultLanguageAlignment
              : AppConstant.rtlLanguageAlignment,
          languageCode: locale.languageCode,
          redirectPath: SharedPref.instance.getBool(
              PrefsKey.isCountryAndLanguageSelectedKey,
              defValue: false)
              ? AppPaths.socialLogin
              : AppPaths.languageSelection,
        ));
      }
    } else {
      final OnFailureResponse<BaseResponse<LanguageResponseModel>>?
          failureInstance = response.getFailureInstance();
      final String errorMessage = failureInstance?.error?.errorMessage ?? '';
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: errorMessage,
      ));
    }
  }

  /// Handle success response
  Future<void> _handleSuccess(LanguageResponseModel response) async {
    // Store country list in CountryService
    DebugLog.instance.d('countryService store: ${response.countryList.first.store}');
    DebugLog.instance.d('fb link: ${response.socialMedia?.facebook}');

    if (response.countryList.isNotEmpty) {
      // Store the complete country list in CountryService
      await getIt<CountryService>().storeCountryList(response.countryList);

      // If there's already a selected country, update it with the correct store value from API
      final CountryService countryService = getIt<CountryService>();

      if (countryService.countryId != null) {
        final CountryList? selectedCountryFromApi = response.countryList.firstWhereOrNull(
          (CountryList country) => country.countryId == countryService.countryId,
        );

        if (selectedCountryFromApi != null) {
          // Create a CountryModel with the correct store value from API
          final CountryModel updatedCountryModel = CountryModel(
            websiteId: selectedCountryFromApi.websiteId,
            countryId: selectedCountryFromApi.countryId,
            countryName: selectedCountryFromApi.countryName,
            countryFlag: selectedCountryFromApi.countryFlag,
            contactUs: selectedCountryFromApi.contactUs != null 
                ? ContactUsModel(
                    phone: selectedCountryFromApi.contactUs!.phone,
                    email: selectedCountryFromApi.contactUs!.email,
                    whatsapp: selectedCountryFromApi.contactUs!.whatsapp,
                  )
                : null,
            countryCode: selectedCountryFromApi.countryCode,
          );
          
          // Save the updated country data with correct store value
          await countryService.saveCountryData(updatedCountryModel);
          DebugLog.instance.d('Updated country data with correct store value: ${selectedCountryFromApi.store}');
        } else {
          DebugLog.instance.d('Selected country not found in API response, keeping existing data');
        }
      } else {
        DebugLog.instance.d('No country selected yet, auto-selecting first country');
        // Auto-select the first country if none is selected
        if (response.countryList.isNotEmpty) {
          final CountryList firstCountry = response.countryList.first;
          final CountryModel autoSelectedCountry = CountryModel(
            websiteId: firstCountry.websiteId,
            countryId: firstCountry.countryId,
            countryName: firstCountry.countryName,
            countryFlag: firstCountry.countryFlag,
            arabicName: firstCountry.arabicName,
            contactUs: firstCountry.contactUs != null
                ? ContactUsModel(
                    phone: firstCountry.contactUs!.phone,
                    email: firstCountry.contactUs!.email,
                    whatsapp: firstCountry.contactUs!.whatsapp,
                  )
                : null,
            countryCode: firstCountry.countryCode,
          );

          await countryService.saveCountryData(autoSelectedCountry);
        }
      }
    } else {
      DebugLog.instance.d('No country list received from API');
    }
    // Store language list in LanguageService
    if (response.languageList.isNotEmpty) {
      await getIt<LanguageService>().storeLanguageList(response.languageList);
      DebugLog.instance.d('Language list stored with ${response.languageList.length} languages');
    } else {
      DebugLog.instance.d('No language list received from API');
    }

    // Store social media URLs as individual strings in SharedPref
    // Since the model might not have social media data due to freezed issues,
    // we'll parse it directly from the raw API response
    try {
      DebugLog.instance.i('SplashCubit: Attempting to parse social media from raw API response');
      
      // For now, let's manually store the URLs we know from the API response
      // This is a temporary solution until the model parsing is fixed
      await SharedPref.instance.setValue(PrefsKey.facebookUrlKey, 'https://www.facebook.com/');
      await SharedPref.instance.setValue(PrefsKey.instagramUrlKey, 'https://www.instagram.com/');
      await SharedPref.instance.setValue(PrefsKey.youTubeUrlKey, 'https://www.youtube.com/');
      
      DebugLog.instance.i('SplashCubit: Social media URLs stored successfully (hardcoded for now)');
    } on Exception catch (e) {
      DebugLog.instance.e('SplashCubit: Failed to store social media: $e');
    }
  }
}

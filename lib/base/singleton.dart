import '../../../utils/exports.dart';


///get it variable
final GetIt getIt = GetIt.instance;

///setupLocator function
FutureOr<void> setupLocator() {
  getIt

    ..registerSingleton<AppRouter>(AppRouter()) // Required for navigation immediately
    ..registerSingleton<MainConfig>(MainConfig()) // Config is used at startup
    ..registerSingleton<AppColors>(AppColors()) // Theming needed right away
    ..registerSingleton<AppStyles>(AppStyles()) // Styling used in UI instantly
    ..registerSingleton<MyAppTheme>(MyAppTheme()) // Theme config applied at startup

  // Networking & storage — initialize only if accessed
    ..registerSingleton<ApiClient>(ApiClient())
    ..registerSingleton<ChatSocketConnection>(ChatSocketConnection())
    ..registerSingleton<SharedPref>(SharedPref())
    ..registerSingleton<DebugLog>(DebugLog())
    ..registerSingleton<JsonDataManagerService>(JsonDataManagerService())
    ..registerLazySingleton<UserProfileService>(UserProfileService.new)

  // Utilities — lazy unless used instantly
    ..registerLazySingleton<AESEncryption>(AESEncryption.new)
    ..registerLazySingleton<RegExpressions>(RegExpressions.new)

    ..registerLazySingleton<TabRouterService>(TabRouterService.new)

    // Services — lazy unless required immediately
    ..registerLazySingleton<LanguageService>(LanguageService.new)
    ..registerLazySingleton<SocialLoginServices>(SocialLoginServices.new)



  // Cubits / State management — register eagerly if used on home
  // Cubits / State management — now lazy
    ..registerLazySingleton<ForceUpdateUnderMaintenanceCubit>(
      ForceUpdateUnderMaintenanceCubit.new,
    );

}


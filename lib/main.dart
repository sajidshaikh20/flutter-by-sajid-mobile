import '../utils/exports.dart';

///When app is in background this method will be call
@pragma('vm:entry-point')
Future<void> firebaseBackground(RemoteMessage message) async {
  DebugLog.instance
      .i("FCM Background Message : ${message.data} ${message.notification}");
}

Future<void> main() async {
  mainDelegate();
}

///Main delegate
void mainDelegate() => AppInitializer.instance.init(
      () async {
        runApp(const MyApp());
      },
    );

///This is our my app where code start run
class MyApp extends StatefulWidget {
  ///My app constructor
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {}

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<InternetCubit>(
          lazy: false,
          create: (BuildContext context) => InternetCubit(Connectivity()),
        ),
        BlocProvider<LocaleCubit>(
          create: (BuildContext context) => LocaleCubit.instance,
        ),
        BlocProvider<ForceUpdateUnderMaintenanceCubit>(
          create: (BuildContext context) =>
              ForceUpdateUnderMaintenanceCubit.instance(),
        ),

      ],
      child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
        builder: (BuildContext context, ChangeLocaleState state) {
          bool isLtr = SharedPref.instance
              .getBool(PrefsKey.isEnglishLanguageLoadedKey, defValue: true);
          final AppRouter appRouter = GetIt.instance<AppRouter>();
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(
                builder: (BuildContext context, Widget? child) {
              configLoader();
              return child ?? const SizedBox();
            }),
            routerConfig: appRouter.config(
              navigatorObservers: () => <NavigatorObserver>[
                CustomNavigationObserver(),
                // SentryNavigatorObserver(),
                //if (kDebugMode) ChuckerFlutter.navigatorObserver,
              ],
            ),
            title: AppConstant.appName,
            locale: getLocale(),
            supportedLocales: const <Locale>[
              Locale(AppConstant.en, ''),
              Locale(AppConstant.ar, ''),
            ],
            localizationsDelegates: <LocalizationsDelegate<dynamic>>[
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback:
                (Locale? locale, Iterable<Locale> supportedLocales) {
              for (final Locale supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            theme: MainConfig.appTheme.theme(isLtr: isLtr),
          );
        },
      ),
    );
  }
}

///configLoader
void configLoader() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: Dimens.timeDuration2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = Dimens.size40
    ..radius = Dimens.radius12
    ..progressWidth = Dimens.borderWidth4
    ..textColor = MainConfig.appColors.textWhiteColor
    ..progressColor = MainConfig.appColors.backgroundWhiteColor
    ..backgroundColor = MainConfig.appColors.mainColor
    ..indicatorColor = MainConfig.appColors.backgroundWhiteColor
    ..userInteractions = false
    ..dismissOnTap = false;
}

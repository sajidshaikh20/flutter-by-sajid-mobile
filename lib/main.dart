  import '../utils/exports.dart';

///When app is in background this method will be call
@pragma('vm:entry-point')
Future<void> firebaseBackground(RemoteMessage message) async {
  DebugLog.instance
      .i("FCM Background Message : ${message.data} ${message.notification}");

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
    await awesomeNotifications.initialize(
      null,
      <NotificationChannel>[
        NotificationChannel(
          channelGroupKey: NotificationConst.channelGroupKey,
          channelKey: NotificationConst.channelKey,
          channelName: NotificationConst.channelName,
          channelDescription: NotificationConst.channelDescription,
          defaultColor: Colors.blue,
          ledColor: Colors.white,
        ),
      ],
      channelGroups: <NotificationChannelGroup>[
        NotificationChannelGroup(
          channelGroupKey: NotificationConst.channelGroupKey,
          channelGroupName: NotificationConst.channelGroupName,
        ),
      ],
      debug: true,
    );

    final Map<String, dynamic> data = Map<String, dynamic>.from(message.data);

    final String? symbol = data['symbol']?.toString();
    final String? tradePublicId = data['tradePublicId']?.toString();
    final String? messageText = data['message']?.toString() ??
        data['body']?.toString() ??
        message.notification?.body;
    final String? titleText =
        data['title']?.toString() ?? message.notification?.title;

    String title = 'New Trade Come!';
    if (symbol != null && symbol.isNotEmpty) {
      title = 'New Trade Come: $symbol';
    } else if (titleText != null && titleText.isNotEmpty) {
      title = titleText;
    }

    String body = '';
    if (messageText != null && messageText.isNotEmpty) {
      body = messageText;
      if (tradePublicId != null && tradePublicId.isNotEmpty) {
        body = '$messageText ($tradePublicId)';
      }
    } else if (symbol != null && symbol.isNotEmpty) {
      final String action = data['action']?.toString() ?? '';
      final String actionStr = action.isNotEmpty ? '$action ' : '';
      final String entry = data['entry']?.toString() ?? '';
      final String entryStr = entry.isNotEmpty ? ' at $entry' : '';
      final String idStr = tradePublicId != null && tradePublicId.isNotEmpty ? ' ($tradePublicId)' : '';
      body =
          'A new ${actionStr}trade has been posted for $symbol$entryStr$idStr. Check entry, TP, and SL details now!';
    } else {
      body = 'A new trading opportunity is available. Tap to view details!';
    }

    final Map<String, String> stringPayload = <String, String>{};
    data.forEach((String key, dynamic value) {
      if (value != null) {
        stringPayload[key] = value.toString();
      }
    });

    try {
      await awesomeNotifications.createNotification(
        content: NotificationContent(
          id: Random().nextInt(1000),
          channelKey: NotificationConst.channelKey,
          title: title,
          backgroundColor: const Color(0xFF0466DC),
          icon: 'resource://drawable/ic_weko',
          body: body,
          bigPicture: data['image']?.toString() ?? '',
          payload: stringPayload,
        ),
      );
    } on Object catch (e) {
      DebugLog.instance.e('firebaseBackground: Custom icon not compiled yet ($e). Falling back to ic_notification_icon.');
      try {
        await awesomeNotifications.createNotification(
          content: NotificationContent(
            id: Random().nextInt(1000),
            channelKey: NotificationConst.channelKey,
            title: title,
            backgroundColor: const Color(0xFF0466DC),
            icon: 'resource://drawable/ic_notification_icon',
            body: body,
            bigPicture: data['image']?.toString() ?? '',
            payload: stringPayload,
          ),
        );
      } on Object catch (e2) {
        DebugLog.instance.e('firebaseBackground: Fallback notification creation failed: $e2');
      }
    }
  } on Object catch (e, st) {
    DebugLog.instance.e('Error in firebaseBackground handler: $e\n$st');
  }
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
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await ForceUpdateUnderMaintenanceCubit.instance().checkAppUpdate(
        syncNavigation: true,
      );
    }
  }

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
        BlocProvider<ThemeCubit>(
          create: (BuildContext context) => ThemeCubit.instance,
        ),
        BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit(),
        ),
      ],
      child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
        builder: (BuildContext context, ChangeLocaleState state) {
          final bool isLtr = SharedPref.instance
              .getBool(PrefsKey.isEnglishLanguageLoadedKey, defValue: true);
          final AppRouter appRouter = GetIt.instance<AppRouter>();
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (BuildContext context, ThemeMode themeMode) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                builder: EasyLoading.init(
                  builder: (BuildContext context, Widget? child) {
                    configLoader();
                    return child ?? const SizedBox();
                  },
                ),
                routerConfig: appRouter.config(
                  navigatorObservers: () => <NavigatorObserver>[
                    CustomNavigationObserver(),
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
                localeResolutionCallback: (
                  Locale? locale,
                  Iterable<Locale> supportedLocales,
                ) {
                  for (final Locale supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale?.languageCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                theme: MainConfig.appTheme.theme(isLtr: isLtr),
                darkTheme: MainConfig.appTheme.darkTheme(isLtr: isLtr),
                themeMode: themeMode,
              );
            },
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
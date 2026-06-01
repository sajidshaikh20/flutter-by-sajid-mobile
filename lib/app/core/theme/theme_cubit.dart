import '../../../utils/exports.dart';

/// Manage dynamic light/dark/system theme state in the app.
class ThemeCubit extends Cubit<ThemeMode> {
  /// Static instance for easy access.
  static final ThemeCubit instance = ThemeCubit();

  /// Default constructor initialization.
  ThemeCubit() : super(ThemeMode.system) {
    loadThemeMode();
  }

  /// Load persisted theme mode from local storage
  void loadThemeMode() {
    final String modeName = SharedPref.instance.getString(
      PrefsKey.themeModeKey,
      ThemeMode.system.name,
    );
    final ThemeMode matchedMode = ThemeMode.values.firstWhere(
          (ThemeMode mode) => mode.name == modeName,
      orElse: () => ThemeMode.system,
    );
    _syncAppColorsDarkFlag(matchedMode);
    emit(matchedMode);
  }

  void _syncAppColorsDarkFlag(ThemeMode mode) {
    MainConfig.appColors.isDark =
        mode == ThemeMode.dark ||
        (mode == ThemeMode.system &&
            WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark);
  }

  /// Change active theme mode and save choice to storage.
  Future<void> selectThemeMode(ThemeMode mode) async {
    await SharedPref.instance.setValue(PrefsKey.themeModeKey, mode.name);
    _syncAppColorsDarkFlag(mode);
    emit(mode);
  }
}

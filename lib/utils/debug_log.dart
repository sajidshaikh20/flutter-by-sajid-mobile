import 'exports.dart';

/// A utility class for logging messages to both the console and a log file.
// ignore: avoid_classes_with_only_static_members // This is because our base structure follows certain rules which are needed for readability
class DebugLog {

  /// The singleton instance of the [DebugLog] class.
  static DebugLog  instance = getIt<DebugLog>();

  Logger? _logger;

  ///generate file
  Future<File> _getDirectoryForLogRecord() async {
    final String? directoryPath = await AppPathProvider.documentsPath();
    if (directoryPath == null) {
      throw UnsupportedError('File logging is not supported on web.');
    }
    return File('$directoryPath/logger.txt');
  }

  ///write log in file
  Future<List<LogOutput>> _writeLogInFile() async {
    final File file = await _getDirectoryForLogRecord();
    final FileOutput fileOutPut = FileOutput(file: file);
    final ConsoleOutput consoleOutput = ConsoleOutput();
    return <LogOutput>[fileOutPut, consoleOutput];
  }

  /// initialize logger
  Future<void> init() async {
    if (_logger != null) {
      return;
    }

    if (kIsWeb) {
      _logger = Logger(
        filter: DevelopmentFilter(),
        printer: PrettyPrinter(
          printEmojis: false,
        ),
        output: ConsoleOutput(),
      );
      return;
    }

    _logger = Logger(
      filter: DevelopmentFilter(),
      printer: PrettyPrinter(
        printEmojis: false,
      ),
      output: MultiOutput(
        await _writeLogInFile(),
      ),
    );
  }

  /// Logs a debug message if in debug mode.
  void d(
      String message,
      ) {
    if (!kDebugMode) return;
    if (_logger != null) {
      _logger!.d(message);
    } else {
      // Fallback to console if logger not initialized yet
      // Using print to avoid losing early boot logs
      // ignore: avoid_print
      print('[DEBUG] $message');
    }
  }

  /// Logs a trace message if in debug mode.
  void t(String message) {
    if (!kDebugMode) return;
    if (_logger != null) {
      _logger!.t(message);
    } else {
      // Fallback to console if logger not initialized yet
      // Using print to avoid losing early boot logs
      // ignore: avoid_print
      print('[TRACE] $message');
    }
  }

  /// Logs an error message if in debug mode.
  void e(String message, [Object? errors]) {
    if (!kDebugMode) return;
    if (_logger != null) {
      _logger!.e(message, error: errors);
    } else {
      // Fallback to console if logger not initialized yet
      // Using print to avoid losing early boot logs
      // ignore: avoid_print
      print('[ERROR] $message${errors != null ? ' | $errors' : ''}');
    }
  }

  /// Logs a warning message if in debug mode.
  void w(String message) {
    if (!kDebugMode) return;
    if (_logger != null) {
      _logger!.w(message);
    } else {
      // Fallback to console if logger not initialized yet
      // Using print to avoid losing early boot logs
      // ignore: avoid_print
      print('[WARN] $message');
    }
  }

  /// Logs an info message if in debug mode.
  void i(String message) {
    if (!kDebugMode) return;
    if (_logger != null) {
      _logger!.i(message);
    } else {
      // Fallback to console if logger not initialized yet
      // Using print to avoid losing early boot logs
      // ignore: avoid_print
      print('[INFO] $message');
    }
  }
}

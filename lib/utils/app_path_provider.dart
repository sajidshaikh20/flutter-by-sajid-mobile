import 'exports.dart';

/// Resolves app-local filesystem paths on mobile/desktop.
/// Returns null on web where the filesystem APIs are unavailable.
class AppPathProvider {
  AppPathProvider._();

  static bool get supportsLocalFileSystem => !kIsWeb;

  static Future<String?> documentsPath() async {
    if (kIsWeb) {
      return null;
    }
    final Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}

import '../../../utils/exports.dart';
import '../model/browser_tab_model.dart';

abstract class TabsRepository extends BaseRepository {
  TabsRepository();

  /// Save tabs to persistent storage
  Future<void> saveTabs(List<BrowserTabModel> tabs);

  /// Get saved tabs from persistent storage
  Future<List<Map<String, dynamic>>?> getSavedTabs();

  /// Cache a web page for offline access
  Future<void> cachePage(String url, Map<String, dynamic> pageData);

  /// Get cached page
  Map<String, dynamic>? getCachedPage(String url);
}


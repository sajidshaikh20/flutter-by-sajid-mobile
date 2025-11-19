import '../../../service/storage/storage_service.dart';
import '../../../utils/exports.dart';
import '../model/browser_tab_model.dart';
import 'tabs_repository.dart';

class TabsRepositoryImpl extends TabsRepository {
  TabsRepositoryImpl() : super();

  @override
  Future<void> saveTabs(List<BrowserTabModel> tabs) async {
    try {
      final List<Map<String, dynamic>> tabsData = tabs.map((BrowserTabModel tab) => tab.toMap()).toList();
      await getIt<StorageService>().saveTabs(tabsData);
    } on Exception catch (e) {
      DebugLog.instance.e('Error saving tabs: $e');
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>?> getSavedTabs() async {
    try {
      return getIt<StorageService>().getSavedTabs();
    } on Exception catch (e) {
      DebugLog.instance.e('Error getting saved tabs: $e');
      return null;
    }
  }

  @override
  Future<void> cachePage(String url, Map<String, dynamic> pageData) async {
    try {
      await getIt<StorageService>().cachePage(url, pageData);
    } on Exception catch (e) {
      DebugLog.instance.e('Error caching page: $e');
    }
  }

  @override
  Map<String, dynamic>? getCachedPage(String url) {
    try {
      return getIt<StorageService>().getCachedPage(url);
    } on Exception catch (e) {
      DebugLog.instance.e('Error getting cached page: $e');
      return null;
    }
  }
}


import 'package:hive_flutter/hive_flutter.dart';
import '../../../utils/exports.dart';

/// Service for managing local storage using Hive
class StorageService {
  StorageService._();
  static final StorageService instance = StorageService._();

  static const String _cachedPagesBox = 'cached_pages';
  static const String _summariesBox = 'summaries';
  static const String _tabsBox = 'tabs';
  static const String _filesBox = 'files';

  Box<Map<dynamic, dynamic>>? _cachedPagesBoxInstance;
  Box<Map<dynamic, dynamic>>? _summariesBoxInstance;
  Box<Map<dynamic, dynamic>>? _tabsBoxInstance;
  Box<Map<dynamic, dynamic>>? _filesBoxInstance;

  /// Initialize Hive storage
  Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters if needed (for complex objects)
    // For now, we'll use Map type which Hive supports natively
    
    _cachedPagesBoxInstance = await Hive.openBox<Map<dynamic, dynamic>>(_cachedPagesBox);
    _summariesBoxInstance = await Hive.openBox<Map<dynamic, dynamic>>(_summariesBox);
    _tabsBoxInstance = await Hive.openBox<Map<dynamic, dynamic>>(_tabsBox);
    _filesBoxInstance = await Hive.openBox<Map<dynamic, dynamic>>(_filesBox);
    
    DebugLog.instance.i('StorageService: Hive boxes initialized');
  }

  // ========== Cached Pages ==========
  Future<void> cachePage(String url, Map<String, dynamic> pageData) async {
    await _cachedPagesBoxInstance?.put(url, pageData);
  }

  Map<String, dynamic>? getCachedPage(String url) {
    return _cachedPagesBoxInstance?.get(url)?.cast<String, dynamic>();
  }

  Future<void> clearCachedPages() async {
    await _cachedPagesBoxInstance?.clear();
  }

  // ========== Summaries ==========
  Future<void> cacheSummary(String contentHash, Map<String, dynamic> summaryData) async {
    await _summariesBoxInstance?.put(contentHash, summaryData);
  }

  Map<String, dynamic>? getCachedSummary(String contentHash) {
    return _summariesBoxInstance?.get(contentHash)?.cast<String, dynamic>();
  }

  // ========== Tabs ==========
  Future<void> saveTabs(List<Map<String, dynamic>> tabs) async {
    await _tabsBoxInstance?.put('tabs_list', <String, dynamic>{'tabs': tabs});
  }

  List<Map<String, dynamic>>? getSavedTabs() {
    final Map<dynamic, dynamic>? data = _tabsBoxInstance?.get('tabs_list');
    if (data != null && data['tabs'] != null) {
      final List<dynamic> tabsList = data['tabs'] as List<dynamic>;
      return tabsList.map((dynamic item) {
        final Map<dynamic, dynamic> map = item as Map<dynamic, dynamic>;
        return map.cast<String, dynamic>();
      }).toList();
    }
    return null;
  }

  // ========== Files ==========
  Future<void> saveFileMetadata(String fileId, Map<String, dynamic> metadata) async {
    await _filesBoxInstance?.put(fileId, metadata);
  }

  Map<String, dynamic>? getFileMetadata(String fileId) {
    return _filesBoxInstance?.get(fileId)?.cast<String, dynamic>();
  }

  List<Map<String, dynamic>> getAllFiles() {
    final List<Map<String, dynamic>> allFiles = <Map<String, dynamic>>[];
    _filesBoxInstance?.values.forEach((dynamic file) {
      allFiles.add((file as Map<dynamic, dynamic>).cast<String, dynamic>());
    });
    return allFiles;
  }

  Future<void> deleteFileMetadata(String fileId) async {
    await _filesBoxInstance?.delete(fileId);
  }

  /// Clear all storage
  Future<void> clearAll() async {
    await _cachedPagesBoxInstance?.clear();
    await _summariesBoxInstance?.clear();
    await _tabsBoxInstance?.clear();
    await _filesBoxInstance?.clear();
  }
}


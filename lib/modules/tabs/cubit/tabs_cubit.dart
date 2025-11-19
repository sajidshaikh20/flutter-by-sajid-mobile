import 'package:uuid/uuid.dart';
import '../../../utils/exports.dart';
import '../model/browser_tab_model.dart';
import '../repo/tabs_repository.dart';
import 'tabs_state.dart';

class TabsCubit extends BaseCubit<TabsState> {
  TabsCubit({required this.tabsRepository})
      : super(TabsState.initial()) {
    unawaited(_loadSavedTabs());
  }

  final TabsRepository tabsRepository;
  final Uuid _uuid = const Uuid();

  Future<void> _loadSavedTabs() async {
    try {
      final List<Map<String, dynamic>>? savedTabs = await tabsRepository.getSavedTabs();
      if (savedTabs != null && savedTabs.isNotEmpty) {
        final List<BrowserTabModel> tabs = savedTabs.map((Map<String, dynamic> map) => BrowserTabModelExtension.fromMap(map)).toList();
        emit(state.copyWith(
          tabs: tabs,
          activeTabId: tabs.first.id,
          currentUrl: tabs.first.url,
          status: BaseStateStatus.success,
        ));
      } else {
        // Create initial tab
        await createNewTab('https://www.kuvaka.io/');
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error loading saved tabs: $e');
      await createNewTab('https://www.kuvaka.io/');
    }
  }

  Future<void> createNewTab(String url) async {
    try {
      final BrowserTabModel newTab = BrowserTabModel(
        id: _uuid.v4(),
        url: url,
        isLoading: true,
      );

      final List<BrowserTabModel> updatedTabs = <BrowserTabModel>[...state.tabs, newTab];
      emit(state.copyWith(
        tabs: updatedTabs,
        activeTabId: newTab.id,
        currentUrl: url,
        status: BaseStateStatus.loading,
      ));

      await tabsRepository.saveTabs(updatedTabs);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Failed to create new tab: $e',
      ));
    }
  }

  Future<void> closeTab(String tabId) async {
    try {
      final List<BrowserTabModel> updatedTabs = state.tabs.where((BrowserTabModel tab) => tab.id != tabId).toList();
      
      if (updatedTabs.isEmpty) {
        // If no tabs left, create a new one
        await createNewTab('https://www.kuvaka.io/');
        return;
      }

      String? newActiveTabId = state.activeTabId;
      BrowserTabModel? newActiveTab;
      
      if (tabId == state.activeTabId) {
        // If closing active tab, switch to first available
        newActiveTabId = updatedTabs.first.id;
        newActiveTab = updatedTabs.first;
      } else {
        // Keep the current active tab
        newActiveTab = updatedTabs.firstWhere(
          (BrowserTabModel t) => t.id == newActiveTabId,
          orElse: () => updatedTabs.first,
        );
        newActiveTabId = newActiveTab.id;
      }

      emit(state.copyWith(
        tabs: updatedTabs,
        activeTabId: newActiveTabId,
        currentUrl: newActiveTab.url,
        status: BaseStateStatus.success,
      ));

      await tabsRepository.saveTabs(updatedTabs);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Failed to close tab: $e',
      ));
    }
  }

  Future<void> switchTab(String tabId) async {
    try {
      final BrowserTabModel tab = state.tabs.firstWhere((BrowserTabModel t) => t.id == tabId);
      emit(state.copyWith(
        activeTabId: tabId,
        currentUrl: tab.url,
      ));
    } on Exception catch (e) {
      DebugLog.instance.e('Error switching tab: $e');
    }
  }

  Future<void> updateTabUrl(String tabId, String url) async {
    try {
      final List<BrowserTabModel> updatedTabs = state.tabs.map((BrowserTabModel tab) {
        if (tab.id == tabId) {
          return tab.copyWith(url: url);
        }
        return tab;
      }).toList();

      emit(state.copyWith(
        tabs: updatedTabs,
        currentUrl: url,
      ));

      await tabsRepository.saveTabs(updatedTabs);
    } on Exception catch (e) {
      DebugLog.instance.e('Error updating tab URL: $e');
    }
  }

  Future<void> updateTabTitle(String tabId, String? title) async {
    try {
      final List<BrowserTabModel> updatedTabs = state.tabs.map((BrowserTabModel tab) {
        if (tab.id == tabId) {
          return tab.copyWith(title: title);
        }
        return tab;
      }).toList();

      emit(state.copyWith(tabs: updatedTabs));
      await tabsRepository.saveTabs(updatedTabs);
    } on Exception catch (e) {
      DebugLog.instance.e('Error updating tab title: $e');
    }
  }

  Future<void> updateTabLoading(String tabId, {required bool isLoading}) async {
    try {
      final List<BrowserTabModel> updatedTabs = state.tabs.map((BrowserTabModel tab) {
        if (tab.id == tabId) {
          return tab.copyWith(isLoading: isLoading);
        }
        return tab;
      }).toList();

      emit(state.copyWith(tabs: updatedTabs));
    } on Exception catch (e) {
      DebugLog.instance.e('Error updating tab loading: $e');
    }
  }

  Future<void> updateTabProgress(String tabId, double progress) async {
    try {
      final List<BrowserTabModel> updatedTabs = state.tabs.map((BrowserTabModel tab) {
        if (tab.id == tabId) {
          return tab.copyWith(progress: progress);
        }
        return tab;
      }).toList();

      emit(state.copyWith(tabs: updatedTabs));
    } on Exception catch (e) {
      DebugLog.instance.e('Error updating tab progress: $e');
    }
  }

  Future<void> updateNavigationState(String tabId, {bool? canGoBack, bool? canGoForward}) async {
    try {
      final List<BrowserTabModel> updatedTabs = state.tabs.map((BrowserTabModel tab) {
        if (tab.id == tabId) {
          return tab.copyWith(
            canGoBack: canGoBack ?? tab.canGoBack,
            canGoForward: canGoForward ?? tab.canGoForward,
          );
        }
        return tab;
      }).toList();

      emit(state.copyWith(tabs: updatedTabs));
    } on Exception catch (e) {
      DebugLog.instance.e('Error updating navigation state: $e');
    }
  }

  @override
  TabsState getResetErrorState() => state.copyWith(msg: '');

  @override
  TabsState getResetRedirectionState() => state.copyWith();
}


import '../../../utils/exports.dart';
import '../model/browser_tab_model.dart';

class TabsState extends BaseState {
  const TabsState({
    required super.status,
    super.redirectRoute,
    super.msg,
    this.tabs = const <BrowserTabModel>[],
    this.activeTabId,
    this.currentUrl = 'https://www.kuvaka.io/',
  });

  final List<BrowserTabModel> tabs;
  final String? activeTabId;
  final String currentUrl;

  TabsState copyWith({
    BaseStateStatus? status,
    PageRouteInfo? redirectRoute,
    String? msg,
    List<BrowserTabModel>? tabs,
    String? activeTabId,
    String? currentUrl,
  }) {
    return TabsState(
      status: status ?? this.status,
      redirectRoute: redirectRoute ?? this.redirectRoute,
      msg: msg ?? this.msg,
      tabs: tabs ?? this.tabs,
      activeTabId: activeTabId ?? this.activeTabId,
      currentUrl: currentUrl ?? this.currentUrl,
    );
  }

  BrowserTabModel? get activeTab {
    if (activeTabId == null) return null;
    try {
      return tabs.firstWhere((BrowserTabModel tab) => tab.id == activeTabId);
    } on Exception catch (_) {
      return null;
    }
  }

  static TabsState initial() {
    return const TabsState(
      status: BaseStateStatus.initial,
      tabs: <BrowserTabModel>[],
    );
  }
}


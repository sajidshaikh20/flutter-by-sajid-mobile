import '../../../utils/exports.dart';


@RoutePage()
class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final TextEditingController _urlController = TextEditingController();
  final Map<String, GlobalKey<WebViewContainerState>> _webViewKeys =
      <String, GlobalKey<WebViewContainerState>>{};
  TabsCubit? _tabsCubit;

  @override
  void initState() {
    super.initState();
    _tabsCubit = TabsCubit(tabsRepository: TabsRepositoryImpl());
  }

  @override
  void dispose() {
    _urlController.dispose();
    unawaited(_tabsCubit?.close());
    super.dispose();
  }

  void _handleUrlSubmitted(String url) {
    final BrowserTabModel? activeTab = _tabsCubit?.state.activeTab;
    if (activeTab != null) {
      final GlobalKey<WebViewContainerState>? key = _webViewKeys[activeTab.id];
      unawaited(key?.currentState?.loadUrl(url));
    }
  }

  void _handleBack() {
    final BrowserTabModel? activeTab = _tabsCubit?.state.activeTab;
    if (activeTab != null) {
      final GlobalKey<WebViewContainerState>? key = _webViewKeys[activeTab.id];
      unawaited(key?.currentState?.goBack());
    }
  }

  void _handleForward() {
    final BrowserTabModel? activeTab = _tabsCubit?.state.activeTab;
    if (activeTab != null) {
      final GlobalKey<WebViewContainerState>? key = _webViewKeys[activeTab.id];
      unawaited(key?.currentState?.goForward());
    }
  }

  void _handleRefresh() {
    final BrowserTabModel? activeTab = _tabsCubit?.state.activeTab;
    if (activeTab != null) {
      final GlobalKey<WebViewContainerState>? key = _webViewKeys[activeTab.id];
      unawaited(key?.currentState?.reload());
    }
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<TabsCubit>.value(value: _tabsCubit!),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MainConfig.appColors.backgroundWhiteColor,
          body: BlocBuilder<TabsCubit, TabsState>(
            builder: (BuildContext context, TabsState state) {
              final BrowserTabModel? activeTab = state.activeTab;

              // Update URL controller when active tab changes
              if (activeTab != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_urlController.text != activeTab.url) {
                    _urlController.text = activeTab.url;
                  }
                });
              }

              // Create web view keys for all tabs
              for (final BrowserTabModel tab in state.tabs) {
                if (!_webViewKeys.containsKey(tab.id)) {
                  _webViewKeys[tab.id] = GlobalKey<WebViewContainerState>();
                }
              }

              // Remove keys for closed tabs
              final Set<String> tabIds =
                  state.tabs.map((BrowserTabModel t) => t.id).toSet();
              _webViewKeys.removeWhere(
                  (String key, GlobalKey<WebViewContainerState> value) =>
                      !tabIds.contains(key));

              if (activeTab == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                children: <Widget>[
                  // Tab bar - wrapped with BlocBuilder for instant updates
                  BrowserTabBar(
                    onTabSelected: (String tabId) {
                      unawaited(_tabsCubit?.switchTab(tabId));
                    },
                    onTabClosed: (String tabId) {
                      // Remove key immediately for instant UI update
                      _webViewKeys.remove(tabId);
                      // Close tab (state will update instantly)
                      unawaited(_tabsCubit?.closeTab(tabId));
                    },
                    onNewTabPressed: () {
                      // Create new tab (state will update instantly)
                      unawaited(_tabsCubit?.createNewTab('https://www.google.com'));
                    },
                  ),
                  // Toolbar
                  BrowserToolbar(
                    urlController: _urlController,
                    onUrlSubmitted: _handleUrlSubmitted,
                    onBackPressed: _handleBack,
                    onForwardPressed: _handleForward,
                    onRefreshPressed: _handleRefresh,
                    canGoBack: activeTab.canGoBack,
                    canGoForward: activeTab.canGoForward,
                    isLoading: activeTab.isLoading,
                  ),
                  // WebView
                  Expanded(
                    child: WebViewContainer(
                      key: _webViewKeys[activeTab.id],
                      tab: activeTab,
                      cubit: _tabsCubit!,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

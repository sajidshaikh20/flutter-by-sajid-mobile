import '../../../utils/exports.dart';
import '../../ai_summary/cubit/ai_summary_cubit.dart';
import '../../ai_summary/ui/widget/summary_panel.dart';
import '../cubit/tabs_cubit.dart';
import '../repo/tabs_repository_impl.dart';
import 'widget/browser_tab_bar.dart';
import 'widget/browser_toolbar.dart';
import 'widget/download_button.dart';
import 'widget/web_view_container.dart';

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
  AiSummaryCubit? _summaryCubit;

  @override
  void initState() {
    super.initState();
    _tabsCubit = TabsCubit(tabsRepository: TabsRepositoryImpl());
    _summaryCubit = AiSummaryCubit();
  }

  @override
  void dispose() {
    _urlController.dispose();
    unawaited(_tabsCubit?.close());
    unawaited(_summaryCubit?.close());
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

  Future<void> _handleSummarize() async {
    final BrowserTabModel? activeTab = _tabsCubit?.state.activeTab;
    if (activeTab != null) {
      final GlobalKey<WebViewContainerState>? key = _webViewKeys[activeTab.id];
      final String? text = await key?.currentState?.extractPageText();
      if (text != null && text.isNotEmpty && _summaryCubit != null) {
        await _summaryCubit!.summarizeText(text);
      }
    }
  }

  String _getFileNameFromUrl(String url) {
    try {
      final Uri uri = Uri.parse(url);
      final String path = uri.path;
      if (path.isNotEmpty) {
        final List<String> segments = path.split('/');
        final String fileName = segments.last;
        return fileName.isNotEmpty ? fileName : 'download';
      }
      return 'download';
    } on Exception catch (_) {
      return 'download';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<TabsCubit>.value(value: _tabsCubit!),
        BlocProvider<AiSummaryCubit>.value(value: _summaryCubit!),
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
                  // Summary Panel
                  BlocBuilder<AiSummaryCubit, AiSummaryState>(
                    builder:
                        (BuildContext context, AiSummaryState summaryState) {
                      if (summaryState.summary != null) {
                        return SummaryPanel(
                          summary: summaryState.summary!,
                          onClose: () {
                            _summaryCubit?.clearSummary();
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              );
            },
          ),
          floatingActionButton: BlocBuilder<TabsCubit, TabsState>(
            builder: (BuildContext context, TabsState state) {
              final BrowserTabModel? activeTab = state.activeTab;
              if (activeTab == null) return const SizedBox.shrink();

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Summarize button
                  FloatingActionButton(
                    onPressed: _handleSummarize,
                    backgroundColor: MainConfig.appColors.mainColor,
                    heroTag: 'summarize',
                    child: const Icon(Icons.summarize, color: Colors.white),
                    tooltip: 'Summarize Page',
                  ),
                  const SizedBox(height: Dimens.space8),
                  // Download button (shown for all pages, will check if downloadable)
                  DownloadButton(
                    url: activeTab.url,
                    fileName: _getFileNameFromUrl(activeTab.url),
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

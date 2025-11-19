import '../../../../utils/exports.dart';
import '../../model/browser_tab_model.dart';
import '../../cubit/tabs_cubit.dart';
import '../../cubit/tabs_state.dart';

class BrowserTabBar extends StatelessWidget {
  const BrowserTabBar({
    super.key,
    required this.onTabSelected,
    required this.onTabClosed,
    required this.onNewTabPressed,
  });

  final ValueChanged<String> onTabSelected;
  final ValueChanged<String> onTabClosed;
  final VoidCallback onNewTabPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabsCubit, TabsState>(
      buildWhen: (TabsState previous, TabsState current) {
        // Rebuild when tabs list changes or activeTabId changes
        final bool tabsChanged = previous.tabs.length != current.tabs.length ||
            previous.activeTabId != current.activeTabId;
        
        // Also check if tab IDs changed (for when tabs are replaced)
        if (!tabsChanged && previous.tabs.length == current.tabs.length) {
          final Set<String> previousIds = previous.tabs.map((BrowserTabModel t) => t.id).toSet();
          final Set<String> currentIds = current.tabs.map((BrowserTabModel t) => t.id).toSet();
          return previousIds != currentIds;
        }
        
        return tabsChanged;
      },
      builder: (BuildContext context, TabsState state) {
        final List<BrowserTabModel> tabs = state.tabs;
        final String? activeTabId = state.activeTabId;
        DebugLog.instance.d('BrowserTabBar rebuild: ${tabs.length} tabs, active: $activeTabId');
        return Container(
          height: Dimens.size48,
          color: MainConfig.appColors.backgroundWhiteColor,
          child: Row(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  key: ValueKey<int>(tabs.length), // Force rebuild when tab count changes
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: false,
                  itemCount: tabs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final BrowserTabModel tab = tabs[index];
                    final bool isActive = tab.id == activeTabId;
                    return _TabItem(
                      key: ValueKey<String>(tab.id), // Unique key for each tab to force rebuild
                      tab: tab,
                      isActive: isActive,
                      onTap: () {
                        // Ensure tab switching happens
                        onTabSelected(tab.id);
                      },
                      onClose: () => onTabClosed(tab.id),
                    );
                  },
                ),
              ),
              // New tab button
              IconButton(
                icon: const Icon(Icons.add),
                color: MainConfig.appColors.mainColor,
                onPressed: onNewTabPressed,
                tooltip: 'New Tab',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    super.key,
    required this.tab,
    required this.isActive,
    required this.onTap,
    required this.onClose,
  });

  final BrowserTabModel tab;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimens.radius8),
        child: Container(
          width: Dimens.size150,
          margin: const EdgeInsets.only(
            left: Dimens.space4,
            top: Dimens.space4,
            bottom: Dimens.space4,
          ),
          decoration: BoxDecoration(
            color: isActive
                ? MainConfig.appColors.backgroundWhiteColor
                : MainConfig.appColors.backgroundLightPinkColor,
            borderRadius: BorderRadius.circular(Dimens.radius8),
            border: Border.all(
              color: isActive
                  ? MainConfig.appColors.mainColor
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
          children: <Widget>[
            const SizedBox(width: Dimens.space8),
            // Favicon or loading indicator
            if (tab.isLoading)
              const SizedBox(
                width: Dimens.size16,
                height: Dimens.size16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            else
              Icon(
                Icons.language,
                size: Dimens.size16,
                color: MainConfig.appColors.mainColor,
              ),
            const SizedBox(width: Dimens.space8),
            // Tab title
            Expanded(
              child: Text(
                tab.title ?? _getDomainFromUrl(tab.url),
                style: context.textTheme.bodySmall?.copyWith(
                  color: isActive
                      ? MainConfig.appColors.mainColor
                      : MainConfig.appColors.textMediumDarkBlueColor,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(width: Dimens.space4),
            // Close button - use GestureDetector to stop tap propagation
            GestureDetector(
              onTap: () => onClose(),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.all(Dimens.space4),
                child: Icon(
                  Icons.close,
                  size: Dimens.size16,
                  color: MainConfig.appColors.greyTextColor,
                ),
              ),
            ),
            const SizedBox(width: Dimens.space4),
          ],
        ),
        ),
      ),
    );
  }

  String _getDomainFromUrl(String url) {
    try {
      final Uri uri = Uri.parse(url);
      return uri.host.isEmpty ? 'New Tab' : uri.host;
    } on Exception catch (_) {
      return 'New Tab';
    }
  }
}



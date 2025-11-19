import '../../../../utils/exports.dart';
import '../../model/browser_tab_model.dart';

class BrowserTabBar extends StatelessWidget {
  const BrowserTabBar({
    super.key,
    required this.tabs,
    required this.activeTabId,
    required this.onTabSelected,
    required this.onTabClosed,
    required this.onNewTabPressed,
  });

  final List<BrowserTabModel> tabs;
  final String? activeTabId;
  final ValueChanged<String> onTabSelected;
  final ValueChanged<String> onTabClosed;
  final VoidCallback onNewTabPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.size48,
      color: MainConfig.appColors.backgroundWhiteColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              itemBuilder: (BuildContext context, int index) {
                final BrowserTabModel tab = tabs[index];
                final bool isActive = tab.id == activeTabId;
                return _TabItem(
                  tab: tab,
                  isActive: isActive,
                  onTap: () => onTabSelected(tab.id),
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
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
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
    return GestureDetector(
      onTap: onTap,
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
            // Close button
            GestureDetector(
              onTap: onClose,
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



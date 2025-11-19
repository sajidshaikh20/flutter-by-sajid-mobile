import '../../../../utils/exports.dart';

class BrowserToolbar extends StatelessWidget {
  const BrowserToolbar({
    super.key,
    required this.urlController,
    required this.onUrlSubmitted,
    required this.onBackPressed,
    required this.onForwardPressed,
    required this.onRefreshPressed,
    required this.canGoBack,
    required this.canGoForward,
    required this.isLoading,
  });

  final TextEditingController urlController;
  final ValueChanged<String> onUrlSubmitted;
  final VoidCallback onBackPressed;
  final VoidCallback onForwardPressed;
  final VoidCallback onRefreshPressed;
  final bool canGoBack;
  final bool canGoForward;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.space12,
        vertical: Dimens.space8,
      ),
      decoration: BoxDecoration(
        color: MainConfig.appColors.backgroundWhiteColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          // Back button
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: canGoBack
                  ? MainConfig.appColors.mainColor
                  : MainConfig.appColors.greyTextColor,
            ),
            onPressed: canGoBack ? onBackPressed : null,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: Dimens.space8),
          // Forward button
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: canGoForward
                  ? MainConfig.appColors.mainColor
                  : MainConfig.appColors.greyTextColor,
            ),
            onPressed: canGoForward ? onForwardPressed : null,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: Dimens.space8),
          // Refresh button
          IconButton(
            icon: Icon(
              isLoading ? Icons.close : Icons.refresh,
              color: MainConfig.appColors.mainColor,
            ),
            onPressed: onRefreshPressed,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: Dimens.space8),
          // URL bar
          Expanded(
            child: Container(
              height: Dimens.size40,
              decoration: BoxDecoration(
                color: MainConfig.appColors.backgroundLightPinkColor,
                borderRadius: BorderRadius.circular(Dimens.radius10),
              ),
              child: TextField(
                controller: urlController,
                decoration: InputDecoration(
                  hintText: 'Enter URL or search',
                  hintStyle: context.textTheme.bodyMedium?.copyWith(
                    color: MainConfig.appColors.greyTextColor,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Dimens.space16,
                    vertical: Dimens.space10,
                  ),
                  suffixIcon: isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(Dimens.space12),
                          child: SizedBox(
                            width: Dimens.size16,
                            height: Dimens.size16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : null,
                ),
                style: context.textTheme.bodyMedium,
                onSubmitted: onUrlSubmitted,
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.go,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


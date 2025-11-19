import '../../../../utils/exports.dart';

class SummaryPanel extends StatelessWidget {
  const SummaryPanel({
    super.key,
    required this.summary,
    required this.onClose,
  });

  final SummaryModel summary;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: MainConfig.appColors.backgroundWhiteColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimens.radius20),
          topRight: Radius.circular(Dimens.radius20),
        ),
      ),
      child: Column(
        children: <Widget>[
          // Header
          Container(
            padding: const EdgeInsets.all(Dimens.space16),
            decoration: BoxDecoration(
              color: MainConfig.appColors.mainColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimens.radius20),
                topRight: Radius.circular(Dimens.radius20),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.summarize,
                  color: MainConfig.appColors.mainColor,
                ),
                const SizedBox(width: Dimens.space8),
                Expanded(
                  child: Text(
                    'AI Summary',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: MainConfig.appColors.mainColor,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose,
                  color: MainConfig.appColors.greyTextColor,
                ),
              ],
            ),
          ),
          // Stats
          Padding(
            padding: const EdgeInsets.all(Dimens.space16),
            child: Row(
              children: <Widget>[
                _StatItem(
                  label: 'Original',
                  value: '${summary.originalWordCount} words',
                  icon: Icons.description,
                ),
                const SizedBox(width: Dimens.space16),
                _StatItem(
                  label: 'Summary',
                  value: '${summary.summaryWordCount} words',
                  icon: Icons.text_snippet,
                ),
                const SizedBox(width: Dimens.space16),
                _StatItem(
                  label: 'Reduced',
                  value: '${summary.reductionPercentage.toStringAsFixed(1)}%',
                  icon: Icons.trending_down,
                  color: Colors.green,
                ),
              ],
            ),
          ),
          const Divider(),
          // Translation language selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space16, vertical: Dimens.space8),
            child: Row(
              children: <Widget>[
                const Icon(Icons.translate, size: Dimens.size20, color: Colors.grey),
                const SizedBox(width: Dimens.space8),
                Expanded(
                  child: DropdownButton<String>(
                    value: summary.translatedLanguage ?? 'en',
                    isExpanded: true,
                    hint: const Text('Select language to translate'),
                    items: <String>['en', 'hi', 'es', 'fr', 'de', 'ur', 'ar', 'zh', 'ja', 'pt', 'ru', 'it']
                        .map<DropdownMenuItem<String>>((String value) {
                      final Map<String, String> languageNames = <String, String>{
                        'en': 'English',
                        'hi': 'Hindi',
                        'es': 'Spanish',
                        'fr': 'French',
                        'de': 'German',
                        'ur': 'Urdu',
                        'ar': 'Arabic',
                        'zh': 'Chinese',
                        'ja': 'Japanese',
                        'pt': 'Portuguese',
                        'ru': 'Russian',
                        'it': 'Italian',
                      };
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(languageNames[value] ?? value.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null && newValue != 'en') {
                        unawaited(context.read<AiSummaryCubit>().translateSummary(newValue));
                      } else if (newValue == 'en') {
                        // Show original summary (clear translation)
                        context.read<AiSummaryCubit>().clearTranslation();
                      }
                    },
                  ),
                ),
                if (context.watch<AiSummaryCubit>().state.isTranslating)
                  const Padding(
                    padding: EdgeInsets.only(left: Dimens.space8),
                    child: SizedBox(
                      width: Dimens.size20,
                      height: Dimens.size20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
              ],
            ),
          ),
          const Divider(),
          // Summary or Translation text
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(Dimens.space16),
              child: Text(
                summary.translation ?? summary.summary,
                style: context.textTheme.bodyLarge,
              ),
            ),
          ),
          // Actions
          Container(
            padding: const EdgeInsets.all(Dimens.space16),
            decoration: BoxDecoration(
              color: MainConfig.appColors.backgroundLightPinkColor,
              border: Border(
                top: BorderSide(
                  color: MainConfig.appColors.greyTextColor.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _ActionButton(
                  icon: Icons.copy,
                  label: 'Copy',
                  onPressed: () {
                    final String textToCopy = summary.translation ?? summary.summary;
                    unawaited(Clipboard.setData(ClipboardData(text: textToCopy)));
                    displaySnackBar('Copied to clipboard', context);
                  },
                ),
                _ActionButton(
                  icon: Icons.share,
                  label: 'Share',
                  onPressed: () {
                    final String textToShare = summary.translation ?? summary.summary;
                    unawaited(Share.share(textToShare));
                  },
                ),
                _ActionButton(
                  icon: Icons.download,
                  label: 'Download',
                  onPressed: () {
                    // TODO(sajid): Implement download functionality
                    displaySnackBar('Download feature coming soon', context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            color: color ?? MainConfig.appColors.mainColor,
            size: Dimens.size24,
          ),
          const SizedBox(height: Dimens.space4),
          Text(
            value,
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: MainConfig.appColors.greyTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.space16,
          vertical: Dimens.space8,
        ),
        decoration: BoxDecoration(
          color: MainConfig.appColors.backgroundWhiteColor,
          borderRadius: BorderRadius.circular(Dimens.radius8),
          border: Border.all(
            color: MainConfig.appColors.mainColor.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: Dimens.size18,
              color: MainConfig.appColors.mainColor,
            ),
            const SizedBox(width: Dimens.space8),
            Text(
              label,
              style: context.textTheme.bodyMedium?.copyWith(
                color: MainConfig.appColors.mainColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


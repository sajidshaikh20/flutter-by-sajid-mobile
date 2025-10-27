import '../../../../utils/exports.dart';

/// Expandable card widget for displaying product details sections.
class DetailsExpandableCardWidget extends StatefulWidget {
  /// The title text displayed in the card header.
  final String title;

  /// The content text displayed when expanded.
  final String content;

  /// Whether the card should be initially expanded.
  final bool isExpanded;

  /// Creates an expandable card widget for product details.
  const DetailsExpandableCardWidget({
    super.key,
    required this.title,
    required this.content,
    this.isExpanded = false,
  });

  @override
  DetailsExpandableCardWidgetState createState() =>
      DetailsExpandableCardWidgetState();
}
///DetailsExpandableCardWidgetState
class DetailsExpandableCardWidgetState
    extends State<DetailsExpandableCardWidget> with TickerProviderStateMixin {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(
            left: Dimens.space12,
            right: Dimens.space12,
            top: Dimens.space13,
            bottom: Dimens.space14),
        decoration: BoxDecoration(
          border: Border.all(
            color: MainConfig.appColors.lightGreyColor,
            width: Dimens.borderWidth05,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.space8)),
          color: AppColors.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CustomTextLabelWidget(
                  textAlign: TextAlign.start,
                  label: widget.title,
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: Dimens.fontSize16,
                    color: AppColors.blackColor,
                    height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize16),
                  ),
                ),
                const Spacer(),
                Container(
                  decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    color: MainConfig.appColors.iceBlueColor,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: _isExpanded
                      ? Assets.svgs.icDUp.svg()
                      : Assets.svgs.icDDown.svg(),
                ),
              ],
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200), // Animation duration
              curve: Curves.easeInOut, // Smooth transition curve
              child: _isExpanded
                  ? Padding(
                      padding: const EdgeInsets.only(top: Dimens.space8),
                      child: CustomTextLabelWidget(
                        textAlign: TextAlign.start,
                        label: widget.content,
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: Dimens.fontSize14,
                          color: AppColors.blackColor,
                          height:
                              Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(), // Empty widget when collapsed
            ),
          ],
        ),
      ),
    );
  }
}

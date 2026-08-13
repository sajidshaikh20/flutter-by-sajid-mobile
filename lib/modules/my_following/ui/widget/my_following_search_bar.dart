import '../../../../utils/exports.dart';

class MyFollowingSearchBarWidget extends StatefulWidget {
  const MyFollowingSearchBarWidget({
    super.key,
    required this.searchQuery,
    required this.onChanged,
    required this.onClear,
    this.onDatePickerTapped,
    this.onDatePickerClear,
    this.hasActiveDateRange = false,
  });

  final String searchQuery;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final VoidCallback? onDatePickerTapped;
  final VoidCallback? onDatePickerClear;
  final bool hasActiveDateRange;

  @override
  State<MyFollowingSearchBarWidget> createState() => _MyFollowingSearchBarWidgetState();
}

class _MyFollowingSearchBarWidgetState extends State<MyFollowingSearchBarWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.searchQuery);
  }

  @override
  void didUpdateWidget(covariant MyFollowingSearchBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery && widget.searchQuery != _controller.text) {
      _controller.text = widget.searchQuery;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.space16,
        vertical: Dimens.space8,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : AppColors.cardLight,
                borderRadius: BorderRadius.circular(Dimens.radius12),
                border: Border.all(
                  color: isDark
                      ? AppColors.borderDark
                      : AppColors.borderLight.withValues(alpha: 0.5),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space12),
              child: Row(
                children: <Widget>[
                  Icon(Icons.search_rounded, color: subtextColor, size: Dimens.size20),
                  const SizedBox(width: Dimens.space10),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(
                        color: textColor,
                        fontSize: Dimens.fontSize13,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search pair (e.g. BTCU)',
                        hintStyle: TextStyle(
                          color: subtextColor,
                          fontSize: Dimens.fontSize13,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: widget.onChanged,
                    ),
                  ),
                  if (widget.searchQuery.isNotEmpty) ...<Widget>[
                    const SizedBox(width: Dimens.space10),
                    GestureDetector(
                      onTap: () {
                        _controller.clear();
                        widget.onClear();
                      },
                      child: Icon(Icons.clear_rounded, color: subtextColor, size: Dimens.size18),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (widget.onDatePickerTapped != null) ...<Widget>[
            const SizedBox(width: Dimens.space10),
            Container(
              height: 46,
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : AppColors.cardLight,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: widget.hasActiveDateRange
                      ? AppColors.primaryPurple
                      : (isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5)),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                    onTap: widget.onDatePickerTapped,
                    borderRadius: BorderRadius.horizontal(
                      left: const Radius.circular(24),
                      right: Radius.circular(widget.hasActiveDateRange ? 0 : 24),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: widget.hasActiveDateRange ? 8 : 16,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            widget.hasActiveDateRange ? Icons.calendar_month : Icons.calendar_month_outlined,
                            color: widget.hasActiveDateRange ? AppColors.primaryPurple : subtextColor,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Filter',
                            style: TextStyle(
                              color: widget.hasActiveDateRange ? AppColors.primaryPurple : textColor,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.hasActiveDateRange && widget.onDatePickerClear != null) ...<Widget>[
                    Container(
                      width: 1,
                      height: 20,
                      color: isDark ? const Color(0xFF2C3240) : AppColors.borderLight.withValues(alpha: 0.5),
                    ),
                    InkWell(
                      onTap: widget.onDatePickerClear,
                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(24)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 12, top: 10, bottom: 10),
                        child: Icon(
                          Icons.cancel_rounded,
                          color: subtextColor,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

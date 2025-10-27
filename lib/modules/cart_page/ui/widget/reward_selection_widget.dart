import '../../../../utils/exports.dart';

/// A bottom-sheet widget for selecting a reward from a list of `DefaultRewardIds`.
///
/// This widget displays a list of rewards as selectable radio items and provides
/// an "Apply" button to confirm the selection. It also handles the case where
/// no rewards are available.
///
/// Example usage:
/// ```dart
/// showModalBottomSheet(
///   context: context,
///   builder: (_) => RewardSelectionWidget(
///     rewards: rewardList,
///     selectedReward: selectedRewardId,
///     onRewardSelected: (reward) {
///       print('Selected reward: ${reward.id}');
///     },
///     onBottomSheetClose: () {
///       Navigator.pop(context);
///     },
///   ),
/// );
/// ```
class RewardSelectionWidget extends StatelessWidget {
  /// Creates a [RewardSelectionWidget].
  ///
  /// [rewards] is the list of available rewards to choose from.
  /// [selectedReward] is the currently selected reward ID.
  /// [onRewardSelected] is called when a reward is selected and the "Apply" button is pressed.
  /// [onBottomSheetClose] is an optional callback to handle closing the bottom sheet.
  const RewardSelectionWidget({
    super.key,
    required this.rewards,
    this.selectedReward,
    this.onRewardSelected,
    this.onBottomSheetClose,
  });

  /// List of rewards available for selection.
  final List<DefaultRewardIds> rewards;

  /// Currently selected reward ID (if any).
  final int? selectedReward;

  /// Callback triggered when a reward is selected and applied.
  final ValueChanged<DefaultRewardIds>? onRewardSelected;

  /// Optional callback triggered when the bottom sheet is closed.
  final VoidCallback? onBottomSheetClose;

  @override
  Widget build(BuildContext context) {
    if (rewards.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(Dimens.space16),
        child: Center(
          child: CustomTextLabelWidget(
            label: context.appString.noOrdersFoundKey,
            style: context.textTheme.displayMedium,
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: Dimens.space16.padding,
          decoration: BoxDecorationExtension.customDecoration(
            color: AppColors.whiteColor,
            borderRadius: Dimens.radius8.borderRadius,
            border: Border.all(
              color: MainConfig.appColors.lightGreyColor,
              width: Dimens.borderWidth05,
            ),
          ),
          child: BlocBuilder<CartPageCubit, CartPageState>(
            builder: (BuildContext context, CartPageState state) {
              final int? selectedId = state.selectedReward ?? selectedReward;
              return CustomListView(
                itemBuilder: (BuildContext context, int index) {
                  final DefaultRewardIds reward = rewards[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: Dimens.space8),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimens.space16,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: Dimens.space16),
                            child: SelectableRewardRadio(
                              textStyle: context.textTheme.displayMedium?.copyWith(
                                fontSize: Dimens.fontSize14,
                                fontWeight: FontWeight.w600,
                                height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                              ),
                              alignToStart: false,
                              radioPosition: RadioPosition.right,
                              value: (reward.id ?? '').toString(),
                              label: (reward.description?.isNotEmpty ?? false)
                                  ? reward.description!
                                  : '${context.appString.rewardKey} ${(reward.id ?? '').toString()}',
                              groupValue: (selectedId ?? '').toString(),
                              onChanged: (String? value) {
                                context.read<CartPageCubit>().selectRewardOnly(reward.id);
                              },
                              size: Dimens.size16,
                            ),
                          ),
                        ),
                        if (index != rewards.length - 1)
                          const Divider(height: 1),
                      ],
                    ),
                  );
                },
                itemCount: rewards.length,
                isSeparator: false,
              );
            },
          ),
        ),
        BlocBuilder<CartPageCubit, CartPageState>(
          builder: (BuildContext context, CartPageState state) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(
                  Dimens.space16, 0, Dimens.space16, Dimens.space16),
              child: CustomGradientButtonWidget(
                title: context.appString.applyKey,
                isButtonEnabled: state.selectedReward != null,
                onTap: () async {
                  if (state.selectedReward == null) return;
                  final DefaultRewardIds? selected = rewards.firstWhereOrNull(
                          (DefaultRewardIds r) => r.id == state.selectedReward);
                  if (selected == null) return;
                  if (onRewardSelected != null) {
                    onRewardSelected!(selected);
                  } else {
                    await context.read<CartPageCubit>().selectRewardAndApply(selected);
                  }
                  if (onBottomSheetClose != null) {
                    onBottomSheetClose!();
                  } else {
                    await MainConfig.context.router.maybePop();
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

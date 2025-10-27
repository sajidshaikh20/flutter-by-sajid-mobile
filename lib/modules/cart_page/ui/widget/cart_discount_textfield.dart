// This file intentionally presents/dismisses bottom sheets after awaited
// network calls using the app-level router context to avoid using a local
// widget context that may be unmounted.
import '../../../../utils/exports.dart';

/// A widget that represents a text field for entering a discount coupon in the cart page.
class CartDiscountTextField extends StatelessWidget {
  /// Creates a [CartDiscountTextField].
  ///
  /// The [device] parameter determines the screen type (e.g., mobile, tablet).
  /// It defaults to [ScreenType.mobile].
  const CartDiscountTextField({super.key, this.device = ScreenType.mobile});

  /// The type of the screen on which this widget is displayed.
  ///
  /// Defaults to [ScreenType.mobile] if not specified.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return BlocBuilder<CartPageCubit, CartPageState>(
      builder: (BuildContext context, CartPageState state) {
        final bool isCouponApplied = state.isCouponApplied;
        if (!isCouponApplied) {
          state.stateTextEditingController.text = state.couponCode ?? "";
        }
        return CommonTextFormFieldWidget(
          cursorHeight: Dimens.size16,
          borderRadius: Dimens.space8,
          editTextHeight: Dimens.size50,
          borderColor:  MainConfig.appColors.lightGreyColor,
          suffixOnClick: () async {
            FocusScope.of(context).unfocus();
            final CartPageCubit cubit = context.read<CartPageCubit>();
            // Apply coupon; if default rewards are returned, open selection
            await cubit.applyCoupon();
            if (!context.mounted) return;
            final CartPageState updated = cubit.state;
            final List<DefaultRewardIds> rewards = updated.defaultRewardIds ?? <DefaultRewardIds>[];
            if (rewards.isNotEmpty) {
              await showCustomBottomSheetView(
                context: context,
                title: context.appString.selectRewardKey,
                child: BlocProvider<CartPageCubit>.value(
                  value: cubit,
                  child: RewardSelectionWidget(
                    rewards: rewards,
                    selectedReward: updated.selectedReward,
                    onRewardSelected: (DefaultRewardIds reward) async {
                      await cubit.selectRewardAndApply(reward);
                    },
                    onBottomSheetClose: () async {
                      await context.router.maybePop();
                    },
                  ),
                ),
                isCloseIconVisible: true,
              );
            }
          },
          suffixIconConstraints: BoxConstraints(
            minWidth: Dimens.size24,
            minHeight: Dimens.size24,
            maxWidth: isRTL ? Dimens.size55 : Dimens.size50,
            maxHeight: Dimens.size50,
          ),
          suffixIcon: CustomTextLabelWidget(
              maxLines: 1,
              label: context.appString.applyKey,
              style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: MainConfig.appColors.mainColor,
                  fontSize: Dimens.fontSize14,
                  height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14))),
          device: device,
          onTextSubmit: (String p0) async {
            //this is to manage whenever keyboard is open to hide the cart total proceed view
            context
                .read<CartPageCubit>()
                .manageVisibility(isKeyboardVisible: false, state.stateTextEditingController.text);
            await context.read<CartPageCubit>().applyCoupon();
          },
          onTapOutside: (_) {
            final String couponCode = state.stateTextEditingController.text;
            FocusNode().unfocus();
            hideKeyboard();
            context.read<CartPageCubit>().manageVisibility(isKeyboardVisible:false, couponCode);
          },
          onChange: (String value) {
            context
                .read<CartPageCubit>()
                .manageVisibility(isKeyboardVisible:true, state.stateTextEditingController.text);
          },
          onTap: () {},
          controller: state.stateTextEditingController,
          label: context.appString.enterCouponGiftCardKey,
          cursorColor: AppColors.blackColor,
          // Set the desired cursor color
        );
      },
    );
  }
}

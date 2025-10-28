import '../../../../utils/exports.dart';

/// Custom app bar widget for the home screen.
class HomeAppbar extends StatelessWidget {
  /// Creates a home app bar.
  ///
  /// [title] The title text to display in the app bar.
  /// [titleStyle] The style for the title text.
  /// [isShadowDisplay] Whether to display shadow under the app bar.
  /// [isLastItemDisplay] Whether to display the last item in the app bar.
  const HomeAppbar(
      {super.key,
      this.title,
      this.titleStyle,
      this.isShadowDisplay = false,
      this.isLastItemDisplay = true});

  /// The title text to display in the app bar.
  final String? title;

  /// The style for the title text.
  final TextStyle? titleStyle;

  /// Whether to display shadow under the app bar.
  final bool isShadowDisplay;

  /// Whether to display the last item in the app bar.
  final bool isLastItemDisplay;

  @override
  Widget build(BuildContext context) {
    // Refresh delivery type when appbar is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().initializeSegmentIndex();
    });

    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (HomeState previous, HomeState current) {
        // Only rebuild when selected segment index changes
        return previous.selectedSegmentIndex != current.selectedSegmentIndex;
      },
      builder: (BuildContext context, HomeState state) {
        return DecoratedBox(
          decoration: isShadowDisplay
              ? BoxDecorationExtension.customDecoration(
                  boxShadow: <BoxShadow>[
                    createBoxShadowForTopBar(
                        opacity: .2)
                  ],
                  color: MainConfig.appColors.backgroundWhiteColor,
                )
              : const BoxDecoration(),
          child: Column(
            children: <Widget>[
              const SizedBox(height: Dimens.size49),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: isLanguageAlignmentLTR ? Dimens.size16 : 0,
                              right:
                                  isLanguageAlignmentLTR ? 0 : Dimens.size16),
                          child: Assets.png.flutterOriginal512px
                              .image(height: Dimens.size33, width: Dimens.size60),
                        ),
                      ],
                    ),
                  ),
                  title != null
                      ? CustomTextLabelWidget(
                          label: title ?? "",
                          style: titleStyle ??
                              context.textTheme.headlineMedium?.copyWith(
                                  color: AppColors.blackColor,
                                  fontSize: Dimens.size16,
                                  height: Dimens.lineHeight24
                                      .toLineHeight(Dimens.size16),
                                  fontWeight: FontWeight.bold),
                        )
                      : SegmentedControl(
                          firstTitle: context.appString.deliveryKey,
                          secondTitle: context.appString.pickupKey,
                          selectedIndex: state.selectedSegmentIndex,
                          onIndexChanged: (int value) {
                            /*context
                                .read<ProductHomeCubit>()
                                .onSegmentChangedIndex(value);*/
                          },
                        ),
                   Expanded(
                      child: Visibility(
                      visible: isLastItemDisplay,
                      maintainSize: true,
                      maintainState: true,
                      maintainAnimation: true,
                      child: const CommonItemSearchCart()))
                ],
              ),
              const SizedBox(height: Dimens.size6),
            ],
          ),
        );
      },
    );
  }
}

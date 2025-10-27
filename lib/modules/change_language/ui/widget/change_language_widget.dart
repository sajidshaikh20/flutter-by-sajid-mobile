import '../../../../utils/exports.dart';

/// A responsive widget for changing the app language.
/// 
/// This widget provides a UI for users to select between different
/// language options (English/Arabic) with radio button selection.
class ChangeLanguageWidget extends BaseResponsiveView {
  /// Creates a [ChangeLanguageWidget].
  const ChangeLanguageWidget({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildView(context, ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildView(context, ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildView(context, ScreenType.tablet);
  }

  /// Builds the language selection view for the specified device type.
  Widget _buildView(BuildContext context, ScreenType device) {
    return Scaffold(
      backgroundColor: MainConfig.appColors.backgroundPinkColor,
      body: Column(
        children: <Widget>[
          // AppBar
          ProductDetailsAppBar(
            titleText: context.appString.languageKey,
            isLastWidgetDisplay: false,
            prefixIcon: Assets.svgs.icBack
                .svg(height: Dimens.size24, width: Dimens.size24),
          ),

          // Language Selection Container
          Column(
            children: <Widget>[
              Container(
                margin: Dimens.space16.padding,
                decoration: BoxDecorationExtension.customDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: Dimens.radius8.borderRadius,
                  border: Border.all(
                      color: MainConfig.appColors.lightGreyColor,
                      width: Dimens.borderWidth05),
                ),
                child:
                    BlocBuilder<LanguageSelectionCubit, LanguageSelectionState>(
                  buildWhen: (LanguageSelectionState previous,
                      LanguageSelectionState current) {
                    // Only rebuild when language list or selected language code changes
                    return previous.listOfLanguage != current.listOfLanguage ||
                        previous.languageCode != current.languageCode;
                  },
                  builder:
                      (BuildContext context, LanguageSelectionState state) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: state.listOfLanguage.length,
                      itemBuilder: (BuildContext context, int index) {
                        final String option = state.listOfLanguage[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: Dimens.space8),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Dimens.space16,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: Dimens.space16),
                                  child: SelectableIconRadio(
                                    textStyle: context.textTheme.displayMedium
                                        ?.copyWith(
                                      fontSize: Dimens.fontSize14,
                                      fontWeight: FontWeight.w600,
                                      height: Dimens.lineHeight18
                                          .toLineHeight(Dimens.fontSize14),
                                    ),
                                    alignToStart: false,
                                    radioPosition: RadioPosition.right,
                                    value: option,
                                    label: option,
                                    groupValue:
                                        state.languageCode == AppConstant.en
                                            ? AppConstantString.englishText
                                            : AppConstantString.arabicText,
                                    onChanged: (String? value) async {
                                      if (value != null) {
                                        context
                                            .read<LanguageSelectionCubit>()
                                            .navigateToLoginScreen(value ==
                                                    AppConstantString
                                                        .englishText
                                                ? LanguageCode.en
                                                : LanguageCode.ar);
                                      }
                                    },
                                    size: Dimens.size16,
                                  ),
                                ),
                              ),
                              if (index != state.listOfLanguage.length - 1)
                                CustomDivider(
                                  color: MainConfig.appColors.lightGreyColor,
                                  height: Dimens.sizePoint5,
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: Dimens.space16,
              )
            ],
          ),
        ],
      ),
    );
  }
}

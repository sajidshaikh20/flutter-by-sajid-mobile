import '../../../../utils/exports.dart';

/// Widget that displays a search bar with input field and actions.
class SearchBarWidget extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a search bar widget.
  const SearchBarWidget({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double cancelTextSize = Dimens.fontSize16;
    double textFontSize = Dimens.fontSize16;
    switch (device) {
      case ScreenType.tablet:
        cancelTextSize = Dimens.fontSize24;
        textFontSize = Dimens.fontSize22;

      default:
        break;
    }
    return DecoratedBox(
      decoration: BoxDecorationExtension.customDecoration(
        boxShadow: <BoxShadow>[
          createBoxShadowForTopBar(
              opacity: Dimens.opacity02)
        ],
        color: MainConfig.appColors.backgroundWhiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: Dimens.space16,
            right: Dimens.space16,
            bottom: Dimens.space6,
            top: Dimens.space62),
        child: BlocBuilder<SearchCubit, SearchState>(
          buildWhen: (SearchState previous, SearchState current) {
            // Only rebuild when search text changes
            return previous.searchText != current.searchText;
          },
          builder: (BuildContext context, SearchState state) {
            return Row(
              children: <Widget>[
                Expanded(
                  child: Form(
                    key: context.instance<SearchCubit>().state.formKey,
                    child: CustomTextFormFieldWidget(

                      cursorHeight: textFontSize,
                      device: device,
                      onTextSubmit: (String value) {
                        FocusScope.of(context).unfocus();
                      },
                      hintStyle: context.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: MainConfig.appColors.textBlackColor
                              .withValues(alpha:Dimens.opacity04),
                          height:
                              Dimens.lineHeight30.toLineHeight(textFontSize),
                          fontSize: textFontSize),
                      style: context.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: MainConfig.appColors.textBlackColor,
                          height:
                              Dimens.lineHeight30.toLineHeight(textFontSize),
                          fontSize: textFontSize),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      textAlign: TextAlign.start,
                      hint: context.appString.searchProductKey,
                      label: context.appString.searchProductKey,
                      prefixIconConstraints: const BoxConstraints(
                        maxHeight: Dimens.size30,
                        maxWidth: Dimens.size37,
                      ),
                      autoFocus: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                            left: Dimens.space7, right: Dimens.space12),
                        child: Assets.svgs.icSearch.svg(
                            height: Dimens.size18,
                            width: Dimens.size18,
                            colorFilter: ColorFilter.mode(
                              MainConfig.appColors.backgroundSearchIcon,
                              BlendMode.srcATop,
                            )),
                      ),
                      prefixIconColor: AppColors.colorBlackBastille,
                      suffixIcon: state.searchText.isNotNullOrEmpty
                          ? Container(
                              height: Dimens.size16,
                              width: Dimens.size16,
                              padding: Dimens.space4.padding,
                              decoration:
                                  BoxDecorationExtension.customDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.blackColor.withValues(alpha:.8),
                              ),
                              child: Assets.svgs.icCloseWhite.svg(),
                            )
                          : null,
                      suffixOnClick: () {
                        state.searchController.clear();
                        context.instance<SearchCubit>().onClearText();
                      },
                      blendMode: BlendMode.srcIn,
                      controller: state.searchController,
                      input: TextInputAction.search,
                      onChange: (String value) async {

                        if (value.trim().isNotNullOrEmpty && value.length > 2) {
                          await context.instance<SearchCubit>().getProductListing(
                              typeId : state.typeId,
                              type : state.type,
                              query: value
                          );
                        } else {
                          if (value.trim().isNotNullOrEmpty) {
                            context
                                .instance<SearchCubit>()
                                .emitOnChangeText(value);
                          } else {
                            context.instance<SearchCubit>().onClearText();
                          }
                        }
                      },
                    ),
                  ),
                ),
                Dimens.size11.widthBox,
                CustomTextLabelWidget(
                  label: context.appString.cancelKey,
                  style: context.textTheme.headlineMedium?.copyWith(
                      fontSize: cancelTextSize,
                      color: MainConfig.appColors.mainColor,
                      fontWeight: FontWeight.w600,
                      height: Dimens.lineHeight30.toLineHeight(cancelTextSize)),
                  onTap: () async => context.router.maybePop(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(Dimens.size100);
}

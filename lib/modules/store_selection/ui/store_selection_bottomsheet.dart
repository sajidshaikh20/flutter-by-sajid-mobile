import '../../../utils/exports.dart';

/// Shows a bottom sheet for store selection with a map and store listings.
///
/// Displays a modal bottom sheet containing a Google Map with search functionality
/// and a horizontal list of available stores.
Future<void> showSelectStoreBottomSheet(
  BuildContext context, {
  List<String>? sortList,
}) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext cont) => Container(
        height: context.height * Dimens.size09,
        decoration: BoxDecorationExtension.customDecoration(
          color: Colors.white, // Set the desired color
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(Dimens.space20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: Dimens.space19,
                top: Dimens.space30,
                right: Dimens.space13,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomTextLabelWidget(
                    label: MainConfig.dynamicString(
                      JsonServiceString.keySelectStore,
                    ),
                    style: context.textTheme.headlineMedium
                        ?.copyWith(color: MainConfig.appColors.textDarkBlueColor),
                  ),
                  Assets.svgs.icCloseIcon.svg(),
                ],
              ),
            ),
            Dimens.size24.heightBox,
            Expanded(
              child: Stack(
                children: <Widget>[
                  const GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        AppConstant.targetLatitude,
                        AppConstant.targetLongitude,
                      ),
                      zoom: AppConstant.zoomLevel,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: Dimens.space19,
                      left: Dimens.space15,
                      right: Dimens.space15,
                    ),
                    child: CustomTextFormFieldWidget(
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: Dimens.radius10.borderRadius,
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: Dimens.radius10.borderRadius,
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: Dimens.radius10.borderRadius,
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: MainConfig.dynamicString(
                          JsonServiceString.keySearchPlaceholder,
                        ),
                        hintStyle: context.textTheme.bodySmall?.copyWith(
                          fontSize: Dimens.fontSize16,
                          color: MainConfig.appColors.textColorGrey,
                        ),
                        contentPadding:
                            const EdgeInsets.only(top: Dimens.space10),
                        prefixIcon: Container(
                          margin: const EdgeInsets.only(
                            left: Dimens.space10,
                            top: Dimens.space10,
                            bottom: Dimens.space10,
                          ),
                          padding: const EdgeInsets.only(right: Dimens.space25),
                          child: Assets.svgs.icSearch.svg(
                            colorFilter:  ColorFilter.mode(
                              MainConfig.appColors.iconGrey,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      controller: TextEditingController(),
                      prefixOnClick: () {},
                    ),
                  ),
                  Align(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.space11,
                            vertical: Dimens.space2,
                          ),
                          height: Dimens.space23,
                          decoration: BoxDecoration(
                            borderRadius: Dimens.radius3.borderRadius,
                            color: MainConfig.appColors.boxDecorationBlack
                                .withValues(alpha: 0.73),
                          ),
                          child: CustomTextLabelWidget(
                            label: AppConstant.moveLocation,
                            style: context.textTheme.bodySmall?.copyWith(
                              fontSize: Dimens.space12,
                              color: MainConfig.appColors.textWhiteColor,
                            ),
                          ),
                        ),
                        Dimens.size5.heightBox,
                        Assets.svgs.icMapLocationIcon.svg(),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: Dimens.space160,
                      width: context.width,
                      child: const StoreListingPage(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Dimens.radius25.circularRadius),
      ),
    );

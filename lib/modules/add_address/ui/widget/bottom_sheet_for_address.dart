import '../../../../utils/exports.dart';

/// Displays a bottom sheet for selecting a country, state, or city based on the
/// [BottomSheetDataType]. The bottom sheet is populated with the corresponding
/// list of
/// countries, states, or cities from the given [AddressState].
///
/// [buildContext] is the context of the widget tree.
/// [state] is the current state containing the address data.
/// [bottomSheetDataType] determines whether the bottom sheet
/// displays countries,
/// states, or cities.
/// [device] is the type of device (mobile, tablet, desktop) to adjust layout.
void showBottomSheetForAddress(
    BuildContext buildContext,
    AddressState state,
    BottomSheetDataType bottomSheetDataType, {
      ScreenType device = ScreenType.mobile,
    }) {
  List<dynamic> list = <dynamic>[];
  String title = '';
  double fontSize = Dimens.fontSize16;
  double padding = Dimens.space10;

  // Adjust UI based on device type (mobile, tablet, desktop)
  switch (device) {
    case ScreenType.tablet:
      fontSize = Dimens.fontSize21;
      padding = Dimens.space16;
    case ScreenType.mobile:
    case ScreenType.desktop:
    // No adjustments needed for mobile or desktop
      break;
  }

  // Set the list and title based on the selected bottom sheet data type
  if (bottomSheetDataType == BottomSheetDataType.country) {
    list = state.listOfCountry;
    title = MainConfig.dynamicString(JsonServiceString.keyAddressSelectCountry);
  } else if (bottomSheetDataType == BottomSheetDataType.state) {
    list = state.selectedCountry?.states ?? <dynamic>[];
    title = MainConfig.dynamicString(JsonServiceString.keyAddressSelectState);
  } else if (bottomSheetDataType == BottomSheetDataType.city) {
    list = state.listOfCity;
    title = MainConfig.dynamicString(JsonServiceString.keyAddressSelectCity);
  }

  // Show the custom bottom sheet with a list of countries, states, or cities
  unawaited(
    showCustomBottomSheetView(
      context: buildContext,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          dynamic listData = list[index];
          String label = '';

          if (listData is CountryData) {
            label = listData.name ??
                ''; // Accessing the 'name' property from CountryData
          } else if (listData is States) {
            label = listData.name ??
                ''; // Accessing the 'name' property from States
          } else if (listData is CityArea) {
            label = listData.name ??
                ''; // Accessing the 'name' property from CityArea
          } else {
            label = ''; // Default case if listData doesn't match any type
          }

          return InkWell(
            onTap: () async {
              // Handle tap actions for country, state, or city selection
              if (bottomSheetDataType == BottomSheetDataType.country) {
                CountryData listData = list[index] as CountryData;
                state.countryTextEditingController.text = listData.name ?? '';
                state.countryTextEditingController.text = listData.name ?? '';
                buildContext
                    .instance<AddressCubit>()
                    .setSelectedCountry(listData);
                goBack(buildContext);
              } else if (bottomSheetDataType == BottomSheetDataType.state) {
                States listData = list[index] as States;
                state.stateTextEditingController.text = listData.name ?? '';
                await buildContext
                    .instance<AddressCubit>()
                    .setSelectedState(listData);
                goBack(buildContext.mounted as BuildContext);
              } else if (bottomSheetDataType == BottomSheetDataType.city) {
                CityArea listData = list[index] as CityArea;
                state.cityTextEditingController.text = listData.name ?? '';
                goBack(buildContext);
              }
            },
            child: Padding(
              padding: padding.padding,
              child: CustomTextLabelWidget(
                textAlign: TextAlign.start,
                label: label,
                style: context.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.normal,
                  color: MainConfig.appColors.textBlackColor,
                  fontSize: fontSize,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => CustomDivider(
          color: MainConfig.appColors.dividerGrey,
          height: Dimens.size1,
        ),
      ),
      title: title,
    ),
  );
}

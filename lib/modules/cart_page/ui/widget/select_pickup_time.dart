import '../../../../utils/exports.dart';
/// A widget that displays a UI for selecting a pickup time for orders.
///
/// Typically used in checkout or order scheduling screens to allow users
/// to choose a time slot for picking up their order.
class SelectPickupTime extends StatelessWidget {
  /// Creates a [SelectPickupTime] widget.
  const SelectPickupTime({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartPageCubit, CartPageState>(
      builder: (BuildContext context, CartPageState state) {
        // Get time slots from API
        final List<TimeSlotsResponse>? timeSlots = state.availableTimeSlots;
        
        // Show loading or empty state if no time slots available
        if (timeSlots == null || timeSlots.isEmpty) {
          return Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.space16),
                  child: CustomTextLabelWidget(
                    label: context.appString.noTimeSlotsAvailableKey,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          );
        }
        
        return Column(
          children: <Widget>[
            SingleChildScrollView(
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  top: Dimens.space16,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: timeSlots.length,
                itemBuilder: (BuildContext context, int index) {
                  final TimeSlotsResponse timeSlot = timeSlots[index];
                  final bool isSelected = state.selectedTimeSlot == index;
                  // For API data, we assume all slots are available unless specified otherwise
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: index == timeSlots.length - 1
                            ? Dimens.space0
                            : Dimens.space8),
                    child: CustomButtonWidget(
                      textDirection: TextDirection.ltr,
                      isPrimaryButton: false,
                      borderColor: isSelected
                          ? MainConfig.appColors.backgroundMediumDarkBlueColor
                          : MainConfig.appColors.lightGreyColor,
                      title: timeSlot.time ?? '',
                      borderRadius: Dimens.size8,
                      borderWidth: Dimens.borderWidth05,
                      hasBorder: true,
                      drawBorderInDecoration: true,
                      backgroundColor: isSelected
                          ? MainConfig.appColors.iceBlueColor
                          : MainConfig.appColors.backgroundWhite,
                      titleTextStyle:
                          context.textTheme.headlineMedium?.copyWith(
                        fontSize: Dimens.fontSize14,
                        fontWeight: FontWeight.w700,
                        height:
                            Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
                        color: isSelected
                            ? MainConfig.appColors.mainColor
                            : MainConfig.appColors.textBlackColor,
                      ),
                      onTap: () {
                        context
                            .read<CartPageCubit>()
                            .selectTimeSlot(index);
                        // Close the bottom sheet immediately after selection
                        context.router.popForced();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

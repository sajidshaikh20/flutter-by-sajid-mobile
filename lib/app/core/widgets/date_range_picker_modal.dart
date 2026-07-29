import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../utils/exports.dart';

/// Shows a date range picker dialog utilizing Syncfusion DateRangePicker.
///
/// Returns the selected [PickerDateRange] or `null` if cancelled/cleared.
Future<PickerDateRange?> showDateRangePickerModal(
  BuildContext context, {
  PickerDateRange? initialRange,
}) async {
  final bool isDark = context.isDark;
  final Color bgColor = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
  final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

  return showDialog<PickerDateRange>(
    context: context,
    builder: (BuildContext context) {
      PickerDateRange? selectedRange = initialRange;

      return Dialog(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.radius16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.space16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomTextLabelWidget(
                label: 'Select Date Range',
                style: TextStyle(
                  color: textColor,
                  fontSize: Dimens.fontSize16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Dimens.space10),
              SizedBox(
                height: 240,
                width: 300,
                child: SfDateRangePicker(
                  backgroundColor: bgColor,
                  headerStyle: DateRangePickerHeaderStyle(
                    backgroundColor: bgColor,
                    textStyle: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                  ),
                  monthViewSettings: DateRangePickerMonthViewSettings(
                    viewHeaderStyle: DateRangePickerViewHeaderStyle(
                      textStyle: TextStyle(color: textColor.withValues(alpha: 0.7)),
                    ),
                  ),
                  monthCellStyle: DateRangePickerMonthCellStyle(
                    textStyle: TextStyle(color: textColor),
                    todayTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryPurple),
                  ),
                  selectionColor: AppColors.primaryPurple,
                  startRangeSelectionColor: AppColors.primaryPurple,
                  endRangeSelectionColor: AppColors.primaryPurple,
                  rangeSelectionColor: AppColors.primaryPurple.withValues(alpha: 0.15),
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                    if (args.value is PickerDateRange) {
                      selectedRange = args.value as PickerDateRange;
                    }
                  },
                  selectionMode: DateRangePickerSelectionMode.range,
                  initialSelectedRange: initialRange,
                  maxDate: DateTime.now(),
                ),
              ),
              const SizedBox(height: Dimens.space8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.space12, vertical: Dimens.space8),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      Navigator.pop(context, const PickerDateRange(null, null));
                    },
                    child: const Text(
                      'Clear',
                      style: TextStyle(
                        color: AppColors.errorColor,
                        fontSize: Dimens.fontSize12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: Dimens.space10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryPurple,
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.space16, vertical: Dimens.space8),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimens.radius6),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, selectedRange);
                    },
                    child: const Text(
                      'Apply',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: Dimens.fontSize12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
